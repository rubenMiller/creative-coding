float lastMouseX = 0.0;
float lastMouseY = 0.0;
int color_2 = 255;
int color_3 = 0;
int color_change = 10;

void setup() {
    size(900, 900);
    background(0, 0, 0);
    frameRate(60);
    strokeWeight(5);
    
}

void draw() {
  if(mousePressed == true) {
    if(color_2 <= 0 || color_2 >= 255) {
      color_change *= -1;
    }
    color_2 += color_change;
    color_3 -= color_change;
    stroke(255, color_2, color_3);
    
    
    drawLine();
    pushMatrix();
    translate(width, 0);
    scale(-1,1);
    drawLine();
    popMatrix();
    
    
    pushMatrix();
    translate(width, 0);
    rotate(HALF_PI);
    drawLine();
    translate(0, height);
    scale(1, -1);
    drawLine();
    popMatrix();
    
    pushMatrix();
    translate(width, height);
    rotate(PI);
    drawLine();
    translate(width, 0);
    scale(-1, 1);
    drawLine();
    popMatrix();
    
    pushMatrix();
    translate(0, height);
    rotate( -HALF_PI);
    drawLine();
    translate(0, height);
    scale(1, -1);
    drawLine();
    popMatrix();
  }
    lastMouseX = mouseX;
    lastMouseY = mouseY;
}

void drawLine() {
    line(lastMouseX, lastMouseY, mouseX, mouseY);
}
