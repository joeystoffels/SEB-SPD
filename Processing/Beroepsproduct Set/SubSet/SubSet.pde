// Beroepsproduct SubSet
// Joey Stoffels
// 23 maart 2018
  
import processing.sound.*;
import processing.video.*;

// Setup van het startScherm en enkele variabelen.
void setup() {
  frameRate(30);  
  maakSpelScherm(xVelden);
  laadMediaBestanden(); 
}

// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  smooth();
  toonAchtergrondVideo();

  if (startSchermActief) { 
    toonStartScherm();
  }
  
  if (spelregelsActief) {
    toonSpelregels();
  }

  if (spelActief) {  
    toonAchtergrondKaarten();    
    tekenKaartFiguren();  
    tekenScorebord(); 
    updateTijd();
    checkEindeSpel();
  }

  if (spelAfgelopen) { 
    maakSpelScherm(4);
    toonEindscherm();   
  }
}

// Setup van het gekozen speltype (3 of 4 varianten).
void setupSpel() {
  resetSpelVariabelen();
  maakSpelScherm(xVelden); 
  maakKaartenStapel(aantalVariaties);
  maakSpeelveld();    
  telAantalSetsSpeelveld();  
}