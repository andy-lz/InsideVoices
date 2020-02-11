// Visualizer Parent
//    Wrapper for all visualizers -- plays them according to FLAGs.

int POLY_FLAG = 1;
int TEST_FLAG = 0;
int MIC_FLAG = 1;

AudioAnalyzer a;
String audio_path = "back_in_black.mp3";

void setup() {
  size(1200, 600, P2D);
  smooth(8);
  pixelDensity(2);
  if (MIC_FLAG == 0) {
    a = new AudioAnalyzer(this, audio_path);
  } else {
    a = new AudioAnalyzer(this);
  }
  
  if (POLY_FLAG > 0) {
    setup_poly(MIC_FLAG);
  } else if (TEST_FLAG > 0) {
    setup_test(MIC_FLAG); // setup for AudioAnalyzer test
  }
  
  
}

void draw() {
  if (POLY_FLAG > 0) {
    draw_poly();
  }
  else if (TEST_FLAG > 0) {
    draw_test(); // test draw_spectrum() and get() methods in AudioAnalyzer
  } 
}

void mousePressed() {
  // get Timer Diagnostics
  if (timer != null){
    println(timer.get_average_times());
  }
}
