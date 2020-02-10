# InsideVoices

An audio visualizer written in Processing Java, with a comprehensive, efficient engine for audio analysis. Built for UChicago ARTV 10300.

## AudioAnalyzer

The AudioAnalyzer class allows for FFT/spectral analysis of a given input signal, with functionality built for live microphone input and preset audio files. 

## Polygon Visualizer

The Polygon Visualizer provides an engine for visualizing audio using polygon graphics, utilizing an efficient linked-list, Node-based data structure. 

### Node Generation

Nodes are points in (X,Y) space with position, velocity, acceleration, neighbor-node, and life-span attributes. Nodes are generated with random variation according to signal output from the AudioAnalyzer class. Each Node follows an Euler approximation of integrated Brownian motion in X/Y dimensions, with velocity/acceleration adjusted by drift according to signal output. 

### Polygon Generation

Polygons are generated through a k-nearest-neighbor algorithm, updating every Node in real-time. Lines are drawn between nearest neighbor Nodes and exhibit alpha decay according to the lifespan of the longest living Node, i.e. each line's colors transition from red to transparent using linear interpolation. 


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
