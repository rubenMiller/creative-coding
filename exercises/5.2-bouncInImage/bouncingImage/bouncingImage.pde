ArrayList<ball> balls = new ArrayList<ball>();
int numberOfBalls = 100;
int time = millis();
PImage img = new PImage();

void setup() {
  img = loadImage("./picture-astern.png");
  size(1000, 1000);
  background(0, 0, 0);
  frameRate(30);
  noStroke();
  for(int i = 0; i < numberOfBalls; i++) {
    ball b = new ball(12, 5, 10);
    balls.add(b);
  }

  
  time = millis();
}

void draw() {
  float elapsedTime = millis() - time;
  fill(0, 0, 0, 1);
  println(balls.size());
  rect(0, 0, width, height);
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
    fill(img.get(int(location.x), int(location.y)));
    circle(location.x, location.y, size); 
  }
}
