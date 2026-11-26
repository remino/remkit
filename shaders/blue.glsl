// Blue monochrome filter for Ghostty
// Inspired by icy CRTs and classic sci-fi computer displays.

const vec3 BLUE = vec3(0.20, 0.48, 1.0);
const float INTENSITY = 1.0;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 original = texture(iChannel0, uv);

    float luminance = dot(
        original.rgb,
        vec3(0.2126, 0.7152, 0.0722)
    );

    vec3 phosphor = BLUE * luminance;
    vec3 color = mix(original.rgb, phosphor, INTENSITY);

    fragColor = vec4(color, original.a);
}
