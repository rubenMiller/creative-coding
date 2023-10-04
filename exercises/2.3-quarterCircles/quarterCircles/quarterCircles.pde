int columns = 20;
int rows = 20;
int circle_size = 50;
background(0);
size(500, 500);


for(int x = 1; x < columns - 1; x += 1) {
  for(int y = 1; y < rows - 1; y += 1) {
    pushMatrix();
    fill(random(255), random(255), 255, 255);
    translate(x * circle_size /2 , y * circle_size /2 );
    
    int rotation = int(random(0 , 4));
    //int rotation = 3;
    if(rotation == 1) {
      translate(circle_size /2, 0);
    }
    if(rotation == 3) {
      translate(0 ,circle_size /2);
    }
    if(rotation == 2) {
      translate(circle_size /2, circle_size /2);
    }
    arc(0, 0, circle_size, circle_size, HALF_PI * rotation, HALF_PI * (rotation + 1));
    popMatrix();
  }
}
