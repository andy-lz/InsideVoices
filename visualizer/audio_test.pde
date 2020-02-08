// This is a test file
import processing.sound.*;
float[] spectrum_test;
AudioAnalyzer a_test;
String audio_path_test = "back_in_black.mp3";

void setup_test(int MIC_FLAG) {
  if (MIC_FLAG == 0) {
    a_test = new AudioAnalyzer(this, audio_path_test);
  } else {
    a_test = new AudioAnalyzer(this, (int) pow(2,12));
  }
  
}

void draw_test() {
  a_test.analyze();
  a_test.draw_spectrum(0,512);
  spectrum_test = a_test.get_spectrum();
  println(a_test.get_amplitude());
}
