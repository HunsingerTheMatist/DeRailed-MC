#version 330
#extension GL_ARB_separate_shader_objects : require

// Darkens the world by how dark the night is, but where the light markers'
//  lights reach: each lights everything within its radius of it, fully out to
//  'FULL' of the radius and fading smoothly to nothing at the radius, the
//  strongest light on a pixel being what it gets. The markers' data is read
//  from the bottom row of the outline buffer, laid out as
//  'rendertype_outline.vsh' says
// A pixel's place is worked out from its depth through the projection the
//  markers pass on; the sky, at depth 0, is left as it is
// Depth runs from 1 at the near plane to 0 far away. A projection whose depth
//  runs 0 to 1 has m22 near 0, and one whose depth runs -1 to 1 has it just
//  over 1

uniform sampler2D MainSampler;
uniform sampler2D MainDepthSampler;
uniform sampler2D OutlineSampler;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
};

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

const int LIGHTS = 32;
const float FULL = 0.5;

int row;
float m00;
float m11;
float m22;
float m32;
bool zeroToOne;

vec3 fetch(int column) {
    return round(texelFetch(OutlineSampler, ivec2(column, row), 0).rgb * 255.0);
}

float decode(int column, float range) {
    vec3 c = fetch(column);
    return (c.r * 65536.0 + c.g * 256.0 + c.b) / 16777215.0 * 2.0 * range - range;
}

bool checks(int r) {
    vec3 c = round(texelFetch(OutlineSampler, ivec2(4, r), 0).rgb * 255.0);
    return c == vec3(51.0, 102.0, 153.0);
}

// Where a pixel is, as the camera sees it
vec3 seenAt(vec2 uv, float depth) {
    float z = zeroToOne ? depth : depth * 2.0 - 1.0;
    float seenZ = -m32 / (z + m22);
    vec2 ndc = uv * 2.0 - 1.0;
    if (row != 0) {
        ndc.y = -ndc.y;
    }
    return vec3(ndc.x * -seenZ / m00, ndc.y * -seenZ / m11, seenZ);
}

float litAt(vec3 seen) {
    float lit = 0.0;
    for (int n = 0; n < LIGHTS; n++) {
        int column = 8 + n * 4;
        vec3 flag = fetch(column + 3);
        if (flag.g != 255.0 || flag.r <= 0.0) {
            continue;
        }
        vec3 light = vec3(decode(column, 512.0), decode(column + 1, 512.0), decode(column + 2, 512.0));
        lit = max(lit, 1.0 - smoothstep(FULL, 1.0, length(seen - light) / flag.r));
    }
    return lit;
}

void main() {
    vec4 color = texture(MainSampler, texCoord);
    float depth = texture(MainDepthSampler, texCoord).r;

    // The row the markers wrote: the bottom one, or the top one where the
    //  buffer is upside down from how they wrote it
    int top = textureSize(OutlineSampler, 0).y - 1;
    row = checks(0) ? 0 : (checks(top) ? top : -1);
    if (row < 0 || depth <= 0.0) {
        fragColor = color;
        return;
    }

    float night = fetch(5).r / 255.0;
    m00 = decode(0, 8.0);
    m11 = decode(1, 8.0);
    m22 = decode(2, 8.0);
    m32 = decode(3, 8.0);
    zeroToOne = m22 < 0.5;

    float lit = litAt(seenAt(texCoord, depth));
    fragColor = vec4(color.rgb * (1.0 - night * (1.0 - lit)), 1.0);
}
