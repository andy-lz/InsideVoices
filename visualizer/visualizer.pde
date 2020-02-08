
int TEST_FLAG = 0;
int POLY_FLAG = 1;

void setup() {
  size(900, 800);
  // pixelDensity(2);
  if (TEST_FLAG > 0) {
    setup_test(); // setup for AudioAnalyzer test
  }
  if (POLY_FLAG > 0) {
    setup_poly();
  }
  
}

void draw() {
  if (TEST_FLAG > 0) {
    draw_test(); // test draw_spectrum() and get() methods in AudioAnalyzer
  } 
  if (POLY_FLAG > 0) {
    draw_poly();
  }
}
