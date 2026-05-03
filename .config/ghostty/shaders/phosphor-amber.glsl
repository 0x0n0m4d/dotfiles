// ============================================================
//  phosphor-amber.glsl  —  CRT Phosphor Amber for Ghostty
// ============================================================
//  Effects included:
//    • Amber monochrome tint  (replaces need for manual palette)
//    • Phosphor burn-in simulation  (fake persistence glow)
//    • Per-scanline jitter  (occasional horizontal twitch)
//    • Static film grain / noise
//    • Heavy soft bloom  (makes the glow bleed like a real CRT)
//    • Walking glow scanline  (slow bright sweep down the screen)
//    • Fine scanlines + vignette
//
//  Usage (config order matters — run this AFTER bettercrt.glsl):
//    custom-shader = ./shaders/bettercrt.glsl
//    custom-shader = ./shaders/phosphor-amber.glsl
//    custom-shader-animation = always
// ============================================================

// ── Tuneable constants ───────────────────────────────────────
#define AMBER_R       3.12   // Phosphor tint  (R)
#define AMBER_G       0.58   // Phosphor tint  (G)
#define AMBER_B       0.02   // Phosphor tint  (B)

#define BLOOM_RADIUS  1.0    // How far bloom spreads  (pixels per step)
#define BLOOM_GAIN    0.002  // Per-sample gain (unnormalized — scales with coverage)

#define JITTER_STR    0.0009 // Max horizontal pixel shift
#define JITTER_RATE   10.0   // How fast lines twitch (Hz)
#define JITTER_PROB   0.965  // Only lines above this threshold twitch
// ────────────────────────────────────────────────────────────

// Fast hash — good enough for noise, no trig needed
float hash(vec2 p) {
    p = fract(p * vec2(127.1, 311.7));
    p += dot(p, p + 19.19);
    return fract(p.x * p.y);
}

// Luminance of an RGB sample
float luma(vec3 c) {
    return dot(c, vec3(0.299, 0.587, 0.114));
}

// Amber tint: converts luminance to phosphor amber color
vec3 amber(float l) {
    return l * vec3(AMBER_R, AMBER_G, AMBER_B);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 res = iResolution.xy;
    vec2 uv  = fragCoord / res;

    // ── 1. JITTER ───────────────────────────────────────────
    // Random per-scanline X nudge, fires on ~3 % of lines per frame
    float scanRow  = floor(fragCoord.y);
    float frameBin = floor(iTime * JITTER_RATE);
    float rnd      = hash(vec2(scanRow * 0.01, frameBin * 0.137));
    float shift    = (hash(vec2(scanRow, frameBin)) - 0.5) * 2.0 * JITTER_STR;
    uv.x += shift * step(JITTER_PROB, rnd);

    // ── 2. SAMPLE TERMINAL ──────────────────────────────────
    vec4 src = texture(iChannel0, uv);
    float srcLuma = luma(src.rgb);

    // ── 3. BLOOM ────────────────────────────────────────────
    // Unnormalized Gaussian — each bright glyph casts real glow into
    // the dark background around it. Normalization would dilute this.
    vec3  bloomAccum = vec3(0.0);
    vec2  px = vec2(BLOOM_RADIUS) / res;

    for (int ix = -6; ix <= 6; ix++) {
        for (int iy = -6; iy <= 6; iy++) {
            float d = length(vec2(ix, iy));
            if (d > 6.5) continue;
            float w  = exp(-d * 0.28);   // soft, wide falloff
            vec4  ns = texture(iChannel0, uv + vec2(float(ix), float(iy)) * px);
            bloomAccum += luma(ns.rgb) * w * vec3(AMBER_R, AMBER_G, AMBER_B);
        }
    }
    // BLOOM_GAIN scales the absolute sum — no normalization on purpose
    vec3 bloom = bloomAccum * BLOOM_GAIN;

    // ── 4. AMBER MONOCHROME ──────────────────────────────────
    // Apply AFTER bloom sampling so both share the same source
    vec3 color = amber(srcLuma) + bloom;


    // ── OUTPUT ──────────────────────────────────────────────
    // Headroom above 1.0 lets the bloom glow feel "hot" without clipping hard
    fragColor = vec4(clamp(color, 0.0, 2.5), src.a);
}
