// Cool white monochrome filter for Ghostty
// Inspired by late CRT terminals and monochrome LCD displays.

const vec3 COOL_WHITE = vec3(0.75, 0.85, 1.0);
const float INTENSITY = 1.0;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 original = texture(iChannel0, uv);

    float luminance = dot(
        original.rgb,
        vec3(0.2126, 0.7152, 0.0722)
    );

    vec3 phosphor = COOL_WHITE * luminance;
    vec3 color = mix(original.rgb, phosphor, INTENSITY);

    fragColor = vec4(color, original.a);
}
