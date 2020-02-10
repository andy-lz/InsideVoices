// This is a test file
import processing.sound.*;
float[] spectrum_test;
AudioAnalyzer a_test;
String audio_path_test = "back_in_black.mp3";

void setup_test(int MIC_FLAG) {
  
  if (MIC_FLAG == 0) {
    // initialize AudioAnalyzer with local file path
    a_test = new AudioAnalyzer(this, audio_path_test);
  } else {
    // initialize AudioAnalyzer w/ microphone input, as well as number of audio bands
    // (number of bands must be a power of 2)
    a_test = new AudioAnalyzer(this, (int) pow(2,12));
  }
  
}

void draw_test() {
  // update audio analysis for each draw()
  a_test.analyze();
  // visualize spectrum
  a_test.draw_spectrum(0,512);
  // you can get the spectrum (a float array of values) using get_spectrum() method
  spectrum_test = a_test.get_spectrum();
  // you can get average amplitude (float from 0 to 1) using get_amplitude() method
  println(a_test.get_amplitude());
}
