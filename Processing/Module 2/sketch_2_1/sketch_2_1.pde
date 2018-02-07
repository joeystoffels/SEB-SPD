// Oefenopgave 2.1, 2.2
// Joey Stoffels
// 4 februari 2018

int rectBreedte = 250;
int rectHoogte = rectBreedte / 2;

int rectXOffset = 150;
int rectYOffset = 250;

  size(1000, 500);

  rect(rectYOffset, rectXOffset, rectBreedte, rectHoogte);
  stroke(255, 0, 0);
  line(rectYOffset, rectXOffset + rectHoogte / 2, rectBreedte + rectYOffset, rectXOffset + rectHoogte / 2);
  line(rectYOffset + rectBreedte / 2, rectXOffset, rectYOffset + rectBreedte / 2, rectXOffset + rectHoogte);
  stroke(0);
  
  noStroke();
  fill(255, 100, 150);
  rect(rectYOffset + rectBreedte / 2 + 1, rectXOffset + rectHoogte / 2 + 1, rectBreedte / 2, rectHoogte / 2);
  rect(rectYOffset, rectXOffset, rectBreedte / 2, rectHoogte / 2);
  fill(150, 100, 150);
  rect(rectYOffset + rectBreedte / 2 + 1, rectXOffset, rectBreedte / 2, rectHoogte / 2);
  rect(rectYOffset, rectXOffset + rectHoogte / 2 + 1, rectBreedte / 2, rectHoogte / 2);