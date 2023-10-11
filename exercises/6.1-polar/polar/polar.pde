int dotSize = 3;
int roseSize = 200;
float time = 0.0;
ArrayList<roseCurve> curvesList = new ArrayList<roseCurve>();

void setup() {
   size(2600, 1200);
   background(0,0,0);
   noStroke();
   time = millis();
   float k = 0;
   for(float i = roseSize/2; i < width; i += roseSize) {
     for(float j = roseSize/2; j < height; j += roseSize) {
       println(i/j);
       roseCurve c = new roseCurve(k = i/j, color(255, i/4, j/4), new PVector(i, j));
       curvesList.add(c);
     }
   }
}

void draw() {
  float elapsedTime = millis() - time;
  
  for(int i = 0; i < curvesList.size(); i++) {
    curvesList.get(i).update(elapsedTime);
    curvesList.get(i).draw();
  }
  time = millis();
}


class roseCurve {
  float k;
  float angle;
  color col;
  PVector location;
  PVector lastLocation;
  roseCurve(float K, color Col, PVector Location) {
    k = K;
    angle = 0;
    col = Col;
    location = Location;
    lastLocation = Location;
  }
  void update(float elapsedTime) {
     //One rotation should take pi seconds
     angle += elapsedTime /1000;
  }
  void draw() {
     fill(col);
     pushMatrix();
     translate(location.x, location.y);
     rotate(angle);
     float radius = (roseSize / 2) * sin(k * angle);
     //println(radius, ", ", angle);
     circle(radius, 0, dotSize);
     popMatrix();
  }
}
