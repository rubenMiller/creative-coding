ArrayList<growingCircle> circles = new ArrayList<growingCircle>();
int counter = 0;

void setup() {
    size(1000, 1000);
    background(0, 0, 0);
    frameRate(30);
    stroke(10);
    stroke(255, 255, 255);
    noFill();
}


void draw() {
  background(0, 0, 0);
  for(int i = 0; i < circles.size(); i += 1) {
    circles.get(i).update();
    circle(circles.get(i).x, circles.get(i).y, circles.get(i).radius * 2);
  }

  float x = random(0, width);
  float y = random(0, height);
  if(collission(x, y, 5) != 0) {
    //println("no circle in loop created, ", counter, "wanted at: ", x, ", ", y);
    counter += 1;
    return;
  }
  growingCircle circle = new growingCircle(x, y);
  circles.add(circle);

}

int collission(float x, float y, float radius) {
  if( x - radius < 0 || x + radius > width || y - radius < 0 || y + radius > height) {
    return 1;
  }
  for(int i = 0; i < circles.size(); i += 1) {
    if(x == circles.get(i).x && y == circles.get(i).y) {
      continue; //<>//
    }
    float test = sq(circles.get(i).x - x) + sq(circles.get(i).y - y);
    float distance = sqrt(test);
    if(distance < circles.get(i).radius + radius) {
      return 1; //<>//
    }
  }
  
  return 0;
}

class growingCircle {
  float x, y;
  float radius = 0;
  boolean grow = true;
  growingCircle(float x_pos, float y_pos) {
    x = x_pos;
    y = y_pos;
  }
  void update() {
    if(grow == false) {
      return; 
    }
    if(collission(x, y, radius + 0.3) == 0) {
      radius += 0.3;
    }else{
      grow = false;
    }
  }
}
