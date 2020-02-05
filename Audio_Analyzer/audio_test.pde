// This is a test file
import processing.sound.*;
float[] spectrum;
AudioAnalyzer a;

void setup() {
  size(600,600);
  a = new AudioAnalyzer(this, (int) pow(2,12));
}

void draw() {
  a.analyze();
  a.draw_spectrum(0,512);
  spectrum = a.get_spectrum();
  println(a.get_amplitude());
}
