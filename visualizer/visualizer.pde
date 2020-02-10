int POLY_FLAG = 1;
int TEST_FLAG = 0;
int MIC_FLAG = 1;

void setup() {
  size(1200, 600);
  // pixelDensity(2);
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
