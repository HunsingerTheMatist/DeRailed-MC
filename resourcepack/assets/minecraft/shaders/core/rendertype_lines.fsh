#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:fog.glsl>
#include <minecraft:dynamictransforms.glsl>
#include <minecraft:oit.glsl>

// Lines are drawn as vanilla draws them, but the block highlight, black at an
//  alpha of 102, grows more opaque as night falls, up to 'NIGHT_ALPHA', so
//  less of what lies behind it shows through the dark 'night' leaves around
//  its lines
// How dark it is is taken from the fog colour, which the game dimension's day
//  fades from a strongest channel of 1 to black

const float NIGHT_ALPHA = 0.75;

layout(location = 0) in float sphericalVertexDistance;
layout(location = 1) in float cylindricalVertexDistance;
layout(location = 2) in vec4 vertexColor;

#ifndef OIT_ALPHA_ONLY
layout(location = 0) out vec4 fragColor;
#endif

vec4 calculateFinalColor(vec4 color) {
    #ifdef OIT_ACCUMULATE
    color = sampleColorForAccumulation(color);
    vec4 fogColor = vec4(FogColor.rgb * color.a, FogColor.a);
    #else
    vec4 fogColor = FogColor;
    #endif
    return apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, fogColor);
}

void main() {
    vec4 color = vertexColor * ColorModulator;
    if (vertexColor.rgb == vec3(0.0) && round(vertexColor.a * 255.0) == 102.0) {
        float night = clamp(1.0 - max(max(FogColor.r, FogColor.g), FogColor.b), 0.0, 1.0);
        color.a = mix(vertexColor.a, NIGHT_ALPHA, night) * ColorModulator.a;
    }
    #ifdef OIT_ALPHA_ONLY
    executeAlphaOnlyPhase(gl_FragCoord.z, color.a);
    #else
    fragColor = calculateFinalColor(color);
    #endif
}
