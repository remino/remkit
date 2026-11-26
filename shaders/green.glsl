// Green monochrome filter for Ghostty
// Inspired by classic DEC and early green-screen terminals.

const vec3 GREEN = vec3(0.35, 1.0, 0.25);
const float INTENSITY = 1.0;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 original = texture(iChannel0, uv);

    float luminance = dot(
        original.rgb,
        vec3(0.2126, 0.7152, 0.0722)
    );

    vec3 green = GREEN * luminance;
    vec3 color = mix(original.rgb, green, INTENSITY);

    fragColor = vec4(color, original.a);
}
