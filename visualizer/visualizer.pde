// Visualizer Parent
//    Wrapper for all visualizers -- plays them according to FLAGs.

import themidibus.*;

int POLY_FLAG = 0;
int TEST_FLAG = 1;
int MIC_FLAG = 1;
int MIDI_FLAG = 1; // using a MIDI controller to control visuals

AudioAnalyzer a;
MidiBus myBus; // The MidiBus
String audio_path = "back_in_black.mp3";

void setup() {
  size(1200, 600, P3D);
  smooth(8);
  // pixelDensity(2);
  if (MIC_FLAG == 0) {
    a = new AudioAnalyzer(this, audio_path);
  } else {
    a = new AudioAnalyzer(this);
  }
  if (MIDI_FLAG > 0) {
    myBus = new MidiBus(this, "Midi Fighter 64", "Midi Fighter 64"); // only use if you have the midi controller connected
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

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);

  if (pitch == 64) {  // switch to audio_test
    TEST_FLAG = 1;
    POLY_FLAG = 0;
    setup_test(MIC_FLAG);
    draw_test();
    println(POLY_FLAG, TEST_FLAG);
    
  } else if (pitch == 65) { // switch to poly_visualizer
    POLY_FLAG = 1;
    TEST_FLAG = 0;
    setup_poly(MIC_FLAG);
    print(POLY_FLAG, TEST_FLAG);
  }
  
}
