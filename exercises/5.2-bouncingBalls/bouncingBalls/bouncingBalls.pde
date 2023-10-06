ArrayList<ball> balls = new ArrayList<ball>();
int time = millis();

void setup() {
  size(1000, 1000);
  background(0, 0, 0);
  frameRate(30);
  noStroke();
  fill(255, 255, 255);
  ball b = new ball(new PVector(0, 0), new PVector(0, 0), 6, 5, 20);
  balls.add(b);
  
  time = millis();
}

void draw() {
  float elapsedTime = millis() - time;
  println(elapsedTime);
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
  float speed;
  float attraction;
  int size;
  ball(PVector Location, PVector Direction, float Speed, float Attraction, int Size) {
    location = Location;
    direction = Direction;
    speed = Speed;
    attraction = Attraction;
    size = Size;
  }
  
  void update(float elapsedTime) {
      //first basic following of the mouse
      PVector newDirection = new PVector(location.x - mouseX, location.y - mouseY);
      newDirection.normalize();
      direction = newDirection;
      location =  location.sub(direction.mult(speed * elapsedTime / 33));
      //location.x = location.x - direction.x * speed;
      //location.y = location.y - direction.y * speed;
  }
  void draw() {
     circle(location.x, location.y, size); 
  }
}
