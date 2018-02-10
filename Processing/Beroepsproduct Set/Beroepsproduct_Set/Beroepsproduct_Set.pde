// Beroepsproduct Set
// Joey Stoffels
// datum

// Aantal figuren:     1, 2, 3
// Vorm v/d figuren:   driehoek, rechthoek, ellips
// Kleur v/d figuren:  rood, groen, blauw

// kleurcodes RGB
final color rood = color(255, 0, 0);
final color groen = color(0, 255, 0);
final color blauw = color(0, 0, 255);

// ArrayList ipv. array voor het makkelijk deleten van Strings
ArrayList<String> kaartenArrayList = new ArrayList<String>();

// Alle mogelijke kaarten
final String[] kaartenArray = { "1dr", "2dr", "3dr", 
                                "1rr", "2rr", "3rr", 
                                "1er", "2er", "3er", 
                                "1dg", "2dg", "3dg", 
                                "1rg", "2rg", "3rg", 
                                "1eg", "2eg", "3eg", 
                                "1db", "2db", "3db", 
                                "1rb", "2rb", "3rb", 
                                "1eb", "2eb", "3eb" };

// Twee dimensionaal array om het speelveld te maken
String[][] speelVeld = new String[3][3];

// Het veld wordt opgedeeld in delen wat kleinGridBreedte/Hoogte voorsteld.
float kleinGridBreedte;
float kleinGridHoogte;


// Setup van scherm grootte, aantal vakken voor kleinGridBreedte/Hoogte instellen,
// het initialiseren van de ArrayList en het maken van het speelveld.
void setup() {
  size(1000, 1000); 
  kleinGridBreedte = width / 24;
  kleinGridHoogte = height / 24;
  createKaartenArrayList(kaartenArray);
  createSpeelVeld();
}


// Functie om de kaartenArrayList te vullen met de gegevens uit de kaartenArray.
void createKaartenArrayList(String[] array) {
  for (String kaart : array) {
    kaartenArrayList.add(kaart);
  }
}


// Functie om een random kaart te kiezen uit de kaartenArrayList en deze 
// vervolgens te verwijderen uit de lijst, de kaartenArrayList stel dus 
// de huidige stapel speelkaarten voor.
String getAndRemoveFromKaarten() {  
  int random = int(random(0, kaartenArrayList.size()));
  String kaart = kaartenArrayList.get(random);
  kaartenArrayList.remove(random);  
  return kaart;
};


// Functie om het speelveld te initialiseren.
void createSpeelVeld() {  
  for (int i=0; i<3; i++) {
    for (int y=0; y<3; y++) {
      speelVeld[y][i] = getAndRemoveFromKaarten();
    }
  }
}


// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  background(0);
  tekenVeldLijnen();
  
  for (int i=0; i<3; i++) {
    for (int y=0; y<3; y++) {
      maakFiguur(speelVeld[y][i], y, i);
    }
  }
}


// Generieke functie om kaarten te maken.
void maakFiguur(String kaart, int xPositie, int yPositie) {
  int aantal = Integer.parseInt(str(kaart.charAt(0)));
  char figuurChar = kaart.charAt(1);
  char kleurChar = kaart.charAt(2);
  color kleur;
    
  switch (kleurChar) {
    case 'r': kleur = rood; break;
    case 'g': kleur = groen; break;
    case 'b': kleur = blauw; break;
    default: kleur = color(255, 255, 255); // wordt nooit gezet, default nodig ivm compile error in volgende switch
  }
  
  switch (figuurChar) {
    case 'd': createFiguur("driehoek", aantal, kleur, xPositie, yPositie); break;
    case 'e': createFiguur("ellipse", aantal, kleur, xPositie, yPositie); break;
    case 'r': createFiguur("rechthoek", aantal, kleur, xPositie, yPositie); break;
  }
}


// Functie om figuur aan te maken.
// Hoogtefactor wijzigt ivm. positie van een, twee of drie figuren ten op zichte van elkaar op 1 kaart.
void createFiguur(String figuur, int aantal, color kleur, int xPositie, int yPositie) {  
  final float xGridOffset = xPositie*(width/3);
  final float yGridOffset = yPositie*(height/3);
  
  //Configuratie waarden voor de diverse figuren
  final float[][] ellipseConfig = { {4.0, 0, 0}, {3.0, 0, 0}, {5.0, 0, 0}, {2.0, 0, 0}, {4.0, 0, 0}, {6.0, 0, 0} };
  final float[][] rechthoekConfig = { {3.25, 0, 0}, {2.0, 0, 0}, {4.0, 0, 0}, {1.0, 0, 0}, {3.25, 0, 0}, {5.5, 0, 0} };
  final float[][] driehoekConfig = { {4.75, 3.25, 4.75}, {3.75, 2.25, 3.75}, {5.75, 4.25, 5.75}, {2.75, 1.25, 2.75}, {4.75, 3.25, 4.75}, {6.75, 5.25, 6.75} };

  float[][] config = (figuur == "rechthoek" ? rechthoekConfig : (figuur == "ellipse" ? ellipseConfig : driehoekConfig));
  
  final int forLoopHelperValue = (aantal == 3 ? 0 : 1);
  
  for (int y = aantal - forLoopHelperValue; y < aantal + aantal - forLoopHelperValue; y++) { 
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


void tekenVeldLijnen() {
  stroke(255);
  line(0, height/3, width, height/3);

  stroke(255);
  line(0, height/3 * 2, width, height/3 * 2);

  stroke(255);
  line(width/3, 0, width/3, height);

  stroke(255);
  line(width/3 * 2, 0, width/3 * 2, height);
}