int xPos;
int yPos;
float zPos;

int xPosC;
int yPosC;
float zPosC;

float lineWidth = 1;

int mov = 5;
float angle;



void setup() {
  size(1000, 1000, P3D); 
  lights();
  xPos = width/2;
  yPos = height/2;
  zPos = (height/2.0) / tan(PI*30.0 / 180.0);
  
  int xPosC = 0;
  int yPosC = 0;
  float zPosC = 0;
}

void draw() {
  background(0);
  lights();
  //directionalLight(128, 128, 128, -1, 0, 0);
  
  float time = millis();
  
  angle = 2*sin((time / 7000));
  
  //angle = QUARTER_PI;
  noStroke();
  fill(255, 255, 255);
  pushMatrix();
  translate(width/2, height, 0);
  drawBranch(height/2);
  popMatrix();
  
  /*pushMatrix();
  translate(width/2, height, 0);

  box(500);
  popMatrix();
  */


  pushMatrix();
  
  translate(width/2, height/2+25, 0);
  rotateX(HALF_PI);

  drawCylinder(20, 50, 50);
  popMatrix();
  
  

  xPos += xPosC;
  yPos += yPosC;
  zPos += zPosC;
  
  camera(xPos, yPos, zPos, width/2, height/2, 0, 0, 1, 0);
  
}

void keyReleased() {
  if (key == 'w') { yPosC = 0; }
  if (key == 's') { yPosC = 0; }
  if (key == 'a') { xPosC = 0; }
  if (key == 'd') { xPosC = 0; }
  if (key == 'q') { zPosC = 0; }
  if (key == 'e') { zPosC = 0; }
}

void keyPressed() {
  if (key == 'w') { yPosC += mov; }
  if (key == 's') { yPosC -= mov; }
  if (key == 'a') { xPosC += mov; }
  if (key == 'd') { xPosC -= mov; }
  if (key == 'q') { zPosC += mov; }
  if (key == 'e') { zPosC -= mov; }
   
}

void drawline(float x1, float y1, float z1, float x2, float y2, float z2) {
  //println("draw line");
  beginShape();
  vertex(x1, y1, z1);
  vertex(x1 -2, y1 - 2, z1-2);
  vertex(x2, y2, z2);
  vertex(x2-2, y2-2, z2-2);
  //vertex(-x1, -y1, -z1);
  endShape();
}

void drawCylinder( int sides, float r, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);

    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
        vertex( x, y, -halfHeight);    
    }
    endShape(CLOSE);

}


void drawBranch(float length) {
  // going lower is the enemy of the framerate
  if (length > 20) {
    translate(0, -length, 0);
    length *= 0.5;
    
    pushMatrix();
    rotateZ(angle);
      pushMatrix();
      rotateZ(-HALF_PI);
      translate(length/2,0, 0);
      rotateY(HALF_PI);
      drawCylinder(20, 2, length);
      popMatrix();
    //drawline(0f, 0f, 0f, 0f, -length, 0f);
    drawBranch(length);
    popMatrix();
    
    pushMatrix();
    rotateZ(-angle);
      pushMatrix();
      rotateZ(-HALF_PI);
      translate(length/2,0, 0);
      rotateY(HALF_PI);
      drawCylinder(20, 2, length);
      popMatrix();
    //drawline(0f, 0f, 0f,  0f, -length, 0f);
    drawBranch(length);
    popMatrix();
    
    pushMatrix();
    rotateY(HALF_PI);
    rotateZ(angle);
      pushMatrix();
      rotateZ(-HALF_PI);
      translate(length/2,0, 0);
      rotateY(HALF_PI);
      drawCylinder(20, 2, length);
      popMatrix();
    //drawline(0f, 0f, 0f,  0f, -length, 0f);
    drawBranch(length);
    popMatrix();
    
    pushMatrix();
    rotateY(-HALF_PI);
    rotateZ(angle);
      pushMatrix();
      rotateZ(-HALF_PI);
      translate(length/2,0, 0);
      rotateY(HALF_PI);
      drawCylinder(20, 2, length);
      popMatrix();
    //drawline(0f, 0f, 0f,  0f, -length, 0f);
    drawBranch(length);
    popMatrix();
  }
}
