# InsideVoices

An audio visualizer written in Processing Java, with a comprehensive, efficient engine for audio analysis. Built for UChicago ARTV 10300.

## AudioAnalyzer

The AudioAnalyzer class allows for FFT/spectral analysis of a given input signal, with functionality built for live microphone input and preset audio files. 

## Polygon Visualizer

The Polygon Visualizer provides an engine for visualizing audio using polygon graphics, utilizing an efficient linked-list, Node-based data structure. 

### Node Generation

Nodes are points in (X,Y) space with position, velocity, acceleration, neighbor-node, and life-span attributes. Nodes are generated with random variation according to (log) signal output from the AudioAnalyzer class. Each Node follows an Euler approximation of integrated Brownian motion in X/Y dimensions, with velocity/acceleration adjusted by drift according to signal output. 

### Polygon Generation

Polygons are generated through a k-nearest-neighbor algorithm, updating every Node in real-time. Lines are drawn between nearest neighbor Nodes and exhibit alpha decay according to the lifespan of the longest living Node, i.e. each line's colors transition from red to transparent using linear interpolation. 
