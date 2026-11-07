#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:dynamictransforms.glsl>

// A light marker's pixel holds the data 'rendertype_outline.vsh' worked out
//  for it; anything else glowing is drawn in its glow colour as vanilla draws it

uniform sampler2D Sampler0;

layout(location = 0) in vec4 vertexColor;
layout(location = 1) in vec2 texCoord0;
layout(location = 2) flat in int isMarker;
layout(location = 3) flat in vec3 markerData;

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);
    if (color.a == 0.0) {
        discard;
    }
    if (isMarker == 1) {
        fragColor = vec4(markerData, 1.0);
        return;
    }
    fragColor = vec4(ColorModulator.rgb * vertexColor.rgb, ColorModulator.a);
}
