// Beroepsproduct Set
// Joey Stoffels
// datum


// Aantal spelvlakken (aantal kaarten per as).
final int xVelden = 6;
final int yVelden = 1;  

// Grootte v/d kaarten in pixels.
final int kaartBreedte = 150;
final int kaartHoogte = 200;

// kleurcodes RGB
final color rood = color(255, 0, 0);
final color groen = color(0, 255, 0);
final color blauw = color(0, 0, 255);

// ArrayList ipv. array voor het makkelijk deleten van Strings.
// Bevat alle mogelijke kaarten.
ArrayList<String> kaartenArrayList = new ArrayList<String>(java.util.Arrays.asList(
                    "1dr", "2dr", "3dr", "1rr", "2rr", "3rr", "1er", "2er", "3er", 
                    "1dg", "2dg", "3dg", "1rg", "2rg", "3rg", "1eg", "2eg", "3eg", 
                    "1db", "2db", "3db", "1rb", "2rb", "3rb", "1eb", "2eb", "3eb"));

// Twee dimensionaal array om het speelveld te maken
String[][] speelVeld = new String[xVelden][yVelden];

// Het veld wordt opgedeeld in delen wat kleinGridBreedte/Hoogte voorsteld.
// Variabelen kunnen pas worden geinitialiseerd zodra de screensize in setup bekend is.
float kleinGridBreedte;
float kleinGridHoogte;


// Setup van scherm grootte, aantal vakken voor kleinGridBreedte/Hoogte instellen,
// het initialiseren van de ArrayList en het maken van het speelveld.
void setup() {
  surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte); 
  kleinGridBreedte = width / (xVelden * 8);
  kleinGridHoogte = height / (yVelden * 8);
  createSpeelVeld();
}


// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  background(0);
  tekenVeldLijnen();
  vulSpeelveld();
}


// Functie om het speelveld te initialiseren.
void createSpeelVeld() {  
  for (int x=0; x < xVelden; x++) {
    for (int y=0; y < yVelden; y++) {
      speelVeld[x][y] = getAndRemoveFromKaarten();
    }
  }
}


// Functie om een random kaart te kiezen uit de kaartenArrayList en deze 
// vervolgens te verwijderen uit de lijst, de kaartenArrayList stelt dus 
// de huidige stapel speelkaarten voor.
String getAndRemoveFromKaarten() {  
  int random = int(random(0, kaartenArrayList.size()));
  String kaart = kaartenArrayList.get(random);
  kaartenArrayList.remove(random);  
  return kaart;
};


// Functie om het speelveld te vullen met kaarten.
void vulSpeelveld() {
  for (int x=0; x < xVelden; x++) {
    for (int y=0; y < yVelden; y++) {
      createFiguur(speelVeld[x][y], x, y);
    }
  }
}


// Functie om figuur aan te maken.
// Hoogtefactor wijzigt ivm. positie van een, twee of drie figuren ten op zichte van elkaar op 1 kaart.
void createFiguur(String kaart, int xPositie, int yPositie) {  
  
  int aantal = Integer.parseInt(str(kaart.charAt(0)));
  char figuurChar = kaart.charAt(1);
  char kleurChar = kaart.charAt(2);
  
  color kleur = (kleurChar == 'r' ? rood : (kleurChar == 'g' ? groen : blauw));
  String figuur = (figuurChar == 'r' ? "rechthoek" : (figuurChar == 'e' ? "ellipse" : "driehoek"));
  
  final float xGridOffset = xPositie*(width/xVelden);
  final float yGridOffset = yPositie*(height/yVelden);
  
  //Configuratie waarden voor de diverse figuren
  final float[][] ellipseConfig = { {4.0, 0, 0}, {3.0, 0, 0}, {5.0, 0, 0}, {2.0, 0, 0}, {4.0, 0, 0}, {6.0, 0, 0} };
  final float[][] rechthoekConfig = { {3.25, 0, 0}, {2.0, 0, 0}, {4.0, 0, 0}, {1.0, 0, 0}, {3.25, 0, 0}, {5.5, 0, 0} };
  final float[][] driehoekConfig = { {4.75, 3.25, 4.75}, {3.75, 2.25, 3.75}, {5.75, 4.25, 5.75}, {2.75, 1.25, 2.75}, {4.75, 3.25, 4.75}, {6.75, 5.25, 6.75} };

  float[][] config = (figuur == "rechthoek" ? rechthoekConfig : (figuur == "ellipse" ? ellipseConfig : driehoekConfig));
  
  final int forLoopHelperValue = aantal - (aantal == 3 ? 0 : 1);
  
  for (int y = forLoopHelperValue; y < aantal + forLoopHelperValue; y++) { 
    float yHoogteFactorEerste = config[y][0];
    float yHoogteFactorTweede = config[y][1];
    float yHoogteFactorDerde = config[y][2];    
  
    fill(kleur);
  
    if (figuur == "driehoek") {
        triangle((kleinGridBreedte * 2.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorEerste) + yGridOffset, 
                (kleinGridBreedte * 4.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorTweede) + yGridOffset, 
                (kleinGridBreedte * 6.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorDerde) + yGridOffset);
    }
    if (figuur == "rechthoek") {
        rect((kleinGridBreedte * 2.1) + xGridOffset, (kleinGridHoogte * yHoogteFactorEerste) + yGridOffset, 
                (kleinGridBreedte * 4.0), (kleinGridHoogte * 1.5));
    }
    if (figuur == "ellipse") {
        ellipse((kleinGridBreedte * 4.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorEerste) + yGridOffset, 
                (kleinGridBreedte * 4.0), (kleinGridHoogte * 1.5));
    }
  }  
}


// Functie om de veldlijnen te tekenen.
void tekenVeldLijnen() {    
  stroke(255);
  
  for (int x = 1; x < yVelden; x++) {
   line(0, height/yVelden * x, width, height/yVelden * x);
  }
  
  for (int y = 1; y < xVelden; y++) {
     line(width/xVelden * y, 0, width/xVelden * y, height);
  }  
}