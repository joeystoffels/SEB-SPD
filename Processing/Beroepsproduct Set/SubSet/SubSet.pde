// Beroepsproduct Set
// Joey Stoffels
// datum

import java.awt.event.KeyEvent;

// Setup van het startScherm en enkele variabelen.
void setup() {
  img = loadImage("data/set.png");
  startScherm();  
  surface.setSize(600, 500);
  hoogteScorebord = int(height * 0.15) > 100 ? int(height * 0.15) : 100; // min hoogte 100px
  kaartBreedte = width / xVelden;
}


// Setup van het gekozen speltype (3 of 4 varianten).
void setupSpel() {
  speelVeld = new String[xVelden][yVelden];
  speelVeldKleur = new color[xVelden][yVelden];  
  surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte); 
  hoogteSpeelveld = height - hoogteScorebord;
  kleinGridBreedte = width / (xVelden * 8);
  kleinGridHoogte = hoogteSpeelveld / (yVelden * 8);
  maakKaartenStapel(aantalVariaties);
  maakSpeelveld();    
  aantalSetsSpeelveld();
  restartTijd = millis() / 1000.0;
}


// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  smooth();
  if (startSchermActive) {
    background(zwart);
    startScherm();
    surface.setSize(600, 500);
  }
  
  if (!startSchermActive && !spelAfgelopen) {
    tijd = millis() / 1000.0 - restartTijd;
    background(zwart);    
    tekenSpeelveldLijnen();
    kleurAchtergrondKaarten();
    vulSpeelveld();  
    maakScorebord();  
    eindeSpel();
  }
  
  if (!startSchermActive && spelAfgelopen) {
    background(zwart);
    eindeSpel();
  }
}


// Functie om het spel te herstarten, spelvariabelen worden gereset.
void herstart() {
  gameRestart = true;  
  scoreOpgeslagen = false;
  spelAfgelopen = false;
  kaartenInSpel = new ArrayList<String>();
  geselecteerdeKaarten = new ArrayList<String>();
  setsLijst = new ArrayList<String[]>();
  scoreSpelerEen = 0;
  
  if(voegXVeldToe) {  // Check of er velden zijn toegevoegd aan het laatste spel en maak dit ongedaan.
    xVelden--;
    voegXVeldToe = false;
  }  
  
  setupSpel();  
}