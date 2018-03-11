// Beroepsproduct SubSet
// Joey Stoffels
// 23 maart 2018
  
import processing.sound.*;
import processing.video.*;

// Setup van het startScherm en enkele variabelen.
void setup() {
  frameRate(30);  
  maakSpelScherm();
  laadMediaBestanden(); 
}

// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  smooth();
  background(zwart);   

  if (startSchermActief) { 
    toonAchtergrondVideo();
    tekenStartScherm();
  }
  
  if (spelregelsActief) {
    toonAchtergrondVideo();
    fill(zwart, 150);
    stroke(wit, 200);
    strokeWeight(3);
    rect(width * 0.09, height * 0.21, width * 0.82, height * 0.58, 25);
    image(setSpelregels, width * 0.14, height * 0.25, width * 0.72, height * 0.5);
  }

  if (spelActief) {     
    kleurAchtergrondKaarten();    
    tekenKaartFiguren();  
    tekenScorebord(); 
    timer();
    checkEindeSpel();
  }

  if (spelAfgelopen) { 
    toonAchtergrondVideo();
    tekenEindscherm();   
  }
}

// Setup van het gekozen speltype (3 of 4 varianten).
void setupSpel() {
  resetSpelVariabelen();
  maakSpelScherm(); 
  maakKaartenStapel(aantalVariaties);
  maakSpeelveld();    
  aantalSetsSpeelveld();
  restartTimer();
}