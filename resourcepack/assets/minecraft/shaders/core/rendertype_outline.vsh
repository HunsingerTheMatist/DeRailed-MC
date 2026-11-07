#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:globals.glsl>
#include <minecraft:dynamictransforms.glsl>
#include <minecraft:projection.glsl>

// Glowing entities are drawn into the outline buffer here as vanilla draws
//  them, but for a light marker, a model whose texels have an alpha of exactly
//  1/255, each face's texel naming in its red the data slot it carries, a
//  sixteenth for each. A marker's glow colour says the rest: its red how dark
//  the night is, its green which light it is, 0 to 31, and its blue the
//  light's radius in blocks
// Each face of a marker is shrunk onto one pixel of the bottom row of the
//  buffer and holds its slot's data there, for 'night' to read:
//    pixels 0 to 3    the projection's m00, m11, m22 and m32, within 8 of 0
//    pixel 4          the check colour 51, 102, 153 'night' finds the row by
//    pixel 5          how dark the night is, in red
//    pixels 8 + 4n    light n's position from the camera, as the camera sees
//     to 10 + 4n       it, x, y and z, within 512 of it
//    pixel 11 + 4n    light n's radius in red, and 255 in green
//  Numbers are 24 bits across red, green and blue

uniform sampler2D Sampler0;

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;
layout(location = 2) in vec2 UV0;

layout(location = 0) out vec4 vertexColor;
layout(location = 1) out vec2 texCoord0;
layout(location = 2) flat out int isMarker;
layout(location = 3) flat out vec3 markerData;

vec3 encode(float value, float range) {
    uint n = uint(clamp((value + range) / (2.0 * range), 0.0, 1.0) * 16777215.0);
    return vec3(float((n >> 16u) & 255u), float((n >> 8u) & 255u), float(n & 255u)) / 255.0;
}

void main() {
    vertexColor = Color;
    texCoord0 = UV0;
    isMarker = 0;
    markerData = vec3(0.0);
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vec4 texel = textureLod(Sampler0, UV0, 0.0);
    if (round(texel.a * 255.0) != 1.0) {
        return;
    }
    isMarker = 1;
    int slot = int(round(texel.r * 255.0 / 16.0));
    int light = int(round(Color.g * 255.0));
    vec3 seen = (ModelViewMat * vec4(Position, 1.0)).xyz;

    int column = 0;
    if (slot <= 3) {
        column = 8 + light * 4 + slot;
        if (slot == 0) markerData = encode(seen.x, 512.0);
        if (slot == 1) markerData = encode(seen.y, 512.0);
        if (slot == 2) markerData = encode(seen.z, 512.0);
        if (slot == 3) markerData = vec3(Color.b, 1.0, 0.0);
    } else if (slot == 4) {
        markerData = encode(ProjMat[0][0], 8.0);
    } else if (slot == 5) {
        column = 1;
        markerData = encode(ProjMat[1][1], 8.0);
    } else if (slot == 6) {
        column = 2;
        markerData = encode(ProjMat[2][2], 8.0);
    } else if (slot == 7) {
        column = 3;
        markerData = encode(ProjMat[3][2], 8.0);
    } else if (slot == 8) {
        column = 4;
        markerData = vec3(51.0, 102.0, 153.0) / 255.0;
    } else {
        column = 5;
        markerData = vec3(Color.r, 0.0, 0.0);
    }

    // The quad's corners, in turn round it anticlockwise, onto the pixel
    vec2 pixel = 2.0 / ScreenSize;
    float x0 = -1.0 + float(column) * pixel.x;
    int corner = gl_VertexIndex % 4;
    float x = (corner == 1 || corner == 2) ? x0 + pixel.x : x0;
    float y = (corner >= 2) ? -1.0 + pixel.y : -1.0;
    gl_Position = vec4(x, y, 0.0, 1.0);
}
