float a = 0.0;
int rows = 10;
int columns = 14;
int size = 20;




void setup() {
  size(220, 300);
  background(100, 180, 180);
  noStroke();
  frameRate(30);
  smooth();
  rectMode(CENTER);
}

void draw() {
  color white = color(255,255,255);
  color black = color(0,0,0);
  a += .01;

  background(black);
  translate(size, size);
  for(int x = 1; x < rows -  1; x += 1) {
    for(int y = 1; y < columns - 1; y += 1) {
      pushMatrix();
      translate(x * size, y * size);
      rotate(a * (y - 1));
      
      float r = sin(x);
      translate((y - 1) * r, (y - 1) * r);

      fill(white);
      rect(0, 0, size, size);
      
      fill(black);
      rect(0, 0, size-2, size-2);
      popMatrix();
     
    }
  }
  //saveFrame("output/output-4.png");

}
