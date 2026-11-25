// Colour fringing for Ghostty
// Simulates slight RGB channel misalignment.

// Strength of the effect (0.0–1.0).
const float INTENSITY = 0.35;

// Horizontal separation of colour channels in pixels.
const float SPREAD = 0.75;

// Vertical separation in pixels.
const float VERTICAL = 0.0;

// Preserve original luminance to reduce colour distortion.
const float LUMINANCE_PRESERVATION = 0.5;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec2 texel = 1.0 / iResolution.xy;

    vec4 original = texture(iChannel0, uv);

    vec2 offset = vec2(
        SPREAD * texel.x,
        VERTICAL * texel.y
    );

    // Shift red and blue in opposite directions.
    float red = texture(
        iChannel0,
        uv + offset
    ).r;

    float green = original.g;

    float blue = texture(
        iChannel0,
        uv - offset
    ).b;

    vec3 fringed = vec3(red, green, blue);

    // Preserve some of the original perceived brightness.
    float originalLuma = dot(
        original.rgb,
        vec3(0.2126, 0.7152, 0.0722)
    );

    float fringedLuma = dot(
        fringed,
        vec3(0.2126, 0.7152, 0.0722)
    );

    vec3 corrected = fringed * (
        originalLuma /
        max(fringedLuma, 0.0001)
    );

    fringed = mix(
        fringed,
        corrected,
        LUMINANCE_PRESERVATION
    );

    vec3 color = mix(
        original.rgb,
        fringed,
        INTENSITY
    );

    fragColor = vec4(
        clamp(color, 0.0, 1.0),
        original.a
    );
}
