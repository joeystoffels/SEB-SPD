// Moduleopdracht 2
// Joey Stoffels
// 7 februari 2018

//TODO add zoomfactor

// setup variables
int lengte = 180;
int gewicht = 80;
float bmi = gewicht / (lengte/100.0 * 2);
boolean selector = true;

void setup() {
  size(500, 500);
}

void draw() {
  background(0, 0, 0);
  smooth();
  
  // set lines, texts and colors
  stroke(255, 255, 255);
  
  fill(255, 0, 0);
  text("ondergewicht", 20, ((50-18.5) / 50 * 500) + 25);
  line(0, ((50-18.5) / 50 * 500), 500, ((50-18.5) / 50 * 500));
  
  fill(0, 255, 0);
  text("normaal gewicht", 20, ((50-25.0) / 50 * 500) + 38);
  line(0, ((50-25.0) / 50 * 500), 500, ((50-25.0) / 50 * 500));
  
  fill(255, 140, 0);
  text("overgewicht", 20, ((50-30.0) / 50 * 500) + 30);
  line(0, ((50-30.0) / 50 * 500), 500, ((50-30.0) / 50 * 500));
  
  fill(255, 0, 0);
  text("obees", 20, ((50-30.0) / 50 * 500) - 15);
  
  // set rectangle with colors
  stroke(255, 255, 255);
  if (bmi < 18.5 || bmi > 30.0) { 
    fill(255, 0, 0);
  }
  if (bmi > 18.5 && bmi < 25.0) {
    fill(0, 255, 0);
  }
  if (bmi > 25 && bmi < 30) {
    fill(255, 140, 0);
  }
  
  rect(width/2 - ((width/4)/2) + 50, 500, width/4, (-bmi / 50 * 500));

  // set text fields
  fill(255,255,255);
  text("Lengte (cm): " + lengte, 20, 25);
  text("Gewicht (kg): " + gewicht, 20, 50);
  text("BMI: " + (int((bmi * 100)) / 100.0), 20, 75);
  text("Klik om type invoer te wijzigen.", 20, 105);
  text("Scroll om waarde te wijzigen.", 20, 120);
  text("Geselecteerd : " + (selector == true ? "Lengte" : "Gewicht"), 20, 145);
} 

// mouseWheel event to change variable value
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (selector == true) {
    if(e > 0) {
      lengte = constrain(lengte - 1, 25, 220);
      bmi = gewicht / (lengte/100.0 * 2);
    }
    if(e < 0) {
      lengte = constrain(lengte + 1, 25, 220);
      bmi = gewicht / (lengte/100.0 * 2);
    }
  } else {
    if(e > 0) {
      gewicht = constrain(gewicht - 1, 10, 300);
      bmi = gewicht / (lengte/100.0 * 2);
    }
    if(e < 0) {
      gewicht = constrain(gewicht + 1, 10, 300);
      bmi = gewicht / (lengte/100.0 * 2);
    }
  }
}

// mouseClicked event to change active variable field
void mouseClicked() {
  if (selector == true) {
    selector = false;
  } else {
    selector = true;
  }
}