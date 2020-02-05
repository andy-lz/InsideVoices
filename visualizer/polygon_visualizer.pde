import java.util.Random;

ArrayList<MovingNode> nodes;
float maxDistance = 65;
float dx = 10;
float dy = 30;
float maxNeighbors = 15;
AudioAnalyzer a;
float audioThreshold = 0.001;
float amplitude;
float[] spectrum;
Boolean drawMode = true;
Random random_no;


void setup_poly() {
  background(255,255,255);
  nodes = new ArrayList<MovingNode>();
  a = new AudioAnalyzer(this);
  random_no = new Random();
}

void draw_poly() {
  
  background(255, 255, 255);
  a.analyze();
  amplitude = a.get_amplitude();
  spectrum = a.get_spectrum();

  for(int i=0; i < spectrum.length; i ++) {
    if (spectrum[i] > audioThreshold) {
      addNewNode(width / a.bands * i * 8, height / 2, 
        random(-dx, dx),random(-dy* spectrum[i] * 100, dy * spectrum[i] * 100));
    }
  }
 
  for(int i=0; i<nodes.size(); i++) {
    MovingNode currentNode = nodes.get(i);
    currentNode.setNumNeighbors( countNumNeighbors(currentNode,maxDistance) );
  }
  
  for(int i=0; i<nodes.size(); i++) {
    MovingNode currentNode = nodes.get(i);
    if(currentNode.x > width || currentNode.x < 0 || currentNode.y > height || currentNode.y < 0) {
      nodes.remove(currentNode);
    }
  }
  
  // O(n^2) line drawing between nodes
  for(int i = 0; i < nodes.size(); i++) {
    MovingNode currentNode = nodes.get(i);
    for(int j=0; j<currentNode.neighbors.size(); j++) {
      MovingNode neighborNode = currentNode.neighbors.get(j);
      //float lineColor = currentNode.calculateLineColor(neighborNode,maxDistance);
      float lineColor = currentNode.calculateLineColor_decay(neighborNode);
      stroke(lerpColor(color(100, 100, 255), color(255, 50, 50), 
             lineColor / currentNode.lineColorRange));
      strokeWeight(lineColor/ 2 / pow(currentNode.lineColorRange, 0.75)); 
      line(currentNode.x,currentNode.y,neighborNode.x,neighborNode.y);
    }
    currentNode.display();
  }
}


void addNewNode(float xPos, float yPos, float dx, float dy) {
  MovingNode node = new MovingNode(xPos+dx, yPos+dy);
  //MovingNode node = new MovingNode(xPos, yPos);
  node.setNumNeighbors(countNumNeighbors(node, maxDistance));
  if(node.numNeighbors < maxNeighbors) {
    nodes.add(node);
  }
}

int countNumNeighbors(MovingNode nodeA, float maxNeighborDistance) {
  int numNeighbors = 0;
  nodeA.clearNeighbors();
  for(int i = 0; i < nodes.size(); i++) {
    MovingNode nodeB = nodes.get(i);
    float distance = sqrt((nodeA.x-nodeB.x)*(nodeA.x-nodeB.x) + (nodeA.y-nodeB.y)*(nodeA.y-nodeB.y));
    if(distance < maxNeighborDistance) {
      numNeighbors++;
      nodeA.addNeighbor(nodeB);
    }
  }
  return numNeighbors;
}

class MovingNode {
  float x;
  float y;
  int numNeighbors;
  int time_alive = 0;
  ArrayList<MovingNode> neighbors;
  float lineColor;
  float nodeWidth = 1;
  float nodeHeight = 1;
  float fillColor = 50;
  float lineColorRange = 120;
  
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
    ellipse(x,y,nodeWidth,nodeHeight);
  }
  
  void move() {
    xAccel = (float) random_no.nextGaussian() * accelValue / 2;
    yAccel = (float) random_no.nextGaussian() * accelValue / 2;
    
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
    int max_time_alive = max(neighborNode.time_alive, this.time_alive);
    lineColor = max(lineColorRange - max_time_alive, 0);
    return lineColor;
  }
}
