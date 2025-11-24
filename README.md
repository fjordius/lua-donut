# 🍩 The Spinning Donut in Lua

A pure Lua port of the famous spinning donut code!

> "Math is beautiful, and donuts are delicious."

## What is this?

This is a single-file Lua script that renders a 3D spinning torus (donut) in your terminal using ASCII characters. It calculates the 3D projection and illumination of the donut surface in real-time without any external graphics libraries.

## How to run it

You need Lua installed on your machine.

```bash
lua donut.lua
```

Make sure your terminal supports ANSI escape codes (most modern terminals like Windows Terminal, iTerm2, Alacritty, etc., do).

## How it works

The code iterates through angles theta and phi to generate points on the surface of a torus. It then:
1. Rotates the points in 3D space (Axis A and B).
2. Projects the 3D points onto a 2D plane (your screen).
3. Calculates the luminance (lighting) based on the surface normal.
4. Renders the corresponding ASCII character to a buffer.
5. Flushes the buffer to stdout using ANSI codes to reset the cursor position for smooth animation.

## License

MIT. Use it, share it, eat it (virtually).
