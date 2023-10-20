
## Draft Notes

Setup:
- preferably in MADD soundproof space? Or Logan 017
- 2-3 Projectors 
- Maybe an iPad

Process:
- Audio:
  - Microphone input (one per projection)
    - Look in Cage
  - Ambient Noise
  - Retrieve frequency, amplitude, average bandwidth
  - Fine-tune ranges -- what counts as high vs. low volume/frequency 
- Fractal-noise generated movement
  - Types:
    - Perlin Noise
      - vector-based
      - node-neighbor relationships
    - Dynamic Fractal Noise
  - Threshold for movement (no movement caused by ambient noise)
  - Interactivity:
    - vector-based
      - Glow/Speed = Volume
      - Color = Average Frequency
      - Decay = Average bandwidth
    
- Noise-grid disturbance
  - Color = Volume
  - (X,Y) = some transform of Audio Spectrum
