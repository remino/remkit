# Shaders

I basically made most of them with Codex for Ghostty. Some examples below.

## Ghostty

The monochrome colour shaders are mutually exclusive: choose one in your Ghostty
config, then layer the optional CRT effects around it.

Available phosphor colours:

- `amber.glsl` — classic amber
- `green.glsl` — DEC/green-screen phosphor
- `cool-white.glsl` — late CRT or monochrome LCD
- `cyan.glsl` — cool early-80s phosphor
- `red.glsl` — red phosphor / cyberpunk
- `blue.glsl` — icy sci-fi display

### Glowing Amber

```ini
custom-shader = ~/.config/ghostty/shaders/horizontal-jitter.glsl
custom-shader = ~/.config/ghostty/shaders/noise.glsl
custom-shader = ~/.config/ghostty/shaders/amber.glsl
custom-shader = ~/.config/ghostty/shaders/phosphor-saturation.glsl
custom-shader = ~/.config/ghostty/shaders/softness.glsl
custom-shader = ~/.config/ghostty/shaders/bleeding.glsl
custom-shader = ~/.config/ghostty/shaders/glow.glsl
custom-shader = ~/.config/ghostty/shaders/phosphor.glsl
custom-shader = ~/.config/ghostty/shaders/uneven-brightness.glsl
custom-shader = ~/.config/ghostty/shaders/shadow-mask.glsl

custom-shader-animation = true
```

To use another colour, replace the `amber.glsl` line with one of the presets,
for example:

```ini
custom-shader = ~/.config/ghostty/shaders/green.glsl
```

### CRT

```ini
custom-shader = ~/.config/ghostty/shaders/horizontal-jitter.glsl
custom-shader = ~/.config/ghostty/shaders/noise.glsl
custom-shader = ~/.config/ghostty/shaders/fringing.glsl
custom-shader = ~/.config/ghostty/shaders/softness.glsl
custom-shader = ~/.config/ghostty/shaders/bleeding.glsl
custom-shader = ~/.config/ghostty/shaders/glow.glsl
custom-shader = ~/.config/ghostty/shaders/phosphor.glsl
custom-shader = ~/.config/ghostty/shaders/uneven-brightness.glsl
custom-shader = ~/.config/ghostty/shaders/shadow-mask.glsl

custom-shader-animation = true
```
