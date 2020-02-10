// This is a test file
import processing.sound.*;
float[] spectrum_test;
String audio_path_test = "back_in_black.mp3";

void setup_test(int MIC_FLAG) {
  // see visualizer -> setup()
}

void draw_test() {
  // update audio analysis for each draw()
  a.analyze();
  // visualize spectrum
  a.draw_spectrum(0,512);
  // you can get the spectrum (a float array of values) using get_spectrum() method
  spectrum_test = a.get_spectrum();
  // you can get average amplitude (float from 0 to 1) using get_amplitude() method
  println(a.get_amplitude());
}
