import java.util.Random;
import java.util.LinkedList;
import java.util.ListIterator;

LinkedList<MovingNode> nodes;
final float maxDistance = 65;
float dx = 10;
float dy = 30;
final float maxNeighbors = 10;
float audioThreshold = 0.01;
final float spectrum_displacement = 10;
final float log_displacement = log(spectrum_displacement);
float amplitude, log_bands;
float[] spectrum;
int max_time_alive = 60;
Random random_no;  // random std Normal generator for acceleration values
TimerDiagnostic timer;


void setup_poly(int MIC_FLAG) {
  background(255,255,255);
  nodes = new LinkedList<MovingNode>();
  if (MIC_FLAG == 0) {
    audioThreshold = 0.05;
    dy /= 2;
  }
  log_bands = log(a.bands + spectrum_displacement) - log_displacement;
  random_no = new Random();
  timer = new TimerDiagnostic(2);
}

void draw_poly() {
  float lineColor;
  background(255, 255, 255);
  a.analyze();
  amplitude = a.get_amplitude();
  spectrum = a.get_spectrum();
  //timer.setLapTime(0);
  for(int i=0; i < spectrum.length; i+=2) {
    if (spectrum[i] > audioThreshold) {
      float log_i = log(i + spectrum_displacement) - log_displacement;
      for (int j = 0; j < spectrum[i] / audioThreshold; j++) {
        addNewNode(width / log_bands * log_i, height / 2, 
          random(-dx, dx), random(-dy* spectrum[i] * 100, dy * spectrum[i] * 100), 
          spectrum[i] * 2);
      }
    }
  }
  //timer.lap(0);
  //timer.setLapTime(1);
  // O(n^2) line drawing between nodes
  ListIterator<MovingNode> i = nodes.listIterator();
  while (i.hasNext()) {
    MovingNode currentNode = i.next();
    if(currentNode.x > width || currentNode.x < 0 || currentNode.y > height || currentNode.y < 0 || currentNode.time_alive > max_time_alive) {
      i.remove();
      continue;
    }
    currentNode.setNumNeighbors(countNumNeighbors(currentNode, maxDistance));
    for(MovingNode neighborNode : currentNode.neighbors) {
      //float lineColor = currentNode.calculateLineColor(neighborNode,maxDistance);
      lineColor = currentNode.calculateLineColor_decay(neighborNode);
      stroke(lerpColor_preset(lineColor / currentNode.lineColorRange));
      strokeWeight(1.5 - lineColor * 1.5 / currentNode.lineColorRange); 
      line(currentNode.x, currentNode.y, neighborNode.x, neighborNode.y);
    }
    currentNode.display();
  }
  //timer.lap(1);
}


void addNewNode(float xPos, float yPos, float dx, float dy, float move_multiplier) {
    MovingNode node = new MovingNode(xPos+dx, yPos+dy);
    //MovingNode node = new MovingNode(xPos, yPos);
    node.setNumNeighbors(countNumNeighbors(node, maxDistance));
    node.set_multiplier(move_multiplier);
    if(node.numNeighbors < maxNeighbors) {
      nodes.add(node);
  }
}

int countNumNeighbors(MovingNode nodeA, float maxNeighborDistance) {
  int numNeighbors = 0;
  nodeA.clearNeighbors();
  float d2 = maxNeighborDistance * maxNeighborDistance;
  float distance;
  for(MovingNode nodeB : nodes) {
    distance = (nodeA.x-nodeB.x)*(nodeA.x-nodeB.x) + (nodeA.y-nodeB.y)*(nodeA.y-nodeB.y);
    if(distance < d2) {
      numNeighbors++;
      nodeA.addNeighbor(nodeB);
    }
  }
  return numNeighbors;
}

color lerpColor_preset(float x) {
  color c = color(255,50 + 205*x, 50 + 205*x);
  return c;
}

class MovingNode {
  float x;
  float y;
  int numNeighbors;
  int time_alive = 0;
  ArrayList<MovingNode> neighbors;
  float lineColor;
  float nodeRadius = 1;
  float fillColor = 50;
  float lineColorRange = 120;
  float move_multiply = 1.;
  
  float xVel=0;
  float yVel=0;
  float xAccel=0;
  float yAccel=0;
  
  float accelValue = 1.5;

  MovingNode(float xPos, float yPos) {
    x = xPos;
    y = yPos;
    numNeighbors = 0;
    neighbors = new ArrayList<MovingNode>();
  }
  
  void display() {
    move();
    noStroke();
    fill(fillColor);
    circle(x,y,nodeRadius);
  }
  
  void move() {
    
    xAccel = (float) random_no.nextGaussian() * accelValue / 2 * move_multiply;
    yAccel = (float) random_no.nextGaussian() * accelValue / 2 * move_multiply;
    
    xVel += xAccel;
    yVel += yAccel;
    
    x += xVel;
    y += yVel;
    time_alive++;
  }
  
  void addNeighbor(MovingNode node) {
    neighbors.add(node);
  }
  
  void setNumNeighbors(int num) {
    numNeighbors = num;
  }
  
  void clearNeighbors() {
    neighbors = new ArrayList<MovingNode>();
  }
  
  float calculateLineColor(MovingNode neighborNode, float maxDistance) {
    float distance = sqrt((x-neighborNode.x)*(x-neighborNode.x) + (y-neighborNode.y)*(y-neighborNode.y));
    lineColor = (distance/maxDistance)*lineColorRange;
    return lineColor;
  }
  
  float calculateLineColor_decay(MovingNode neighborNode){
    int max_time_alive = max(neighborNode.time_alive, this.time_alive, 0);
    return max_time_alive;
  }
  
  void set_multiplier(float multiplier) {
    this.move_multiply = multiplier;
  }
}
