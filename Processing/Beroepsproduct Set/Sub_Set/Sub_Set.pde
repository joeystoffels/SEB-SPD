// Beroepsproduct Set
// Joey Stoffels
// datum


// Setup van scherm grootte, aantal vakken voor kleinGridBreedte/Hoogte instellen,
// het initialiseren van de ArrayListen en het maken van het speelveld.
void setup() {
  background(zwart);  
  img = loadImage("data/set.png");
  startScherm();  
  if (startSchermActive) {
      surface.setSize(600, 500);
  }
}


// Initiele setup
void setupGame() {
  speelVeld = new String[xVelden][yVelden];
  speelVeldKleur = new color[xVelden][yVelden];  
  surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte); 
  hoogteScorebord = int(height * 0.15) > 100 ? int(height * 0.15) : 100; // min hoogte 100px
  kleinGridBreedte = width / (xVelden * 8);
  kleinGridHoogte = (height - hoogteScorebord) / (yVelden * 8);
  fontVerdanaBoldGroot = createFont("Verdana Bold", hoogteScorebord / 7);
  fontVerdanaBoldKlein = createFont("Verdana Bold", hoogteScorebord / 8);
  maakStapelKaarten(aantalVariaties);
  createSpeelVeld();    
  aantalSetsSpeelveld();
  restartTijd = millis() / 1000.0;
}


// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  smooth();
  if (startSchermActive) {
    startScherm();
    surface.setSize(600, 500);
  }
  
  if (!startSchermActive && !spelAfgelopen) {
    tijd = millis() / 1000.0 - restartTijd;
    background(zwart);    
    tekenVeldLijnen();
    kleurCellen();
    vulSpeelveld();  
    maakScorebord();  
    eindeSpel();
  }
  
  if (!startSchermActive && spelAfgelopen) {
    background(zwart);
    eindeSpel();
  }
}


// Functie om het spel te herstarten.
void restart() {
  gameRestart = true;  
  scoreSaved = false;
  restartTijd = millis() / 1000.0;
  tijd = millis() / 1000.0 - restartTijd;
  if(voegXVeldToe) {  // Check of er velden zijn toegevoegd aan het laatste spel en maak dit ongedaan.
    xVelden--;
    voegXVeldToe = false;
  }  
  spelAfgelopen = false;
  tijd = 0.0;
  kaartenArrayList = new ArrayList<String>();
  selectedKaarten = new ArrayList<String>();
  setList = new ArrayList<String[]>();
  speelVeld = new String[xVelden][yVelden];
  speelVeldKleur = new color[xVelden][yVelden];
  scoreSpelerEen = 0;
  aantalSetsSpeelveld = 0;  
  background(zwart);  
  surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte);   
  //hoogteScorebord = int(height * 0.15) > 100 ? int(height * 0.15) : 100; // min hoogte 100px //TODO in functie zetten
  kleinGridBreedte = width / (xVelden * 8);
  kleinGridHoogte = (height - hoogteScorebord) / (yVelden * 8);
  maakStapelKaarten(aantalVariaties);
  createSpeelVeld();    
  aantalSetsSpeelveld();  
}