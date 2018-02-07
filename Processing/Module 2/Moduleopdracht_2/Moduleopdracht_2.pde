// Moduleopdracht 2
// Joey Stoffels
// 7 februari 2018

float lengte = 0;
float gewicht = 0;

void setup() {
  size(500, 500);
}

void draw() {
  background(255, 100, 100);
  rect(width/2 - ((width/4)/2), 500 - 50, width/4, 50);
  fill(0,0,0);
  text(lengte, 25, 25);
} 

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e > 0) {
    lengte--;
  }
  if(e < 0) {
    lengte++;
  }
}