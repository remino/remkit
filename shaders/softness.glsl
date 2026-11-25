// Subpixel softness for Ghostty
// Horizontal filtering without vertical blur

const float SOFTNESS = 0.25;
const float SPREAD = 0.75;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec2 texel = 1.0 / iResolution.xy;

    vec4 original = texture(iChannel0, uv);

    // Sample neighbouring pixels horizontally
    vec3 left = texture(
        iChannel0,
        uv - vec2(texel.x * SPREAD, 0.0)
    ).rgb;

    vec3 right = texture(
        iChannel0,
        uv + vec2(texel.x * SPREAD, 0.0)
    ).rgb;

    // Three-tap horizontal filter
    vec3 softened = (
        left * 0.25 +
        original.rgb * 0.5 +
        right * 0.25
    );

    // Blend with the original image
    vec3 color = mix(
        original.rgb,
        softened,
        SOFTNESS
    );

    fragColor = vec4(color, original.a);
}
