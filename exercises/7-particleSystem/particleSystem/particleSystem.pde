ArrayList<particle> particles = new ArrayList<particle>();
PImage particleImage = new PImage();
int particleSize = 300;
float time = 0.0;
float timeSinceLastSpawn = 0.0;
float spawDiff = 300;

void setup() {
  size(1000, 1000);
  noStroke();
  background(0, 0, 0);
  particleImage = loadImage("blackSmoke24.png");
  imageMode(CENTER);

  time = millis();
}


void draw() {
  background(0, 0, 0);
  float elapsedTime = millis() - time;
  time = millis();
  timeSinceLastSpawn += elapsedTime;
  
  if(timeSinceLastSpawn >= spawDiff) {
    particle p = new particle();
    particles.add(p);
    timeSinceLastSpawn = 0;
  }
  
  PVector mouse =  new PVector(mouseX, mouseY);
  PVector wind = new PVector(width/2, height/2).sub(mouse);

  pushMatrix();
  translate(width/2, height/2);
  fill(255, 0, 0);
  stroke(255, 255, 255);
  line(0, 0, wind.x, 0);
  circle(0, 0, 10);
  popMatrix();

  ArrayList<particle> newParticles = particles;
  for(int i = 0; i < particles.size(); i++) {
   int r = particles.get(i).update(elapsedTime, wind);
   particles.get(i).draw();
   if(r != 0) {
      newParticles.remove(i); 
   }
  }
  particles = newParticles;
  

}







class particle {
  float lifetime;
  PVector location;
  float xDeviation;
  particle() {
    lifetime = 0;
    xDeviation = 0;
    location = new PVector(width/2+ random(-80, 80), height+ particleSize);
  }
  int update(float elapsedTime, PVector wind) {
    lifetime += elapsedTime; 
    if(255 - lifetime / 40 < 0) {
      return 1;
    }
    
    location.y -= 3 * elapsedTime / 33;
    xDeviation +=  (wind.x) * (sq(lifetime) / 1000000000);
    println(wind.x, ", ", wind.mag(), ", ", xDeviation);
    return 0;
  }
  void draw() {
    pushMatrix();
    tint(255, 255, 255, 255 - lifetime / 40);
    image(particleImage, location.x + xDeviation, location.y, particleSize, particleSize);
    popMatrix();
  }
}
