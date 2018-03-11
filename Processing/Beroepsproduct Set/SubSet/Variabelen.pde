int schermBreedte = 700;
final int schermHoogte = int(schermBreedte * 1.1);
final int scorebordHoogte = 100;
final int speelveldHoogte = schermHoogte - scorebordHoogte;  

// Aantal spelvlakken (aantal kaarten per as).
int xVelden = 4; // Niet final omdat deze waarde tijdens het spel kan wijzigen
final int yVelden = 3;  

// Het veld wordt opgedeeld in delen wat kleinGridBreedte/Hoogte voorsteld.
// Variabelen kunnen pas worden geinitialiseerd zodra de screensize in setup bekend is.
int kaartGridBreedte = schermBreedte / (xVelden * 8);
int kaartGridHoogte = speelveldHoogte / (yVelden * 8);

// Grootte v/d kaarten in pixels.
final int kaartBreedte = schermBreedte / xVelden;
final int kaartHoogte = (schermHoogte - scorebordHoogte) / yVelden;

// Standaard lege kaart; laat een leeg vlak zien.
final String legeKaart = "0000";

// kleurcodes RGB
final color rood = color(255, 50, 50);
final color groen = color(100, 255, 100);
final color blauw = color(0, 100, 255);
final color wit = color(255, 255, 255);
final color zwart = color(0, 0, 0);
final color pastelRood = color(255, 179, 186);
final color pastelGroen = color(186, 255, 201);
final color pastelBlauw = color(186, 225, 255);

// Configuratie waarden voor de diverse figuren
// Betreffen factoren binnen het in een kaart gedefineerde grid (8 x 8)
final float[][] ellipseConfig = { 
  {4.0, 0, 0}, 
  {3.0, 0, 0}, 
  {5.0, 0, 0}, 
  {2.0, 0, 0}, 
  {4.0, 0, 0}, 
  {6.0, 0, 0} 
};
final float[][] rechthoekConfig = { 
  {3.25, 0, 0},
  {2.4, 0, 0},
  {4.4, 0, 0},
  {1.0, 0, 0},
  {3.25, 0, 0},
  {5.5, 0, 0}
};
final float[][] driehoekConfig = { 
  {4.75, 3.25, 4.75}, 
  {3.75, 2.25, 3.75}, 
  {5.75, 4.25, 5.75}, 
  {2.75, 1.25, 2.75}, 
  {4.75, 3.25, 4.75}, 
  {6.75, 5.25, 6.75} 
};

// Startscherm image, wordt in setup geinitialiseerd.
String achtergrondVideoBestandsLocatie= "rainbow.mov";
String setImgBestandsLocatie = "data/set.png";
String setSpelregelsBestandsLocatie = "data/spelregels.png";
String airwolfVideoBestandsLocatie = "AirwolfMovie.mp4";

PImage setImg;
Movie airwolfVideo;
Movie achtergrondVideo;
Movie rainbowVideo;
PImage setSpelregels;

String theme = "";

// ArrayList ipv. array voor het makkelijk deleten van Strings.
// Bevat alle mogelijke kaarten, '1drv' betekent bijv. 1 driehoek rood vol.                    
ArrayList<String> kaartenInSpel = new ArrayList<String>();

// Twee dimensionaal array om het speelveld te maken
String[][] speelVeld = new String[xVelden][yVelden];
color[][] speelVeldKleur = new color[xVelden][yVelden];

final String[] aantalFiguren = {"1", "2", "3"};
final String[] kleurFiguur = {"r", "g", "b"}; // rood, groen, blauw
final String[] figuurType = {"d", "r", "e"}; // driehoek, rechthoek, ellipse
final String[] vullingFiguur = {"l", "h", "v"}; // leeg, half, vol
//TODO 5e variatie toevoegen?

// Lijst met geselecteerde kaarten.
ArrayList<String> geselecteerdeKaarten = new ArrayList<String>();

float scoreSpelerEen = 0;
//int scoreSpelerTwee = 0; // Future feature
int aantalSetsSpeelveld;
ArrayList<String[]> setsLijst = new ArrayList<String[]>();

// Gamestate variabelen
int aantalVariaties = 3;

boolean spelActief = false;
boolean startSchermActief = true;
boolean spelAfgelopen = false;
boolean spelregelsActief = false;
boolean kaartenToegevoegd = false;
boolean airwolfThemeActive = false;
boolean scoreOpgeslagen = false;
int aantalHintKaarten = 2;

String naam = "";

float tijd = 0.0;
float restartTijd = 0.0;

int aantalKaartenOpSpeelveld = 0;

// Filter functie om max lengte v/d naam op 10 karakters te zetten
void setNaam(String naamNieuw) {    
  if (naamNieuw.length() >= 8) { 
    naamNieuw = naamNieuw.substring(0, 8);
  }   
  naam = naamNieuw;
}

int plaatsOpHighscoreLijst;

// Custom font
PFont verdanaBold(int size) {
  return createFont("Verdana Bold", size);
}

void maakSpelScherm() {
  surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte + scorebordHoogte);
}

void resetSpelVariabelen() { 
  scoreOpgeslagen = false; //<>//
  spelAfgelopen = false;
  kaartenInSpel = new ArrayList<String>();
  geselecteerdeKaarten = new ArrayList<String>();
  setsLijst = new ArrayList<String[]>();
  speelVeld = new String[xVelden][yVelden];
  speelVeldKleur = new color[xVelden][yVelden];  
  naam = "";
  scoreSpelerEen = 0;
  aantalHintKaarten = 2;
  kaartenToegevoegd = false;
}

void laadMediaBestanden() {
  setImg = loadImage(setImgBestandsLocatie);  
  setSpelregels = loadImage(setSpelregelsBestandsLocatie);
  achtergrondVideo = new Movie(this, achtergrondVideoBestandsLocatie);  
  rainbowVideo = new Movie(this, achtergrondVideoBestandsLocatie);
  airwolfVideo = new Movie(this, airwolfVideoBestandsLocatie);
}

void timer() {  
  if (spelAfgelopen) {
    tijd = tijd == 0.0 ? millis() / 1000.0 : tijd;
  } else {
    tijd = millis() / 1000.0 - restartTijd;
  }
}

void restartTimer() {
    restartTijd = millis() / 1000.0;
}