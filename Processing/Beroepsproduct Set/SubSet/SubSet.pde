// Beroepsproduct SubSet
// Joey Stoffels
// 23 maart 2018
  
import processing.sound.*;
import processing.video.*;

// Setup van het startScherm en enkele variabelen.
void setup() {
  setImg = loadImage(setImgBestandsLocatie);  
  airwolfVideo = new Movie(this, airwolfVideoBestandsLocatie);
  airwolfMuziek = new SoundFile(this, airwolfMuziekBestandsLocatie);
  ateamVideo = new Movie(this, ateamVideoBestandsLocatie);
  ateamMuziek = new SoundFile(this, ateamMuziekBestandsLocatie);  
  tekenStartScherm();  
  maakSpelScherm();
}

// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  smooth();
  background(zwart);  
  customTheme();

  if (startSchermActive) { 
    tekenStartScherm();
  }

  if (spelActief) {     
    kleurAchtergrondKaarten();    
    vulSpeelveld();  
    tekenScorebord(); 
    timer();
    checkEindeSpel();
  }

  if (spelAfgelopen) { 
    tekenEindscherm();   
  }
}

void movieEvent(Movie movie) {
  movie.read(); 
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