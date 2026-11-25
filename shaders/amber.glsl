// Amber monochrome filter for Ghostty

// Classic amber
// vec3(1.0, 0.55, 0.12)
//
// Golden amber
// vec3(1.0, 0.70, 0.20)
//
// Deep orange
// vec3(1.0, 0.35, 0.05)
//
// Vintage green
// vec3(0.35, 1.0, 0.25)
//
// Cool monochrome
// vec3(0.75, 0.85, 1.0)

const vec3 AMBER = vec3(1.0, 0.55, 0.12);
const float INTENSITY = 1.0;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 original = texture(iChannel0, uv);

    // Convert RGB to perceived luminance
    float luminance = dot(
        original.rgb,
        vec3(0.2126, 0.7152, 0.0722)
    );

    // Map luminance to amber
    vec3 amber = AMBER * luminance;

    // Blend with original
    vec3 color = mix(original.rgb, amber, INTENSITY);

    fragColor = vec4(color, original.a);
}
