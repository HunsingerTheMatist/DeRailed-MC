"""Minimal PNG read and write for 8-bit non-interlaced images, so texture tools
do not need Pillow installed. Reads any colour type into RGBA tuples and writes
straight RGBA."""
import struct
import zlib

PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"

# Bytes per pixel in the raw scanlines, by PNG colour type
CHANNELS = {0: 1, 2: 3, 3: 1, 4: 2, 6: 4}


def _unfilter(raw, stride, height, bpp):
    """Reverses the per-scanline filters PNG applies before compression

    `bpp` is the filter's byte offset to the pixel on the left, which is one
    byte whenever a pixel occupies less than a byte"""
    out = bytearray()
    previous = bytearray(stride)
    pos = 0
    for _ in range(height):
        filter_type = raw[pos]
        pos += 1
        line = bytearray(raw[pos:pos + stride])
        pos += stride
        for i in range(stride):
            left = line[i - bpp] if i >= bpp else 0
            up = previous[i]
            up_left = previous[i - bpp] if i >= bpp else 0
            if filter_type == 0:
                value = line[i]
            elif filter_type == 1:
                value = line[i] + left
            elif filter_type == 2:
                value = line[i] + up
            elif filter_type == 3:
                value = line[i] + (left + up) // 2
            elif filter_type == 4:
                estimate = left + up - up_left
                d_left = abs(estimate - left)
                d_up = abs(estimate - up)
                d_up_left = abs(estimate - up_left)
                if d_left <= d_up and d_left <= d_up_left:
                    value = line[i] + left
                elif d_up <= d_up_left:
                    value = line[i] + up
                else:
                    value = line[i] + up_left
            else:
                raise ValueError("unknown PNG filter type %d" % filter_type)
            line[i] = value & 0xFF
        out += line
        previous = line
    return bytes(out)


def _samples(raw, width, height, stride, channels, depth):
    """Splits unfiltered scanlines into one tuple of channel values per pixel,
    scaled to 0..255 whatever the source bit depth was"""
    if depth == 8:
        return [tuple(raw[y * stride + x * channels:y * stride + (x + 1) * channels])
                for y in range(height) for x in range(width)]
    if depth == 16:
        # Keep the high byte of each sample, which is all an 8-bit pack needs
        return [tuple(raw[y * stride + (x * channels + c) * 2] for c in range(channels))
                for y in range(height) for x in range(width)]

    # Below a byte a sample is a bit group, and only greyscale and palette
    #  images use those, so there is exactly one channel to pull out
    per_byte = 8 // depth
    mask = (1 << depth) - 1
    out = []
    for y in range(height):
        for x in range(width):
            byte = raw[y * stride + x // per_byte]
            shift = 8 - depth * (x % per_byte + 1)
            out.append(((byte >> shift) & mask,))
    return out


def read(data):
    """Decodes PNG bytes into (width, height, [(r, g, b, a), ...])"""
    if data[:8] != PNG_SIGNATURE:
        raise ValueError("not a PNG")
    pos, idat, palette, transparency = 8, bytearray(), None, None
    width = height = colour = None
    while pos < len(data):
        length, kind = struct.unpack(">I4s", data[pos:pos + 8])
        body = data[pos + 8:pos + 8 + length]
        pos += 12 + length
        if kind == b"IHDR":
            width, height, depth, colour, _, _, interlace = struct.unpack(">IIBBBBB", body)
            if interlace != 0:
                raise ValueError("interlaced PNGs are not supported")
            if depth not in (1, 2, 4, 8, 16):
                raise ValueError("odd bit depth %d" % depth)
        elif kind == b"PLTE":
            palette = [tuple(body[i:i + 3]) for i in range(0, len(body), 3)]
        elif kind == b"tRNS":
            transparency = body
        elif kind == b"IDAT":
            idat += body
        elif kind == b"IEND":
            break

    channels = CHANNELS[colour]
    bits = channels * depth
    stride = (width * bits + 7) // 8
    raw = _unfilter(zlib.decompress(bytes(idat)), stride, height, max(1, bits // 8))

    # Sub-8-bit greyscale carries a value that has to be stretched to 0..255,
    #  where a palette index is looked up as-is
    scale = 255 // ((1 << depth) - 1) if colour == 0 and depth < 8 else 1

    pixels = []
    for chunk in _samples(raw, width, height, stride, channels, depth):
        if colour == 0:
            grey = chunk[0] * scale
            pixels.append((grey, grey, grey, 255))
        elif colour == 2:
            pixels.append((chunk[0], chunk[1], chunk[2], 255))
        elif colour == 3:
            index = chunk[0]
            red, green, blue = palette[index]
            alpha = transparency[index] if transparency and index < len(transparency) else 255
            pixels.append((red, green, blue, alpha))
        elif colour == 4:
            pixels.append((chunk[0], chunk[0], chunk[0], chunk[1]))
        else:
            pixels.append(tuple(chunk))
    return width, height, pixels


def write(path, width, height, pixels):
    """Encodes RGBA tuples as an 8-bit RGBA PNG"""
    raw = bytearray()
    for y in range(height):
        raw.append(0)  # filter type 0, so the stored bytes stay the pixel values
        for x in range(width):
            raw += bytes(pixels[y * width + x])

    def chunk(kind, body):
        return (struct.pack(">I", len(body)) + kind + body
                + struct.pack(">I", zlib.crc32(kind + body) & 0xFFFFFFFF))

    out = PNG_SIGNATURE
    out += chunk(b"IHDR", struct.pack(">IIBBBBB", width, height, 8, 6, 0, 0, 0))
    out += chunk(b"IDAT", zlib.compress(bytes(raw), 9))
    out += chunk(b"IEND", b"")
    with open(path, "wb") as handle:
        handle.write(out)
