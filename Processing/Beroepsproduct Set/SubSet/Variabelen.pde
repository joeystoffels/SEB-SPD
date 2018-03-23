// Verzameltab voor alle globale variabelen binnen de applicatie. //<>//
// De niet-final variabelen kunnen tijdens het spel wijzigen.

/**********************************
*
* Afmetingen variabelen
*
***********************************/

// Afmetingen van het scherm.
int schermBreedte = 700;
final int SCHERM_HOOGTE = int(schermBreedte * 1.2);

// Afmetingen van het scorebord.
final int SCOREBORD_HOOGTE = 100;

// Afmetingen van het speelveld.
final int SPEELVELD_HOOGTE = SCHERM_HOOGTE - SCOREBORD_HOOGTE;  

// Aantal spelvlakken (aantal kaarten per as).
int xVelden = 4;
final int YVELDEN = 3;  

// Het speelveld wordt opgedeeld in delen wat kleinGridBreedte/Hoogte voorsteld.
int kaartGridBreedte = schermBreedte / (xVelden * 8);
final int KAART_GRID_HOOGTE = SPEELVELD_HOOGTE / (YVELDEN * 8);

// Grootte v/d kaarten in pixels.
final int KAART_BREEDTE = schermBreedte / 4;
final int KAART_HOOGTE = (SCHERM_HOOGTE - SCOREBORD_HOOGTE) / YVELDEN;



/**********************************
*
* Configuratie variabelen
*
***********************************/

// Twee dimensionaal array om het speelveld te maken
String[][] speelVeld = new String[xVelden][YVELDEN];
color[][] speelVeldKleur = new color[xVelden][YVELDEN];
color[][] speelkaartBorderKleur = new color[xVelden][YVELDEN];

// Bevat alle mogelijke kaarten, '1drv' betekent bijv. 1 driehoek rood vol.        
String kaartenInSpel[] = new String[0];

// Lijst met geselecteerde kaarten.
String[] geselecteerdeKaarten = new String[0];

// Lijst waarin alle sets worden bijgehouden.
ArrayList<String[]> setsLijst = new ArrayList<String[]>();
  
// Mogelijke variaties voor de speelkaarten.
final String[] AANTAL_FIGUREN = {"1", "2", "3"};
final String[] KLEUR_FIGUUR = {"r", "g", "b"}; // rood, groen, blauw
final String[] FIGUUR_TYPE = {"d", "r", "e"}; // driehoek, rechthoek, ellipse
final String[] VULLING_FIGUUR = {"l", "h", "v"}; // leeg, half, vol

// Standaard lege kaart; laat een leeg vlak zien.
final String LEGE_KAART = "0000";

// Configuratie waarden voor de diverse figuren.
// Betreffen factoren binnen het in een kaart gedefineerde grid (8 x 8).
// Worden gebruikt voor het tekenen van de figuren op het speelveld.
final float[][] ELLIPSE_CONFIG = { 
  {4.0}, {3.0}, {5.0}, 
  {2.0}, {4.0}, {6.0} 
};
final float[][] RECHTHOEK_CONFIG = { 
  {3.25}, {2.4}, {4.4}, 
  {1.0}, {3.25}, {5.5}
};
final float[][] DRIEHOEK_CONFIG = { 
  {4.75, 3.25, 4.75}, 
  {3.75, 2.25, 3.75}, 
  {5.75, 4.25, 5.75}, 
  {2.75, 1.25, 2.75}, 
  {4.75, 3.25, 4.75}, 
  {6.75, 5.25, 6.75} 
};



/**********************************
*
* Styling variabelen
*
***********************************/

// Ronding van de rechthoeken.
final int RECT_HOEK_RADIUS = 25;

// Kleurcodes voor diverse kleuren.
final color ROOD = color(255, 50, 50);
final color GROEN = color(100, 255, 100);
final color BLAUW = color(50, 150, 255);
final color WIT = color(255, 255, 255);
final color ZWART = color(0, 0, 0);



/**********************************
*
* Media variabelen
*
***********************************/

// Diverse mediabestanden.
PImage setLogo;
PImage setSpelregels;
PImage airwolfLogo;
Movie airwolfVideo;
Movie achtergrondVideo;
Movie rainbowVideo;

// Bestandslocaties van mediabestanden.
String achtergrondVideoBestandsLocatie = "RainbowVideo.mov";
String setImgBestandsLocatie = "data/SetLogo.png";
final String SET_SPELREGELS_BESTANDS_LOCATIE = "data/Spelregels.png";
final String AIRWOLF_VIDEO_BESTANDS_LOCATIE = "AirwolfVideo.mp4";
final String AIRWOLF_LOGO_BESTANDS_LOCATIE = "AirwolfLogo.jpg";



/**********************************
*
* Spel variabelen
*
***********************************/

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
float scoreSpelerEen = 0;
int aantalSetsSpeelveld;
int plaatsOpHighscoreLijst;



/**********************************
*
* Overige functies
*
***********************************/


// Filter functie om max lengte v/d naam op 10 karakters te zetten
void setNaam(String naamNieuw) {      
  naam = naamNieuw.length() >= 10 ? naamNieuw.substring(0, 10) : naamNieuw;
}

// Functie om de tijd te updaten.
void updateTijd() {  
  tijd = millis() / 1000.0 - restartTijd;
}

// Functie om een custom size verdana bold font te maken.
PFont verdanaBold(int size) {
  return createFont("Verdana Bold", size);
}