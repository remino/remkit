// Phosphor glow for Ghostty

const float RADIUS = 3.0;
const float INTENSITY = 0.35;
const float THRESHOLD = 0.15;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec2 texel = 1.0 / iResolution.xy;

    vec4 original = texture(iChannel0, uv);

    vec3 glow = vec3(0.0);
    float totalWeight = 0.0;

    // Gaussian blur over neighbouring pixels
    for (int x = -4; x <= 4; x++) {
        for (int y = -4; y <= 4; y++) {
            vec2 offset = vec2(float(x), float(y));

            float weight = exp(
                -dot(offset, offset) /
                (2.0 * RADIUS * RADIUS)
            );

            vec3 sampleColor = texture(
                iChannel0,
                uv + offset * texel
            ).rgb;

            // Only bright pixels contribute to the glow
            float brightness = max(
                max(sampleColor.r, sampleColor.g),
                sampleColor.b
            );

            float contribution = smoothstep(
                THRESHOLD,
                THRESHOLD + 0.3,
                brightness
            );

            glow += sampleColor * contribution * weight;
            totalWeight += weight;
        }
    }

    glow /= totalWeight;

    // Additive blending preserves the sharp original image
    vec3 color = original.rgb + glow * INTENSITY;

    fragColor = vec4(
        clamp(color, 0.0, 1.0),
        original.a
    );
}
