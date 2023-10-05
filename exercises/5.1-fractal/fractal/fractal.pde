int circle_size = 400;
float rotation = 0;


void setup(){
  size(1000, 1000);
  background(0, 0, 0);
  frameRate(30);
  noStroke();
  fill(255, 255, 255);
}

void draw() {
  rotation += 0.035;
  background(0, 0, 0);
  drawCircleGroups(); 
}


void drawCircleGroups() {
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotation);
  drawSingleCircles(1, 1);
  drawSingleCircles(1, -1);
  drawSingleCircles(-1, 1);
  drawSingleCircles(-1, -1);
  popMatrix();
}

void drawSingleCircles(int xVor, int yVor) {
  pushMatrix();
  translate(circle_size/2 * xVor, circle_size/2 * yVor);
  scale(0.44);
  drawCircles();
  popMatrix();
}

void drawCircles() {
  pushMatrix();
  //translate(width/2, height/2);
  rotate(rotation);
  circle(circle_size/2, circle_size/2, circle_size);
  circle(circle_size/2, -circle_size/2, circle_size);
  circle(-circle_size/2, circle_size/2, circle_size);
  circle(-circle_size/2, -circle_size/2, circle_size);
  popMatrix();
}
