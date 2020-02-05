// This is a test file
import processing.sound.*;
float[] spectrum_test;
AudioAnalyzer a_test;

void setup_test() {
  size(600,600);
  a_test = new AudioAnalyzer(this, (int) pow(2,12));
}

void draw_test() {
  a_test.analyze();
  a_test.draw_spectrum(0,512);
  spectrum_test = a_test.get_spectrum();
  println(a_test.get_amplitude());
}
