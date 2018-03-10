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
  tekenStartScherm();    
}

// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  smooth();
  background(zwart);   

  if (startSchermActive) { 
    toonAchtergrondVideo();
    tekenStartScherm();
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
  restartTijd = millis() / 1000.0;
}

// Functie om het spel te herstarten, spelvariabelen worden gereset.
void herstart() {
  resetSpelVariabelen();  
  setupSpel();
}