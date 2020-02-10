import processing.sound.*;

class TimerDiagnostic {
  long[] counters;
  long[] lap_times;
  int[] count;
  int numCounters;
  
  TimerDiagnostic(int num_counters) {
    counters = new long[num_counters];
    lap_times = new long[num_counters];
    count = new int[num_counters];
    numCounters = num_counters;
  }
  
  void start(int index) {
    setLapTime(index);
  }
  
  void lap(int index) {
    long currentTime = System.nanoTime();
    counters[index] += currentTime - lap_times[index];
    count[index]++;
    setLapTime(index);
  }
  
  void setLapTime(int index) {
    lap_times[index] = System.nanoTime();
  }
  
  long get_average_time(int index) {
    if (count[index] > 0) {
      return counters[index] / count[index];
    } else {
      return 0;
    }
  }
  
  long[] get_average_times() {
    long[] average_times = new long[numCounters];
    for (int i = 0; i < numCounters; i++) {
      average_times[i] = get_average_time(i);
    }
    return average_times;
  }
}
