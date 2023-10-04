int columns = 20;
int rows = 20;
int circle_size = 50;
int color_3 = 255;
int color_offset = -25;

void setup() {
  background(0);
  size(500, 500);
  frameRate(1);
}


void draw() {
  background(0, 0, 0);
  color_3 += color_offset;
  if(color_3 >= 255 || color_3 <= 0) {
    color_offset *= -1;
  }
  for(int x = 1; x < columns - 1; x += 1) {
    for(int y = 1; y < rows - 1; y += 1) {
      pushMatrix();
      fill(random(255), random(255), color_3, 255);
      translate(x * circle_size /2 , y * circle_size /2 );
      
      int rotation = int(random(0 , 4));
      //int rotation = 3;
      if(rotation == 1) {
        translate(circle_size /2, 0);
      }
      if(rotation == 3) {
        translate(0 ,circle_size /2);
      }
      if(rotation == 2) {
        translate(circle_size /2, circle_size /2);
      }
      arc(0, 0, circle_size, circle_size, HALF_PI * rotation, HALF_PI * (rotation + 1));
      popMatrix();
    }
  }
}
