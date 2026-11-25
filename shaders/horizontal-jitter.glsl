// Horizontal jitter for Ghostty
// Simulates intermittent horizontal signal instability.

// Maximum horizontal displacement in physical pixels.
const float INTENSITY = 1.5;

// Probability of a jitter event per time interval (0.0–1.0).
const float FREQUENCY = 0.08;

// Number of horizontal regions across the display.
// Higher values produce thinner jitter bands.
const float BANDS = 120.0;

// Duration of each jitter interval in seconds.
const float INTERVAL = 0.05;

// Probability that neighbouring bands share displacement.
// 0.0 = independent bands; 1.0 = broad disturbances.
const float COHERENCE = 0.65;

// Seed for the random jitter pattern.
const float SEED = 17.0;

float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    // Quantise time into short intervals.
    float tick = floor(iTime / INTERVAL);

    // Divide the screen into horizontal bands.
    float band = floor(uv.y * BANDS);

    // Generate broad and fine disturbance patterns.
    float broadBand = floor(
        band / mix(1.0, 12.0, COHERENCE)
    );

    float event = hash(vec2(
        broadBand + SEED,
        tick
    ));

    float displacement = 0.0;

    if (event < FREQUENCY) {
        // Random displacement between -1 and 1.
        float direction = hash(vec2(
            broadBand + SEED * 2.0,
            tick + 31.0
        )) * 2.0 - 1.0;

        // Add slight variation between individual bands.
        float variation = hash(vec2(
            band + SEED,
            tick + 73.0
        )) * 2.0 - 1.0;

        displacement = mix(
            variation,
            direction,
            COHERENCE
        ) * INTENSITY;
    }

    // Shift sampling horizontally.
    vec2 shiftedUV = uv - vec2(
        displacement / iResolution.x,
        0.0
    );

    shiftedUV = clamp(
        shiftedUV,
        vec2(0.0),
        vec2(1.0)
    );

    fragColor = texture(iChannel0, shiftedUV);
}
