// Module 1 - Oefenopgave 1.4, 1.5
// Joey Stoffels
// 4 februari 2018

int breedte = 500;
int hoogte = breedte / 2;
int diameter = breedte / 3;
int yPosEllipse = hoogte;
int xPosEllipse = hoogte / 2;
int yPosText = hoogte;
int xPosText = xPosEllipse + 14;
int textSize = diameter / 5;
int yOffSet = 150;
int xOffSet = 75;

void settings() {
  size(breedte * 2 , hoogte * 3);
}

void draw() {
  fill(255, 255, 255);
  rect(0 + yOffSet, 0 + xOffSet, breedte, hoogte);
  fill(255, 0, 0);
  ellipse(yPosEllipse + yOffSet, xPosEllipse + xOffSet, diameter, diameter);
  fill(0, 0, 0);
  textAlign(CENTER);
  textSize(textSize);
  text("NIPPON", yPosText + yOffSet, xPosText + xOffSet);
}