ArrayList<ball> balls = new ArrayList<ball>();
int numberOfBalls = 30;
int time = millis();
int c_3 = 0;
int c_1 = 0;
int color_change = 1;

void setup() {
  size(1000, 1000);
  background(0, 0, 0);
  frameRate(30);
  strokeWeight(7);
  for(int i = 0; i < numberOfBalls; i++) {
    ball b = new ball(12);
    balls.add(b);
  }

  
  time = millis();
}

void draw() {
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);
  stroke(c_1, 255, c_3);
  c_1 -= color_change;
  c_3 += color_change;
  if(c_3 > 255 || c_3 < 0) {
     color_change *= -1; 
  }
  float elapsedTime = millis() - time;
  //background(0, 0, 0);
  for(int i = 0; i < balls.size(); i++) {
     balls.get(i).update(elapsedTime);
     balls.get(i).draw();
  }
  time = millis();
}



class ball {
  PVector location;
  PVector lastLocation;
  PVector direction;
  float topSpeed;
  ball(float Speed) {
    location = new PVector(random(width), random(height));
    lastLocation = location;
    direction = new PVector(0, 0);
    topSpeed = Speed;
  }
  
  void update(float elapsedTime) {
      lastLocation = location.copy();
      PVector mouseDirection = new PVector(mouseX, mouseY);
      PVector dir = PVector.sub(mouseDirection, location);
      dir.normalize();
      dir.mult(0.5);
     
      
      direction.add(dir);
      
      direction.limit(topSpeed);
      if(mousePressed == false) {
        location.add(direction.copy().mult(elapsedTime / 33));
      }else{
        location.sub(direction.copy().mult(elapsedTime / 33));
      }
      checkEdges();
  }
  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
      lastLocation = location.copy();
    } else if (location.x < 0) {
      location.x = width;
      lastLocation = location.copy();
    }
 
    if (location.y > height) {
      location.y = 0;
      lastLocation = location.copy();
    }  else if (location.y < 0) {
      location.y = height;
      lastLocation = location.copy();
    }
  }
  void draw() {
     line(lastLocation.x, lastLocation.y, location.x, location.y);
  }
}
