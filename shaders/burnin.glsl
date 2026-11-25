// Conceptual code, not currently supported by Ghostty:
// https://github.com/ghostty-org/ghostty/discussions/13081

vec3 current = texture(iChannel0, uv).rgb;
vec3 previous = texture(iChannel1, uv).rgb;

float persistence = exp(-iTimeDelta / 0.12);

vec3 colour = max(current, previous * persistence);
