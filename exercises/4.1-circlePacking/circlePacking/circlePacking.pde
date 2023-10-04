ArrayList<growingCircle> circles = new ArrayList<growingCircle>();
int counter = 0;

void setup() {
    size(100, 100);
    background(0, 0, 0);
    frameRate(30);
    noStroke();
}


void draw() {
  fill(255, 255, 255);
  float x = random(0, width);
  float y = random(0, height);
  if(collission(x, y, 5) != 0) {
    println("no circle in loop created, ", counter);
    counter += 1;
    return;
  }
  growingCircle circle = new growingCircle(x, y);
  circles.add(circle);
  for(int i = 0; i < circles.size(); i += 1) {
    circles.get(i).update();
    circle(circles.get(i).x, circles.get(i).y, circles.get(i).size);
  }
}

int collission(float x, float y, float size) {
  size = size / 2;
  for(int i = 0; i < circles.size(); i += 1) {
    if(x == circles.get(i).x && y == circles.get(i).y) {
      continue; //<>//
    }
    float test = (circles.get(i).x - x) * (x - circles.get(i).x) + (circles.get(i).y - y) * (y - circles.get(i).y);
    float distance = sqrt(test * -1);
    if(distance <= circles.get(i).size + size) {
      return 1; //<>//

    }
  }
  
  return 0;
}

class growingCircle {
  float x, y;
  float size = 0;
  boolean grow = true;
  growingCircle(float x_pos, float y_pos) {
    x = x_pos;
    y = y_pos;
  }
  void update() {
    if(grow == false) {
      return; 
    }
    if(collission(x, y, size) == 0) {
      size += 1;
    }else{
      grow = false;
    }
  }
}
