ArrayList<boid> boids = new ArrayList<boid>();
float time = 0.0;
int startingNumberOfBoids = 150;

void setup() {
  size(1000, 1000);
  background(0, 0);
  frameRate(30);
  
  time = millis();
  for(int i = 0; i < startingNumberOfBoids; i++ ){
    boids.add(new boid(new PVector(random(width), random(height)))); 
  }
}

void draw() {
  background(0, 0, 0);
  float elapsedTime = millis() - time;
  for(boid b : boids) {
    b.update(elapsedTime, boids);
    b.draw();
  }
  
  
  time = millis();
}
