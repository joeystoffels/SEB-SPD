// Beroepsproduct Set
// Joey Stoffels
// datum


// Setup van scherm grootte, aantal vakken voor kleinGridBreedte/Hoogte instellen,
// het initialiseren van de ArrayListen en het maken van het speelveld.
void setup() {
  background(zwart);  
  img = loadImage("data/set.png");
  startScherm();  
  if (!startSchermBoolean) {
      surface.setSize(500, 500);
  }
}


void setupGame() {
  speelVeld = new String[xVelden][yVelden];
  speelVeldKleur = new color[xVelden][yVelden];
  surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte); 
  hoogteScorebord = int(height * 0.15) > 100 ? int(height * 0.15) : 100; // min hoogte 100px
  kleinGridBreedte = width / (xVelden * 8);
  kleinGridHoogte = (height - hoogteScorebord) / (yVelden * 8);
  maakStapelKaarten(aantalVariaties);
  createSpeelVeld();    
  aantalSetsSpeelveld();
  fontVerdanaBold = createFont("Verdana Bold", hoogteScorebord / 7);
}


// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  if (!startSchermBoolean) {
    startScherm();
  }
  
  if (startSchermBoolean) {
    background(zwart);
    smooth();
    tekenVeldLijnen();
    kleurCellen();
    vulSpeelveld();  
    maakScorebord();
  
    eindeSpel();
  }
}


// Functie om het spel te herstarten.
void restart() {
  if(voegXVeldToe) {  // Check of er velden zijn toegevoegd aan het laatste spel en maak dit ongedaan.
    xVelden--;
    voegXVeldToe = false;
  }  
  kaartenArrayList = new ArrayList<String>();
  selectedKaarten = new ArrayList<String>();
  setList = new ArrayList<String[]>();
  speelVeld = new String[xVelden][yVelden];
  speelVeldKleur = new color[xVelden][yVelden];
  scoreSpelerEen = 0;
  aantalSetsSpeelveld = 0;  
  background(zwart);  
  surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte); 
  hoogteScorebord = int(height * 0.15) > 100 ? int(height * 0.15) : 100; // min hoogte 100px //TODO in functie zetten
  kleinGridBreedte = width / (xVelden * 8);
  kleinGridHoogte = (height - hoogteScorebord) / (yVelden * 8);
  maakStapelKaarten(aantalVariaties);
  createSpeelVeld();    
  aantalSetsSpeelveld();
}