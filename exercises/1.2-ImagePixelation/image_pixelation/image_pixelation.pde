size(960, 540);
PImage img = loadImage("picture-astern.png"); //from https://cdn.onlyinyourstate.com/wp-content/uploads/2017/06/sunflower-5.jpg
img.resize(width, height);
ellipseMode(CORNER);
noStroke();


background(0);
float circle_max_size = 10;
float circle_min_size = 5;
float circleSize = 10;
float gridSize = 10;
int gridOffset = 0;
int gridOffsetDiff = 1;
for (int x = 0; x < width; x += gridSize ) {
  for (int y = -47; y < height; y += gridSize  ) {
    gridOffset += gridOffsetDiff;
    fill(img.get(x, y));
    //circleSize = random(circle_min_size, circle_max_size);
    float y_offset = 10* sin(0.0025*gridOffset);
    float x_offset = 0.5 * sqrt(sin(0.0025*gridOffset) * sin(0.0025*gridOffset)) + 0.5;
    circle(x, y + y_offset, circleSize * x_offset);
    //circle(x, y + y_offset, circleSize );
  }
  //circleSize *= 0.964;
  //circleSize = max(circleSize, 1);
}
saveFrame("./output-3.jpg");
