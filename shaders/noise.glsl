// Animated film grain / analogue noise for Ghostty

// INTENSITY
// 0.035
// Noise strength
//
// SPEED
// 24.0
// Noise refreshes per second
//
// GRAIN_SIZE
// 1.0
// Grain size in pixels

// Ghostty config example
// custom-shader = ~/.config/ghostty/shaders/amber.glsl
// custom-shader = ~/.config/ghostty/shaders/noise.glsl
// custom-shader-animation = true

const float INTENSITY = 0.035;
const float SPEED = 24.0;
const float GRAIN_SIZE = 1.0;

// Pseudorandom noise
float hash(vec3 p) {
    p = fract(p * 0.1031);
    p += dot(p, p.yzx + 33.33);
    return fract((p.x + p.y) * p.z);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 original = texture(iChannel0, uv);

    // Quantise time to control noise refresh rate
    float frame = floor(iTime * SPEED);

    // Quantise position to control grain size
    vec2 pixel = floor(fragCoord / GRAIN_SIZE);

    // Generate noise in the range [-1, 1]
    float noise = hash(vec3(pixel, frame)) * 2.0 - 1.0;

    // Apply monochromatic noise
    vec3 color = original.rgb + noise * INTENSITY;

    fragColor = vec4(clamp(color, 0.0, 1.0), original.a);
}
