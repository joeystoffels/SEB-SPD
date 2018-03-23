// Titel: (Sub)Set
// Naam: Joey Stoffels
// Datum: 23 maart 2018
// Klas: SEB B DT

// Imports voor media ondersteuning.
import processing.sound.*;
import processing.video.*;

// Initieel opzetten van de scherm grootte ivm. weergeven laadscherm.
void settings() {
  size(schermBreedte, SCHERM_HOOGTE);
}

// Setup van het spel.
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