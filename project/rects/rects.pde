import java.util.Collections;

int numberOfRects = 10;
ArrayList<Rect> rects = new ArrayList<Rect>();
ArrayList<Edge> mst = new ArrayList<Edge>();
ArrayList<Edge> edges = new ArrayList<Edge>();
int rectDistance = 10;
PVector lastMouse = new PVector();

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
 for( Rect r :  rects) {
   while(r.grow == true) {
     for(Rect rr : rects) {
       rr.update(rects);
     }
   }
 }
 
 // create edges
 
 for(int i = 0; i < rects.size(); i++) {
   for(int j = i + 1; j < rects.size(); j++) {
     edges.add(new Edge(rects.get(i), rects.get(j)));
   }
 }
 
 edges.sort((edge1, edge2) -> Float.compare(edge1.weight, edge2.weight));
  background(0, 0, 0);
  for(Rect r : rects) {
    r.draw();
  }
 for (Edge e : edges) {
   if (mst.size() <= rects.size() && createsCycle(e) == false) {
     mst.add(e);
     line(e.start.position.x, e.start.position.y, e.end.position.x, e.end.position.y); //<>//
   }

 }



  
  lastMouse = new PVector(mouseX, mouseY); //<>//
}


void draw() {
  if(mousePressed == true) {
    stroke(255, 0, 0);
    line(mouseX, mouseY, lastMouse.x, lastMouse.y);

  }
  lastMouse = new PVector(mouseX, mouseY);
}


ArrayList<Edge> searchedEdges = new ArrayList<Edge>();

boolean compareRect(Rect r1, Rect r2) {
  if(r1.position.x == r2.position.x && r1.position.y == r2.position.y) return true;
  return false;
}

/*

boolean find(Rect rect, Rect root) {
  for(Edge e : mst) {
    if(searchedEdges.contains(e)) continue;
    if(compareRect(e.start, rect)) {
      if(compareRect(e.end, root)) return true;
      searchedEdges.add(e);
      if(find(e.end, root)) return true;
      searchedEdges.remove(e);
    }
    if(compareRect(e.end, rect)) {
      if(compareRect(e.start, root)) return true;
      searchedEdges.add(e);
      if(find(e.start, root)) return true;
      searchedEdges.remove(e);
    }
  }
  
  //if (searchedEdges.size() > 0) searchedEdges.remove(searchedEdges.size()-1);
  return false;
}*/

ArrayList<Rect> seenRects = new ArrayList<Rect>();


boolean find(Rect rect, Rect root) {
  ArrayList<Rect> queue = new ArrayList<Rect>();
  queue.add(rect);
  seenRects.add(rect);
  while(!queue.isEmpty()) {
    Rect c = queue.get(0);
    queue.remove(c); //<>//
    if(compareRect(c, root)) return true;
    for(Edge e : mst) {
      //check if nachfolger
      if(compareRect(c, e.start) && !seenRects.contains(e.end)) { //<>//
        //e.end ist das nächste in der schlange
        queue.add(e.end); //<>//
        seenRects.add(e.end);
      } //<>//
      if(compareRect(c, e.end) && !seenRects.contains(e.start)) {
        //e.end ist das nächste in der schlange //<>//
        queue.add(e.start);
        seenRects.add(e.start);
      }
      
      
    }
  }
  return false;
}

boolean createsCycle(Edge edge) {
  if( find(edge.start, edge.end) ) return true;
  if( find(edge.end, edge.start) ) return true;
    
  return false;
}


boolean rectanglesCollide(Rect rect1, Rect rect2) {
  float x1 = rect1.position.x - rect1.width/2;
  float y1 = rect1.position.y - rect1.height/2;
  float width1 = rect1.width;
  float height1 = rect1.height;
  
  float x2 = rect2.position.x - rect2.width/2;
  float y2 = rect2.position.y - rect2.height/2;
  float width2 = rect2.width;
  float height2 = rect2.height;
  
  if(x1 + width1 + rectDistance >= x2 && x1 <= x2 + width2 + rectDistance && y1 + height1 + rectDistance >= y2 && y1 <= y2 + height2 + rectDistance) {
    println("collission detected");
    return true;
  }
  return false;
}

boolean borderReached(Rect rect) {
  if(rect.position.x - rect.width/2 < 0 || rect.position.y - rect.height/2 < 0 || rect.position.x + rect.width/2 > width || rect.position.y + rect.height/2 > height) {
    return true;
  }
  return false;
}

class Edge {
  Rect start, end;
  float weight;
  
  Edge(Rect Start, Rect End) {
    start = Start;
    end = End;
    
    weight = dist(start.position.x, start.position.y, end.position.x, end.position.y);
  }
  
  float compareTo(Edge edge) {
    return this.weight - edge.weight;
  }
}


class Rect {
  PVector position;
  float width;
  float height;
  float whratio;
  boolean grow = true;
  Rect(PVector Position) {
    position = Position;
    this.width = 0;
    this.height = 0;
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
          width += 0.1*whratio;
          height += 0.1/whratio;
    }

    }

  }
  void draw() {
      rect(position.x, position.y, width, height);
  }
}
