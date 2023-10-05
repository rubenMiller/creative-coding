ArrayList<invader> invaders = new ArrayList<invader>();
int counter = 0;
float timeSinceLastSpawn = 0;
float totalTime = 0;
float elapsed = 0;

void setup(){
  size(1000, 1000);
  background(0, 0, 0);
  frameRate(30);
  noStroke();
}


void draw() {
  background(0, 0, 0);
  counter++;
  elapsed = millis() - totalTime;
  totalTime = millis();
  timeSinceLastSpawn += elapsed;
  if(counter > 30) {
     counter = 0; 
  }
  if(timeSinceLastSpawn > 500) {
    timeSinceLastSpawn = 0;
    invader newInvader = new invader(int(random(width)), -20, 20, 3, "output2/output-" + counter + ".png");
    invaders.add(newInvader);
  }
  int r = 0;
  for(int i = 0; i< invaders.size(); i++) {
    r += invaders.get(i).update();
    invaders.get(i).draw();
  }
  if( r != 0) {
    reset();
  }
}

void mouseClicked() {
  ArrayList<invader> invadersCopy = invaders;
  for(int i = 0; i< invadersCopy.size(); i++) {
    if(invadersCopy.get(i).x > mouseX || (invadersCopy.get(i).x + invadersCopy.get(i).size) < mouseX) {
      //println("invader: " + invadersCopy.get(i).x + ", " + (invadersCopy.get(i).x + invadersCopy.get(i).size) + " mouse: " + mouseX +", " + mouseY);
      continue;
    }
    if(invadersCopy.get(i).y > mouseY || invadersCopy.get(i).y + invadersCopy.get(i).size < mouseY) {
      continue;
    }
    invaders.remove(i);
  }
}

void reset() {
  println("Lost, starting againg");
  delay(1000);
  invaders = new ArrayList<invader>();
}

class invader {
  int x, y;
  int size;
  int speed;
  PImage img = new PImage();
  invader(int X, int Y, int Size, int Speed, String ImgString) {
     x = X;
     y = Y;
     size = Size;
     speed = Speed;
     img = loadImage(ImgString);
     img.resize(size, size);
  }
  int update() {
    y += speed;
    println(y);
    if(y > height) {
      return 1;
    }
    return 0;
  }
  void draw() {
    image(img, x, y);
  }
}
