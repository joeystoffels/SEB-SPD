// Beroepsproduct SubSet
// Joey Stoffels
// 23 maart 2018

// Setup van het startScherm en enkele variabelen.
void setup() {
  img = loadImage("data/set.png");
  tekenStartScherm();
  maakSpelScherm();
}


// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  smooth();
  background(zwart);
  
  if (startSchermActive) {    
    tekenStartScherm();    
  }
  
  if (spelActief) {    
    tekenSpeelveldLijnen();
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


// Setup van het gekozen speltype (3 of 4 varianten).
void setupSpel() {
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