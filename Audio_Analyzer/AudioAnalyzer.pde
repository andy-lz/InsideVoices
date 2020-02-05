import processing.sound.*;

class AudioAnalyzer extends PApplet {
  AudioIn audio_in;
  Amplitude amp;
  FFT fft;
  int input_stream = 0;
  int bands = 512;
  int smoother = 0;
  float bandwidth;
  float amplitude;
  float[] spectrum;
  float[] volume;
  PApplet base;
  
  AudioAnalyzer(PApplet sketch) {
     this.base = sketch;
     this.initialize();
     this.analyze();
  }
  
  AudioAnalyzer(PApplet sketch, int bands_num) {
     this.base = sketch;
     this.bands = bands_num;
     this.initialize();
     this.analyze();
  }
  
  AudioAnalyzer(PApplet sketch, int bands_num, int lowell_smoother) {
     this.base = sketch;
     this.bands = bands_num;
     this.smoother = lowell_smoother;
     this.initialize();
     this.analyze();
  }
  
  private void initialize() {
     // Audio Input
     this.audio_in = new AudioIn(this.base, this.input_stream);
     this.audio_in.start();
     // Amplitude calculator
     this.amp = new Amplitude(this.base);
     this.amp.input(this.audio_in);
     // Spectrum/FFT calculator
     this.fft = new FFT(this.base, this.bands);
     this.fft.input(this.audio_in);
     this.spectrum = new float[this.bands];
     this.volume = new float[this.bands];
  }
  
  private void analyze_spectrum() {
    this.fft.analyze(this.spectrum);
    if (this.smoother > 0) this.smooth_spectrum();
  }
  
  void analyze() {
    this.analyze_spectrum();
    // this.calc_volume();
    // this.calc_bandwidth();
    this.amplitude = this.amp.analyze();
  }
  
  private void calc_volume() {
    for (int i = 0; i < this.bands; i++) {
      this.volume[i] = abs(pow(this.spectrum[i],2));
    }
  }
  
  private void smooth_spectrum() {
    int window_max = this.bands - 1;
    for(int i = 0; i < this.bands; i++) {
      int count = 0;
      float avg_band = 0.;
      for (int j = max(i - this.smoother, 0); j <= min(i + this.smoother, window_max); j++){
        avg_band += this.spectrum[j];
        count++;
      }
      avg_band /= count;
      this.spectrum[i] = avg_band;
    }
  }
    
  float[] get_spectrum() {
    return this.spectrum;
  }
  
  float get_amplitude() {
    return this.amplitude;
  }
  
  float get_bandwidth() {
    return this.bandwidth;
  }
  
  float[] get_volume() {
    return this.volume;
  }
  
  void draw_spectrum(int min, int max) {
    this.base.background(255);
    for(int i = max(min, 0); i < min(max, this.bands); i++){
      // The result of the FFT is normalized
      // draw the line for frequency band i scaling it up by 5 to get more amplitude.
      this.base.line(i, this.base.height/2 , i, this.base.height/2 - this.spectrum[i]*this.base.height/2*5 );
    } 
  }
}
