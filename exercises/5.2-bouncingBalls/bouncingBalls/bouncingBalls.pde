ArrayList<ball> balls = new ArrayList<ball>();
int numberOfBalls = 30;
int time = millis();

void setup() {
  size(1000, 1000);
  background(0, 0, 0);
  frameRate(30);
  stroke(10);
  stroke(255, 255, 255);
  noFill();
  for(int i = 0; i < numberOfBalls; i++) {
    ball b = new ball(12, 5, 20);
    balls.add(b);
  }

  
  time = millis();
}

void draw() {
  float elapsedTime = millis() - time;
  background(0, 0, 0);
  for(int i = 0; i < balls.size(); i++) {
     balls.get(i).update(elapsedTime);
     balls.get(i).draw();
  }
  time = millis();
}



class ball {
  PVector location;
  PVector direction;
  float topSpeed;
  float attraction;
  int size;
  ball(float Speed, float Attraction, int Size) {
    location = new PVector(random(width), random(height));
    direction = new PVector(0, 0);
    topSpeed = Speed;
    attraction = Attraction;
    size = Size;
  }
  
  void update(float elapsedTime) {
      PVector mouseDirection = new PVector(mouseX, mouseY);
      PVector dir = PVector.sub(mouseDirection, location);
      dir.normalize();
      dir.mult(0.5);
     
      
      direction.add(dir);
      
      println(direction.mag());
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
    } else if (location.x < 0) {
      location.x = width;
    }
 
    if (location.y > height) {
      location.y = 0;
    }  else if (location.y < 0) {
      location.y = height;
    }
  }
  void draw() {
     circle(location.x, location.y, size); 
  }
}
