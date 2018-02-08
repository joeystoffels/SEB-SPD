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

void setup() {
  size(500,650); 
  createKaartenArrayList(kaartenArray);
  createSpeelVeld();  
  kleinGridBreedte = width / 24;
  kleinGridHoogte = height / 24;
}

void createKaartenArrayList(String[] array) {
    for (String kaart : array){
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
  
  //text(speelVeld[0][0], 10, 25);
  //text(speelVeld[0][1], 50, 25);
  //text(speelVeld[0][2], 90, 25);
  //text(speelVeld[1][0], 10, 50);
  //text(speelVeld[1][1], 50, 50);
  //text(speelVeld[1][2], 90, 50);
  //text(speelVeld[2][0], 10, 75);
  //text(speelVeld[2][0], 50, 75);
  //text(speelVeld[2][0], 90, 75);
  
  driehoek(1, rood, 0, 0);
  driehoek(2, blauw, 0, 1);
  driehoek(1, groen, 0, 2);
  
  driehoek(2, blauw, 1, 0);
  driehoek(2, rood, 1, 1);
  driehoek(3, rood, 1, 2); 
  
  driehoek(3, groen, 2, 0);
  driehoek(3, blauw, 2, 1);
  driehoek(1, groen, 2, 2);  
}

void driehoek(int aantal, color kleur, int xPositie, int yPositie) {
  fill(kleur);
  if (aantal == 1){ 
    createDriehoek(2.0, 4.5, 4.0, 3.25, 6.0, 4.5, xPositie, yPositie);
  }
  
  if (aantal == 2){
    createDriehoek(2.0, 3.0, 4.0, 1.75, 6.0, 3.0, xPositie, yPositie);
    createDriehoek(2.0, 6.0, 4.0, 4.75, 6.0, 6.0, xPositie, yPositie);
  }
  
  if (aantal == 3){
    createDriehoek(2.0, 2.0, 4.0, 0.75, 6.0, 2.0, xPositie, yPositie);
    createDriehoek(2.0, 4.5, 4.0, 3.25, 6.0, 4.5, xPositie, yPositie);
    createDriehoek(2.0, 7.0, 4.0, 5.75, 6.0, 7.0, xPositie, yPositie);
  }
}

void createDriehoek(float xBreedteFactorEerste, float yHoogteFactorEerste, float xBreedteFactorTweede, float yHoogteFactorTweede, float xBreedteFactorDerde, float yHoogteFactorDerde, int xPositie, int yPositie) {
    triangle((kleinGridBreedte * xBreedteFactorEerste) + (xPositie*(width/3)), (kleinGridHoogte * yHoogteFactorEerste) + (yPositie*(height/3)), 
    (kleinGridBreedte * xBreedteFactorTweede) + (xPositie*(width/3)), (kleinGridHoogte * yHoogteFactorTweede) + (yPositie*(height/3)), 
    (kleinGridBreedte * xBreedteFactorDerde) + (xPositie*(width/3)), (kleinGridHoogte * yHoogteFactorDerde) + (yPositie*(height/3))); 
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