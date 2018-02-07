// Oefenopgave 2.3, 2.4
// Joey Stoffels
// 4 februari 2018

int rectBreedteTemp = 280;
int rectBreedte = constrain(rectBreedteTemp, 0, width);
int rectHoogte = rectBreedte / 2;

int middelpuntX = width / 2; 
int middelpuntY = height / 2; 

int rectXOffset = middelpuntY - rectBreedte / 4;
int rectYOffset = middelpuntX - rectHoogte;



  size(300, 200);

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