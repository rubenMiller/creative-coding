int borderSize = 5;
float scaleFactor = 1.0;
float scaleFactorChange = 1.05;
float maxScale = 0.9;
float rotationFactor = 0.0;
int color_2 = 255;
int color_3 = 0;
int color_change = 10;

void setup() {
    size(900, 540);
    background(0, 0, 0);
    frameRate(30);
    noStroke();
}

void draw() {
  if(color_2 <= 0 || color_2 >= 255) {
    color_change *= -1;
  }
  if(scaleFactor <= 0.05) {
    scaleFactorChange = 0.95;
  }
  if(scaleFactor >= maxScale && scaleFactorChange == 0.95) {
    scaleFactorChange = 1.05;
    maxScale -= 0.1;
  }
  color_2 += color_change;
  color_3 -= color_change;
  translate(width/2, height/2);
  scale(scaleFactor);
  rotate(rotationFactor);
  scaleFactor = scaleFactor / scaleFactorChange;
  println("factor: ", scaleFactor, ", change: ", scaleFactorChange);
  rotationFactor += 0.005;
  draw_rects(width / 2, height / 2);
}

void draw_rects(int x_offset, int y_offset) {
  //fill(0, 0, 0);
  fill(255, color_2, color_3);
  rect( -x_offset, -y_offset, x_offset * 2, y_offset * 2, 100);
  //fill(255, color_2, color_3);
  //rect( -x_offset + borderSize, -y_offset + borderSize, x_offset * 2 - borderSize * 2, y_offset * 2 - borderSize * 2);
}
