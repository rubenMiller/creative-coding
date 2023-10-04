

void setup() {
  size(800, 800);
  background(100, 180, 180);
  noStroke();
  frameRate(30);
}

void draw() {
  
  color black = color(0,0,0);
  color white = color(255,255,255);
  
  background(black);
  int size = 160;
  for(int x = size/2; x < width; x += size) {
    for(int y = size/2; y < width; y += size) {
      fill(white);
      float timeBasedValue = frameCount;
      float offsetL = 60 * sin(timeBasedValue/50 );
      float offsetX = offsetL * sin(timeBasedValue/50 + x + y);
      float offsetY = offsetL * cos(timeBasedValue/50 + x + y);
      circle(x + offsetX, y + offsetY, size *2/3);
      fill(black);
      circle(x, y, size /3);
    }
  }
  //saveFrame("output/output-4.png");
}
