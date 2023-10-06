int circle_size = 400;
float rotation = 0;
int maxDepth = 0;
int currentDepth = 0;
int depthChange = 1;
int time = millis();
int counter = 0;

void setup(){
  size(1000, 1000);
  background(0, 0, 0);
  frameRate(20);
  noStroke();
  fill(255, 255, 255);
  time = millis();
}

void draw() {
  if (millis() > time + 2000)
  {
    maxDepth += depthChange;
    time = millis();
  }
  if(maxDepth <= 0 || maxDepth >= 7) {
    depthChange *= -1;
  }
  println(maxDepth);
  currentDepth = 0;
  rotation += 0.035;
  background(0, 0, 0);
  translate(width/2, height/2);
  rotate(rotation);
  recurse();
  if(counter < 9) {
      saveFrame("./output-2/out-00" + counter + ".jpg");
  }
  else if(counter < 99) {
    saveFrame("./output-2/out-0" + counter + ".jpg");
  }
  else {
    saveFrame("./output-2/out-" + counter + ".jpg");
  }
  counter++;
  saveImages();
}


void recurse() {
  if( currentDepth < maxDepth) {
    currentDepth++; //<>//
    //pushMatrix();
    //translate(circle_size/2, circle_size/2);
    scale(0.44);
    callRecursionMultpileTimes(); //<>//
    //popMatrix();
  }else{
  circle(circle_size/2, circle_size/2, circle_size); //<>//
  circle(circle_size/2, -circle_size/2, circle_size);
  circle(-circle_size/2, circle_size/2, circle_size);
  circle(-circle_size/2, -circle_size/2, circle_size);

  } //<>//
} //<>//
 //<>//

void callRecursionMultpileTimes() {

  callRecurionsTranslated(1, 1); //<>//
  callRecurionsTranslated(1, -1); //<>//
  callRecurionsTranslated(-1, 1); //<>//
  callRecurionsTranslated(-1, -1); //<>//
  currentDepth--;

}

void callRecurionsTranslated(int xVor, int yVor) {
  pushMatrix();

  translate((width/2) * xVor, (height/2) * yVor);
  rotate(rotation);
  //scale(0.44);
  recurse();
  popMatrix();
}

void saveImages() {
  if(counter <= 9) {
      saveFrame("./output/out-00" + counter + ".jpg");
  }
  else if(counter <= 99) {
    saveFrame("./output/out-0" + counter + ".jpg");
  }
  else {
    saveFrame("./output/out-" + counter + ".jpg");
  }
  counter++;
}
