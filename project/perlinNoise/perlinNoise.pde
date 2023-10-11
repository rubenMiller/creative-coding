int[][] map = new int[width][height];
Flock flock;
PImage img;

void setup() {
  size(1000, 1000);
  noStroke();
  background(255, 255, 255);
  frameRate(30);
  map = createMap();
  saveFrame("map.jpg");
  img = loadImage("map.jpg");
  flock = new Flock();
  for (int i = 0; i < 500; i++) {
    int x = int(random(width));
    int y = int(random(height));
    if(map[x][y] == 0) continue;
    flock.addBoid(new Boid(x, y));
  } //<>//
}

void draw() {
  drawMap();
  flock.run(map); //<>//
}

void mousePressed() {
  flock.addBoid(new Boid(mouseX,mouseY));
}



void drawMap() {
  noStroke();
  loadPixels();
  for(int y = 0; y < height; y++) {
    for(int x = 0; x < width; x++) {
      float g = map[x][y];
      int c = #FFFFFF;
      if( g == 0 ) c = #000000;
      pixels[y*width + x] = c;
    }
  }
  updatePixels();
}

int[][] createMap() {
  int[][] map = new int[width][height];
  int w = width;
  int h = height;
  for(int y = 0; y < h; y++) {
    for(int x = 0; x < w; x++) {
      float nx = float(x)/w;
      float ny = float(y)/h;
      float noise =  noise(4*nx,4*ny);
      int g = 0;
      if(noise >= 0.5) g = 1;
      map[x][y] = g;
      
      //set(x, y, int(g*255));
      //fill(g*255);
      //rect(x, y, 1, 1);
    }
  }
  return map;
}
