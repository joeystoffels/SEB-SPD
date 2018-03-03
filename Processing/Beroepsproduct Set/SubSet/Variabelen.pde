// Grootte v/d kaarten in pixels.
int kaartBreedte;
int kaartHoogte = 200;

// Standaard lege kaart; laat een leeg vlak zien.
final String legeKaart = "0000";

// kleurcodes RGB
final color rood = color(255, 50, 50);
final color groen = color(100, 255, 100);
final color blauw = color(0, 100, 255);
final color wit = color(255, 255, 255);
final color zwart = color(0, 0, 0);

//Configuratie waarden voor de diverse figuren
final float[][] ellipseConfig = { {4.0, 0, 0}, {3.0, 0, 0}, {5.0, 0, 0}, {2.0, 0, 0}, {4.0, 0, 0}, {6.0, 0, 0} };
final float[][] rechthoekConfig = { {3.25, 0, 0}, {2.0, 0, 0}, {4.0, 0, 0}, {1.0, 0, 0}, {3.25, 0, 0}, {5.5, 0, 0} };
final float[][] driehoekConfig = { {4.75, 3.25, 4.75}, {3.75, 2.25, 3.75}, {5.75, 4.25, 5.75}, {2.75, 1.25, 2.75}, {4.75, 3.25, 4.75}, {6.75, 5.25, 6.75} };

// Startscherm image, wordt in setup geinitialiseerd.
PImage img;



// Worden in setupSpel() geinitialiseerd.
int hoogteScorebord;
int hoogteSpeelveld;

// ArrayList ipv. array voor het makkelijk deleten van Strings.
// Bevat alle mogelijke kaarten, '1drv' betekent bijv. 1 driehoek rood vol.                    
ArrayList<String> kaartenInSpel = new ArrayList<String>();

// Twee dimensionaal array om het speelveld te maken
String[][] speelVeld;
color[][] speelVeldKleur;

// Het veld wordt opgedeeld in delen wat kleinGridBreedte/Hoogte voorsteld.
// Variabelen kunnen pas worden geinitialiseerd zodra de screensize in setup bekend is.
float kleinGridBreedte;
float kleinGridHoogte;

final String[] aantalFiguren = {"1", "2", "3"};
final String[] kleurFiguur = {"r", "g", "b"}; // rood, groen, blauw
final String[] figuurType = {"d", "r", "e"}; // driehoek, rechthoek, ellipse
final String[] vullingFiguur = {"l", "h", "v"}; // leeg, half, vol

// Lijst met geselecteerde kaarten.
ArrayList<String> geselecteerdeKaarten = new ArrayList<String>();

float scoreSpelerEen = 0;
//int scoreSpelerTwee = 0; // Future feature
int aantalSetsSpeelveld;
ArrayList<String[]> setsLijst = new ArrayList<String[]>();

// Gamestate variabelen
int aantalVariaties = 3;

boolean scoreOpgeslagen = false;
boolean gameRestart = false;
boolean startSchermActive = true;
boolean spelAfgelopen = false;
boolean voegXVeldToe = false;

String naam = "";

float tijd = 0.0;
float restartTijd = 0.0;

int aantalKaartenOpSpeelveld = 0;

// Aantal spelvlakken (aantal kaarten per as).
int xVelden = 4; // Niet final omdat deze waarde tijdens het spel kan wijzigen
final int yVelden = 3;  


// Filter functie om max lengte v/d naam op 10 karakters te zetten
void setNaam(String naamNieuw) {    
  if (naamNieuw.length() >= 10){ 
   naamNieuw = naamNieuw.substring(0, 10); 
  }   
  naam = naamNieuw;
}

// Custom font
PFont verdanaBold(int size) {
  return createFont("Verdana Bold", size);
}