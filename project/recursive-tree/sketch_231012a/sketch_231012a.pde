float angle;


void setup() {
  size(2000, 2000);
  stroke(255, 255, 255);
  strokeWeight(3);
  frameRate(30);
}


void draw() {
  background(0);
  angle = radians((mouseX/(float)width) * 90);
  
  translate(width/2, height);
  drawBranch(height/2);
}


void drawBranch(float length) {
  
  if (length > 5) {
    length *= 0.64;
    pushMatrix();
    line(0, 0, 0, -length);
    translate(0, -length);
    rotate(angle);
    drawBranch(length);
    popMatrix();
    
    pushMatrix();
    line(0, 0, 0, -length);
    translate(0, -length);
    rotate(-angle);
    drawBranch(length);
    popMatrix();
  }
  

  
}
