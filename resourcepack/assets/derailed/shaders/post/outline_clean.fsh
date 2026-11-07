#version 330
#extension GL_ARB_separate_shader_objects : require

// Copies the outline buffer without the light markers' data, the first 136
//  pixels of its top and bottom rows, so the outline drawn from it does not
//  show them

uniform sampler2D InSampler;

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

void main() {
    ivec2 size = textureSize(InSampler, 0);
    ivec2 pixel = ivec2(texCoord * vec2(size));
    if (pixel.x < 136 &&(pixel.y == 0 || pixel.y == size.y - 1)) {
        fragColor = vec4(0.0);
        return;
    }
    fragColor = texelFetch(InSampler, pixel, 0);
}
