int numberOfRects = 100;
ArrayList<Rect> rects = new ArrayList<Rect>();
int rectDistance = 10;

void setup() {
 size(1000, 1000);
 background(0,0,0);
 noFill();
 stroke(255, 255, 255);
 rectMode(CENTER);
 for (int i = 0; i < numberOfRects; i++) {
   rects.add(new Rect(new PVector(random(width), random(height))));
   //rects.add(new Rect(new PVector(width/2-20, height/2)));
   //rects.add(new Rect(new PVector(width/2+20, height/2)));
 }
}

void draw() {
  background(0, 0, 0);
  for(Rect r : rects) {
    r.update(rects);
    r.draw();
  }
}

boolean rectanglesCollide(Rect rect1, Rect rect2) {
  float x1 = rect1.position.x - rect1.size/2;
  float y1 = rect1.position.y - rect1.size/2;
  float width1 = rect1.size*rect1.whratio;
  float height1 = rect1.size/rect1.whratio;
  
  float x2 = rect2.position.x - rect2.size/2;
  float y2 = rect2.position.y - rect2.size/2;
  float width2 = rect2.size*rect2.whratio;
  float height2 = rect2.size/rect2.whratio; //<>//
  
  if(x1 + width1 + rectDistance >= x2 && x1 <= x2 + width2 + rectDistance && y1 + height1 + rectDistance >= y2 && y1 <= y2 + height2 + rectDistance) { //<>//
    println("collission detected"); //<>//
    return true;
  }
  return false;
}

boolean borderReached(Rect rect) {
  if(rect.position.x - rect.size/2 < 0 || rect.position.y - rect.size/2 < 0 || rect.position.x + rect.size/2 > width || rect.position.y + rect.size/2 > height) {
    return true;
  }
  return false;
}


class Rect {
  PVector position;
  float size;
  float whratio;
  boolean grow = true;
  Rect(PVector Position) {
    position = Position;
    size = 0;
    float r = random(4,16);
    whratio = 8/r;
  }
  void update(ArrayList<Rect> rects) {
    for ( Rect r : rects) {
      if(position.x == r.position.x && position.y == r.position.y) {
        continue;
      }
      if(rectanglesCollide(this, r) == true || borderReached(this) == true){
        //line(nearestNeighbour.position.x, nearestNeighbour.position.y, this.position.x, this.position.y);
        grow = false;
        return;
      }
    if (grow == true) {
          size += 0.03;
    }

    }
    if (size == 35)
    {
      println("Should stop somewhere now...");
    }
  }
  void draw() {
      rect(position.x, position.y, size*whratio, size/whratio);
  }
}
