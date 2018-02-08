// Moduleopdracht 1
// Joey Stoffels
// 4 februari 2018

// Variables
int breedte = 500;
int hoogte = 200;
int kolomBreedte = 100;

float staafA = 76.0;
float staafB = 99.0;
float staafC = 1250.0;

float average = (staafA + staafB + staafC) / 3;
float maxStaaf = staafA < staafB ? (staafB < staafC ? staafC : staafB) : (staafA < staafC ? staafC : staafA);
float zoomFactor = maxStaaf < 200 - 15 ? 1 : 1 / (maxStaaf/190) ; 

// Initialize screen
void settings() {
  size(breedte, hoogte);
}

// Draw items
void draw() {
  background(0, 0, 0);
  
  // Plot staafA
  fill(255, 125, 50);
  rect(50, calcRectHeight(staafA), kolomBreedte, staafA);
  text(str(staafA), 50, calcTextPos(staafA));
  
  // Plot staafB
  fill(125, 255, 50);
  rect(200, calcRectHeight(staafB), kolomBreedte, staafB);
  text(str(staafB), 200, calcTextPos(staafB));
  
  // Plot staafC
  fill(50, 125, 255);
  rect(350, calcRectHeight(staafC), kolomBreedte, staafC);
  text(str(staafC), 350, calcTextPos(staafC));
  
  // Plot average line
  stroke(255, 0, 0);
  line(0, calcRectHeight(average), 500, calcRectHeight(average));
  stroke(0);
  fill(255, 0, 0);
  text(str(int(average)), 5, calcRectHeight(average) - 1);
}

// Helper functions
float calcTextPos(float staaf) {
  return 200 - (staaf * zoomFactor) - 1;
}

float calcRectHeight(float staaf) {
  return hoogte - (staaf * zoomFactor);
}