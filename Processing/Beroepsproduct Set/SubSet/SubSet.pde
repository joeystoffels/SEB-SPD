// Beroepsproduct SubSet
// Joey Stoffels
// 23 maart 2018

import processing.sound.*;
import processing.video.*;

void settings() {
  size(schermBreedte, SCHERM_HOOGTE);
}

// Setup van het startScherm en enkele variabelen.
void setup() {  
  toonLaadScherm();
  maakSpelScherm();
  laadMediaBestanden();
}

// Functie voor het weergeven van de inhoud van het scherm.
void draw() {   
  toonAchtergrondVideo();

  if (startSchermActief) { 
    toonStartScherm();
    return;
  }
  
  if (spelregelsActief) {
    toonSpelregels();
    return;
  }

  if (spelActief) {  
    toonSpeelscherm();
    return;
  }

  if (spelAfgelopen) { 
    toonEindscherm();
    return;
  }
}

// Setup van het gekozen speltype (3 of 4 varianten).
void setupSpel() {
  resetSpelVariabelen();
  maakSpelScherm(); 
  maakKaartenStapel();
  maakSpeelveld();    
  updateAantalSetsSpeelveld();
}