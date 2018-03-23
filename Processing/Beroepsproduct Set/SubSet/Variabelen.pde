int schermBreedte = 700;
final int SCHERMHOOGTE = int(schermBreedte * 1.2);
final int SCOREBORDHOOGTE = 100;
final int SPEELVELDHOOGTE = SCHERMHOOGTE - SCOREBORDHOOGTE;  

// Aantal spelvlakken (aantal kaarten per as).
int xVelden = 4; // Niet final omdat deze waarde tijdens het spel kan wijzigen
final int YVELDEN = 3;  

// Het veld wordt opgedeeld in delen wat kleinGridBreedte/Hoogte voorsteld.
// Variabelen kunnen pas worden geinitialiseerd zodra de screensize in setup bekend is.
int kaartGridBreedte = schermBreedte / (xVelden * 8);
int kaartGridHoogte = SPEELVELDHOOGTE / (YVELDEN * 8);

int rectHoekRadius = 25;

// Grootte v/d kaarten in pixels.
final int KAARTBREEDTE = schermBreedte / xVelden;
final int KAARTHOOGTE = (SCHERMHOOGTE - SCOREBORDHOOGTE) / YVELDEN;

// Standaard lege kaart; laat een leeg vlak zien.
final String LEGEKAART = "0000"; //<>//

// kleurcodes RGB
final color ROOD = color(255, 50, 50);
final color GROEN = color(100, 255, 100);
final color BLAUW = color(50, 150, 255);
final color WIT = color(255, 255, 255);
final color ZWART = color(0, 0, 0);

// Configuratie waarden voor de diverse figuren
// Betreffen factoren binnen het in een kaart gedefineerde grid (8 x 8)
final float[][] ELLIPSECONFIG = { 
  {4.0}, {3.0}, {5.0}, 
  {2.0}, {4.0}, {6.0} 
};
final float[][] RECHTHOEKCONFIG = { 
  {3.25}, {2.4},{4.4},
  {1.0}, {3.25}, {5.5}
};
final float[][] DRIEHOEKCONFIG = { 
  {4.75, 3.25, 4.75}, 
  {3.75, 2.25, 3.75}, 
  {5.75, 4.25, 5.75}, 
  {2.75, 1.25, 2.75}, 
  {4.75, 3.25, 4.75}, 
  {6.75, 5.25, 6.75} 
};

// Startscherm image, wordt in setup geinitialiseerd.
String achtergrondVideoBestandsLocatie = "RainbowVideo.mov";
String setImgBestandsLocatie = "data/SetLogo.png";
String setSpelregelsBestandsLocatie = "data/Spelregels.png";
String airwolfVideoBestandsLocatie = "AirwolfVideo.mp4";
String airwolfLogoBestandsLocatie = "AirwolfLogo.jpg";

PImage setLogo;
PImage setSpelregels;
PImage airwolfLogo;
Movie airwolfVideo;
Movie achtergrondVideo;
Movie rainbowVideo;

// Bevat alle mogelijke kaarten, '1drv' betekent bijv. 1 driehoek rood vol.        
String kaartenInSpel[] = new String[0];

// Twee dimensionaal array om het speelveld te maken
String[][] speelVeld = new String[xVelden][YVELDEN];
color[][] speelVeldKleur = new color[xVelden][YVELDEN];
color[][] speelkaartBorderKleur = new color[xVelden][YVELDEN];

final String[] AANTALFIGUREN = {"1", "2", "3"};
final String[] KLEURFIGUUR = {"r", "g", "b"}; // rood, groen, blauw
final String[] FIGUURTYPE = {"d", "r", "e"}; // driehoek, rechthoek, ellipse
final String[] VULLINGFIGUUR = {"l", "h", "v"}; // leeg, half, vol

// Lijst met geselecteerde kaarten.
String[] geselecteerdeKaarten = new String[0];

float scoreSpelerEen = 0;
int aantalSetsSpeelveld;
ArrayList<String[]> setsLijst = new ArrayList<String[]>();

// Spel variabelen
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
  naam = naamNieuw.length() >= 10 ? naamNieuw.substring(0, 10) : naamNieuw;
}

int plaatsOpHighscoreLijst;

// Custom font
PFont verdanaBold(int size) {
  return createFont("Verdana Bold", size);
}

void updateTijd() {  
    tijd = millis() / 1000.0 - restartTijd;
}