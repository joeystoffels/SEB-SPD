int aantalVariaties = 3; // TODO add constraint 3 of 4;

// Grootte v/d kaarten in pixels.
final int kaartBreedte = 150; // TODO add constraint max breedte en hoogte
final int kaartHoogte = 200;

// Aantal spelvlakken (aantal kaarten per as).
int xVelden = 4; // TODO add constraint max x en y
final int yVelden = 3;  

// Default kaart; laat leeg vlak zien.
String defaultKaart = "0000";

// kleurcodes RGB
final color rood = color(255, 50, 50);
final color groen = color(100, 255, 100);
final color blauw = color(0, 100, 255);
final color wit = color(255, 255, 255);
final color zwart = color(0, 0, 0);

PImage img;

// height - hoogteScorebord als variabele declareren?

int hoogteScorebord;

// ArrayList ipv. array voor het makkelijk deleten van Strings.
// Bevat alle mogelijke kaarten, '1drv' betekent bijv. 1 driehoek rood vol.                    
ArrayList<String> kaartenArrayList = new ArrayList<String>();

// Twee dimensionaal array om het speelveld te maken
String[][] speelVeld;
color[][] speelVeldKleur;

// Het veld wordt opgedeeld in delen wat kleinGridBreedte/Hoogte voorsteld.
// Variabelen kunnen pas worden geinitialiseerd zodra de screensize in setup bekend is.
float kleinGridBreedte;
float kleinGridHoogte;

// Lijst met geselecteerde kaarten.
ArrayList<String> selectedKaarten = new ArrayList<String>();

float scoreSpelerEen = 0;
//int scoreSpelerTwee = 0;
int aantalSetsSpeelveld;
ArrayList<String[]> setList = new ArrayList<String[]>();

// Custom font
PFont fontVerdanaBold;
boolean voegXVeldToe = false;

// Tijd
int tijd = 0;

boolean startSchermBoolean = false;