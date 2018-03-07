// Beroepsproduct Set
// Joey Stoffels
// datum

// Setup van het startScherm en enkele variabelen.
void setup() {
  img = loadImage("data/set.png");
  tekenStartScherm();  
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
  kaartGridBreedte = width / (xVelden * 8);
  kaartGridHoogte = hoogteSpeelveld / (yVelden * 8);
  maakKaartenStapel(aantalVariaties);
  maakSpeelveld();    
  aantalSetsSpeelveld();
  restartTijd = millis() / 1000.0;
}


// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  smooth();
  background(zwart);
  
  if (startSchermActive) {    
    tekenStartScherm();
    surface.setSize(600, 500);
  }
  
  if (spelActief) {
    tijd = millis() / 1000.0 - restartTijd;
    tekenSpeelveldLijnen();
    kleurAchtergrondKaarten();
    vulSpeelveld();  
    tekenScorebord();  
    checkEindeSpel();
  }
  
  if (spelAfgelopen) {
    tekenEindscherm();
  }
}


// Functie om het spel te herstarten, spelvariabelen worden gereset.
void herstart() {
  scoreOpgeslagen = false;
  spelAfgelopen = false;
  kaartenInSpel = new ArrayList<String>();
  geselecteerdeKaarten = new ArrayList<String>();
  setsLijst = new ArrayList<String[]>();
  naam = "";
  scoreSpelerEen = 0;
  
  if(kaartenToegevoegd) {  // Check of er velden zijn toegevoegd aan het laatste spel en maak dit ongedaan.
    xVelden--;
    kaartenToegevoegd = false;
  }  
  
  setupSpel();  
}