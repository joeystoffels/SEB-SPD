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