// Dynamic phosphor saturation for Ghostty
// Works with any input colour.

// Overall effect strength (0.0–1.0).
const float INTENSITY = 1.0;

// Saturation multiplier for dim pixels.
// 1.0 = unchanged; 1.5 = 50% more saturated.
const float SHADOW_SATURATION = 1.4;

// Saturation multiplier for bright pixels.
// 0.0 = white; 1.0 = unchanged.
const float HIGHLIGHT_SATURATION = 0.35;

// Brightness where highlight desaturation begins.
const float HIGHLIGHT_THRESHOLD = 0.45;

// Brightness where highlight desaturation reaches maximum.
const float PEAK_THRESHOLD = 0.95;

// Controls the response curve.
// Higher values delay the transition towards highlights.
const float GAMMA = 1.0;

float luminance(vec3 color) {
    return dot(
        color,
        vec3(0.2126, 0.7152, 0.0722)
    );
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 original = texture(iChannel0, uv);

    float brightness = luminance(original.rgb);
    float level = pow(brightness, GAMMA);

    // Smoothly transition from shadow to highlight behaviour.
    float transition = smoothstep(
        HIGHLIGHT_THRESHOLD,
        PEAK_THRESHOLD,
        level
    );

    float saturation = mix(
        SHADOW_SATURATION,
        HIGHLIGHT_SATURATION,
        transition
    );

    // Adjust saturation around perceived luminance.
    vec3 grey = vec3(brightness);

    vec3 adjusted = mix(
        grey,
        original.rgb,
        saturation
    );

    // Blend with original image.
    vec3 color = mix(
        original.rgb,
        adjusted,
        INTENSITY
    );

    fragColor = vec4(
        clamp(color, 0.0, 1.0),
        original.a
    );
}
