void setup() {
  size(800, 800);
  background(100, 180, 180);
  noStroke();
  frameRate(1);
}

void draw() {
  background(0,0,0);
  noStroke();
  color c = color(random(0, 255), random(0, 255), random(0, 255), 255);
  int size = 80;
  for(int x = 0; x < width/2; x += size) {
    for(int y = 0; y < width; y += size) {
      if (1 == int(random(0, 2))){
        fill(c);
        square(x, y, size);
        square(width - x - 1 * size, y, size);
      }
    }
  }
  //saveFrame("output/output-4.png");
}
