shader_type canvas_item;

uniform float seed;
uniform vec3 color_tint;
const float DISTORTION_AMOUNT = 0.2;

// 2D Random
float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))
                 * 43758.5453123);
}

// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

void fragment() {
  float dx = noise(vec2(UV.x*3.0 + seed, UV.y*3.0 + (TIME + seed)*3.0));
  float dy = noise(vec2(UV.y*3.0 + seed, UV.x*3.0 + (TIME + seed)*3.0));

  COLOR = texture(TEXTURE, UV.xy + vec2(dx, dy)*DISTORTION_AMOUNT - DISTORTION_AMOUNT/2.0);

  COLOR.rgb = mix(COLOR.rgb, color_tint, 0.5);
}
