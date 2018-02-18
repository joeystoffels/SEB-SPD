// Beroepsproduct Set
// Joey Stoffels
// datum


// Setup van scherm grootte, aantal vakken voor kleinGridBreedte/Hoogte instellen,
// het initialiseren van de ArrayList en het maken van het speelveld.
void setup() {
  background(zwart);  
  speelVeld = new String[xVelden][yVelden];
  speelVeldKleur = new color[xVelden][yVelden];
  surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte); 
  hoogteScorebord = int(height * 0.15);
  kleinGridBreedte = width / (xVelden * 8);
  kleinGridHoogte = (height - hoogteScorebord) / (yVelden * 8);
  maakStapelKaarten(aantalVariaties);
  createSpeelVeld();    
  aantalSetsSpeelveld();
  fontVerdanaBold = createFont("Verdana Bold", hoogteScorebord / 7);
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
  hoogteScorebord = int(height * 0.15);
  kleinGridBreedte = width / (xVelden * 8);
  kleinGridHoogte = (height - hoogteScorebord) / (yVelden * 8);
  maakStapelKaarten(aantalVariaties);
  createSpeelVeld();    
  aantalSetsSpeelveld();
}


// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  background(zwart);
  smooth();
  tekenVeldLijnen();
  kleurCellen();
  vulSpeelveld();  
  maakScorebord();
}