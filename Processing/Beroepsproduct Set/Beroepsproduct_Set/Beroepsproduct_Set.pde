// Beroepsproduct Set
// Joey Stoffels
// datum

// Aantal figuren:     1, 2, 3
// Vorm v/d figuren:   driehoek, rechthoek, ellips
// Kleur v/d figuren:  rood, groen, blauw

color rood = color(255, 0, 0);
color groen = color(0, 255, 0);
color blauw = color(0, 0, 255);

// ArrayList voor het makkelijk deleten van Strings
ArrayList<String> kaartenArrayList = new ArrayList<String>();

String[] kaartenArray = { "1dr", "2dr", "3dr", 
                          "1rr", "2rr", "3rr", 
                          "1er", "2er", "3er", 
                          "1dg", "2dg", "3dg", 
                          "1rg", "2rg", "3rg", 
                          "1eg", "2eg", "3eg", 
                          "1db", "2db", "3db", 
                          "1rb", "2rb", "3rb", 
                          "1eb", "2eb", "3eb" };

String[][] speelVeld = new String[3][3];

float kleinGridBreedte;
float kleinGridHoogte;
float xOffset;


void setup() {
  size(1000, 1000); 
  kleinGridBreedte = width / 24;
  kleinGridHoogte = height / 24;
  createKaartenArrayList(kaartenArray);
  createSpeelVeld();
}


void createKaartenArrayList(String[] array) {
  for (String kaart : array) {
    kaartenArrayList.add(kaart);
  }
}


String getAndRemoveFromKaarten() {  
  int random = int(random(0, kaartenArrayList.size()));
  String kaart = kaartenArrayList.get(random);
  kaartenArrayList.remove(random);  
  return kaart;
};


void createSpeelVeld() {  
  for (int i=0; i<3; i++) {
    for (int y=0; y<3; y++) {
      speelVeld[y][i] = getAndRemoveFromKaarten();
    }
  }
}


void draw() { 
  background(0);
  tekenVeldLijnen();
  
  for (int i=0; i<3; i++) {
    for (int y=0; y<3; y++) {
      maakFiguur(speelVeld[y][i], y, i);
    }
  }
  
}

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
    case 'd': maakDriehoek(aantal, kleur, xPositie, yPositie); break;
    case 'e': maakEllipse(aantal, kleur, xPositie, yPositie); break;
    case 'r': maakRechthoek(aantal, kleur, xPositie, yPositie); break;
  }
}

// TODO: onderstaande maak functies samenvoegen? Variabele waarden evt in array?
void maakDriehoek(int aantal, color kleur, int xPositie, int yPositie) {
  fill(kleur);
  if (aantal == 1) { 
    createFiguur("driehoek", xPositie, yPositie, 4.75, 3.25, 4.75);
  }

  if (aantal == 2) {
    createFiguur("driehoek", xPositie, yPositie, 3.75, 2.25, 3.75);    
    createFiguur("driehoek", xPositie, yPositie, 5.75, 4.25, 5.75);
  }

  if (aantal == 3) {
    createFiguur("driehoek", xPositie, yPositie, 2.75, 1.25, 2.75);    
    createFiguur("driehoek", xPositie, yPositie, 4.75, 3.25, 4.75);
    createFiguur("driehoek", xPositie, yPositie, 6.75, 5.25, 6.75);
  }
}


void maakEllipse(int aantal, color kleur, int xPositie, int yPositie) {
  fill(kleur);
  if (aantal == 1) {
    createFiguur("ellipse", xPositie, yPositie, 4.0, 0, 0);
  }
  if (aantal == 2) {
    createFiguur("ellipse", xPositie, yPositie, 3.0, 0, 0);
    createFiguur("ellipse", xPositie, yPositie, 5.0, 0, 0);
  }
  if (aantal == 3) {
    createFiguur("ellipse", xPositie, yPositie, 2.0, 0, 0);
    createFiguur("ellipse", xPositie, yPositie, 4.0, 0, 0);
    createFiguur("ellipse", xPositie, yPositie, 6.0, 0, 0);
  }
}


void maakRechthoek(int aantal, color kleur, int xPositie, int yPositie) {
  fill(kleur);
  if (aantal == 1) {
    createFiguur("rechthoek", xPositie, yPositie, 3.25, 0, 0);
  }
  if (aantal == 2) {
    createFiguur("rechthoek", xPositie, yPositie, 2.0, 0, 0);
    createFiguur("rechthoek", xPositie, yPositie, 4.0, 0, 0);
  }
  if (aantal == 3) {
    createFiguur("rechthoek", xPositie, yPositie, 1.0, 0, 0);
    createFiguur("rechthoek", xPositie, yPositie, 3.25, 0, 0);
    createFiguur("rechthoek", xPositie, yPositie, 5.5, 0, 0);
  }
}


// hoogtefactor wijzigt ivm. positie van een, twee of drie figuren ten op zichte van elkaar op 1 kaart
void createFiguur(String figuur, int xPositie, int yPositie, float yHoogteFactorEerste, float yHoogteFactorTweede,float yHoogteFactorDerde) {
  
  float xGridOffset = xPositie*(width/3);
  float yGridOffset = yPositie*(height/3);
  
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