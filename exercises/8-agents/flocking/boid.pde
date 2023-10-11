

class boid {
  PVector position;
  PVector acceleration;
  PVector velocity;
  int sightRadius;
  int length;
  int maxSpeed;
  
  boid(PVector Position) {
    position = Position;
    acceleration = new PVector(0, 0);
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    sightRadius = 50;
    length = 5;
    maxSpeed = 5;
  }
  
  void update(float elapsedTime, ArrayList<boid> boids) {
    acceleration = calculateAcceleration(boids);
    move(elapsedTime);
    jumpBorders();


  }
  
  PVector calculateAcceleration(ArrayList<boid> boids) {
    // returns average velocity in sigth radius
    PVector alignment = new PVector(0, 0);
    PVector separation = new PVector(0, 0);
    int count = 0;
    for(boid b : boids) {
      float distance = position.dist(b.position);
      if ( distance > 0 && distance <= sightRadius) {
        alignment.add(b.velocity);
        separation.add(b.position);
        count++;
      }
    }
    alignment.div(count);
    separation.div(count);
    
    PVector a = alignment;
    //a.add(separation);
    return a;
  }
  
  
  void move(float elapsedTime) {
    velocity.add(acceleration);
    velocity.mult(elapsedTime / 33);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void jumpBorders() {
    if (position.x < -length) position.x = width+length;
    if (position.y < -length) position.y = height+length;
    if (position.x > width+length) position.x = -length;
    if (position.y > height+length) position.y = -length;
  }
  
  void draw() {
    // from https://processing.org/examples/flocking.html
    
    float theta = velocity.heading() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    
    fill(200, 100);
    stroke(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -length*2);
    vertex(-length, length*2);
    vertex(length, length*2);
    endShape();
    popMatrix();
  }
}
