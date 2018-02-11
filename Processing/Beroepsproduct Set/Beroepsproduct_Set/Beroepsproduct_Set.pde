// Beroepsproduct Set
// Joey Stoffels
// datum

// height - hoogteScorebord als variabele declareren?

int aantalVariaties = 3; // TODO add constraint 3 of 4;

// Aantal spelvlakken (aantal kaarten per as).
final int xVelden = 4; // TODO add constraint max x en y
final int yVelden = 3;  

// Grootte v/d kaarten in pixels.
final int kaartBreedte = 150; // TODO add constraint max breedte en hoogte
final int kaartHoogte = 200;
int hoogteScorebord;

// kleurcodes RGB
final color rood = color(255, 0, 0);
final color groen = color(0, 255, 0);
final color blauw = color(0, 0, 255);
final color wit = color(255, 255, 255);
final color zwart = color(0, 0, 0);

// ArrayList ipv. array voor het makkelijk deleten van Strings.
// Bevat alle mogelijke kaarten, '1drv' betekent bijv. 1 driehoek rood vol.                    
ArrayList<String> kaartenArrayList = new ArrayList<String>();

// Default kaart, laat leeg vlak zien.
String defaultKaart = "0000";

// Twee dimensionaal array om het speelveld te maken
String[][] speelVeld = new String[xVelden][yVelden];
color[][] speelVeldKleur = new color[xVelden][yVelden];

// Het veld wordt opgedeeld in delen wat kleinGridBreedte/Hoogte voorsteld.
// Variabelen kunnen pas worden geinitialiseerd zodra de screensize in setup bekend is.
float kleinGridBreedte;
float kleinGridHoogte;

// Lijst met geselecteerde kaarten.
ArrayList<String> selectedKaarten = new ArrayList<String>();

int scoreSpelerEen = 0;
//int scoreSpelerTwee = 0;
int aantalSetsSpeelveld;


// Setup van scherm grootte, aantal vakken voor kleinGridBreedte/Hoogte instellen,
// het initialiseren van de ArrayList en het maken van het speelveld.
void setup() {
  background(zwart);
  surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte); 
  hoogteScorebord = int(height * 0.15);
  kleinGridBreedte = width / (xVelden * 8);
  kleinGridHoogte = (height - hoogteScorebord) / (yVelden * 8);
  maakStapelKaarten(aantalVariaties);
  createSpeelVeld();    
  aantalSetsSpeelveld();
}


// Functie voor het weergeven van de inhoud van het scherm.
void draw() { 
  background(zwart);
  smooth();
  tekenVeldLijnen();
  kleurCellen();
  vulSpeelveld();  
  maakScorebord();
}


// Muisklik functie om kaarten te kunnen selecteren.
// Deze functie triggert het checken op een set na het selecteren van 3 kaarten.
void mousePressed() {  
  int xVeld = mouseX / (width/xVelden);
  int yVeld = mouseY / ((height - hoogteScorebord)/yVelden);

  // return indien er buiten het speelveld geklikt is.
  if (mouseY >= height - hoogteScorebord) {
    return;
  }

  String kaart = speelVeld[xVeld][yVeld]; 

  if (kaart == defaultKaart) {
    return;
  }

  if (selectedKaarten.contains(kaart)) {
    speelVeldKleur[xVeld][yVeld] = color(0, 0, 0);
    selectedKaarten.remove(kaart);
  } else {  
    if (!selectedKaarten.contains(kaart) && selectedKaarten.size() < 3) {
      selectedKaarten.add(speelVeld[xVeld][yVeld]);
      speelVeldKleur[xVeld][yVeld] = color(255, 0, 0, 150);
      if (selectedKaarten.size() == 3) { 
        checkForSet();
      }
    }
  }
}


void maakStapelKaarten(int aantalVariaties) {
  String[] aantal = {"1", "2", "3"};
  String[] kleur = {"r", "g", "b"}; // rood, groen, blauw
  String[] figuur = {"d", "r", "e"}; // driehoek, rechthoek, ellipse
  String[] vulling = {"l", "h", "v"}; // leeg, half, vol

  if (aantalVariaties == 4) {
    for (int a = 0; a < aantal.length; a++) {
      for (int f = 0; f < figuur.length; f++) {
        for (int k = 0; k < kleur.length; k++) {
          for (int v = 0; v < vulling.length; v++) {
            kaartenArrayList.add(aantal[a] + figuur[f] + kleur[k] + vulling[v]);
          }
        }
      }
    }
  }

  if (aantalVariaties == 3) {
    for (int a = 0; a < aantal.length; a++) {
      for (int f = 0; f < figuur.length; f++) {
        for (int k = 0; k < kleur.length; k++) {
          kaartenArrayList.add(aantal[a] + figuur[f] + kleur[k] + "0"); // "0" als default waarde zodat verifySet() goed uitgevoerd wordt
        }
      }
    }
  }

  println("Kaartenstapel: " + kaartenArrayList);
  println("Totaal aantal kaarten: " + kaartenArrayList.size());
}


// Functie voor in draw() om continu de achtergrond van de kaarten te kleuren.
void kleurCellen() {  
  for (int x = 0; x < xVelden; x++) {
    for (int y = 0; y < yVelden; y++) {
      fill(speelVeldKleur[x][y]);
      rect((width/xVelden) * x, ((height - hoogteScorebord)/yVelden) * y, width/xVelden, (height - hoogteScorebord)/yVelden);
    }
  }
}


// Functie om een set te checken.
void checkForSet() {    
  String kaartEen = selectedKaarten.get(0);
  String kaartTwee = selectedKaarten.get(1);
  String kaartDrie = selectedKaarten.get(2);

  if (verifySet(kaartEen, kaartTwee, kaartDrie, 0) &&
    verifySet(kaartEen, kaartTwee, kaartDrie, 1) &&
    verifySet(kaartEen, kaartTwee, kaartDrie, 2) && 
    verifySet(kaartEen, kaartTwee, kaartDrie, 3)) {
    scoreSpelerEen++;
    verwijderKaart(kaartEen);
    verwijderKaart(kaartTwee);
    verwijderKaart(kaartDrie);
    selectedKaarten.removeAll(selectedKaarten);  
    aantalSetsSpeelveld = 0; // reset aantal sets wanneer er een set gevonden is.
    aantalSetsSpeelveld(); // tel opnieuw het aantal sets op het huidige speelveld.
    println("SET: " + kaartEen + " " + kaartTwee + " " + kaartDrie);

    // Reset alle kaart achtergrond kleuren.
    for (int x = 0; x < xVelden; x++) {
      for (int y = 0; y < yVelden; y++) {
        speelVeldKleur[x][y] = zwart;
      }
    }
  }
}


void aantalSetsSpeelveld() {

  ArrayList<String[]> setList = new ArrayList<String[]>();

  String[][] arrayEen = speelVeld;
  String[][] arrayTwee = speelVeld;
  String[][] arrayDrie = speelVeld;

  for (int a = 0; a < xVelden; a++) {
    for (int b = 0; b < yVelden; b++) {      
      for (int c = 0; c < xVelden; c++) {
        for (int d = 0; d < yVelden; d++) {      
          for (int e = 0; e < xVelden; e++) {
            for (int f = 0; f < yVelden; f++) {      

              String kaartEen = arrayEen[a][b];
              String kaartTwee = arrayTwee[c][d];
              String kaartDrie = arrayDrie[e][f];

              String[] test = {kaartEen, kaartTwee, kaartDrie};
              
              java.util.Arrays.sort(test);

              // Helper boolean om te checken of de set al geteld is.
              boolean go = true;

              for (int x = 0; x < setList.size(); x++) {
                  if (java.util.Arrays.equals(setList.get(x), test)) {
                    go = false;
                    break;
                  } else {
                    go = true;
                  }
                
              }

              if ((!kaartEen.equals(kaartTwee) && !kaartTwee.equals(kaartDrie) && !kaartEen.equals(kaartDrie)) && go) {
                if (verifySet(kaartEen, kaartTwee, kaartDrie, 0) &&
                  verifySet(kaartEen, kaartTwee, kaartDrie, 1) &&
                  verifySet(kaartEen, kaartTwee, kaartDrie, 2) && 
                  (aantalVariaties == 4 ? verifySet(kaartEen, kaartTwee, kaartDrie, 3) : true)) {
                  aantalSetsSpeelveld++;                  
                  setList.add(test);
                }
              }
            }
          }
        }
      }
    }
  }
  for ( String[] set : setList ) {
    println(set);
  }
}


// Verwijdert de kaart van het huidige speelbord.
void verwijderKaart(String kaart) {
  for (int x = 0; x < xVelden; x++) {
    for (int y = 0; y < yVelden; y++) {      
      if (speelVeld[x][y] == kaart) {
        speelVeld[x][y] = getAndRemoveFromKaarten();
      }
    }
  }
}


// Generieke helper functie voor het verifieren van een set.
boolean verifySet(String kaartEen, String kaartTwee, String kaartDrie, int charToCheck) {
  if (!(kaartEen == defaultKaart || kaartTwee == defaultKaart || kaartDrie == defaultKaart)) {
    if ((kaartEen.charAt(charToCheck) == kaartTwee.charAt(charToCheck) && kaartTwee.charAt(charToCheck) == kaartDrie.charAt(charToCheck) && kaartEen.charAt(charToCheck) == kaartDrie.charAt(charToCheck))  || 
      (kaartEen.charAt(charToCheck) != kaartTwee.charAt(charToCheck) && kaartTwee.charAt(charToCheck) != kaartDrie.charAt(charToCheck) && kaartEen.charAt(charToCheck) != kaartDrie.charAt(charToCheck))) {
      //println(kaartEen, kaartTwee, kaartDrie, charToCheck, aantalSetsSpeelveld); 
      return true;
    }
  }
  return false;
}



// Functie om het speelveld (array) te initialiseren.
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
  if (!(kaartenArrayList.size() <= 0)) { 
    int random = int(random(0, kaartenArrayList.size()));
    String kaart = kaartenArrayList.get(random);
    kaartenArrayList.remove(random);  
    return kaart;
  } else {
    return defaultKaart; // return default zodat er geen nieuwe figuur gemaakt wordt
  }
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
  char vullingChar = kaart.charAt(3);

  color kleur = (kleurChar == 'r' ? rood : (kleurChar == 'g' ? groen : blauw));
  int vulling = (vullingChar == 'l' ? 0 : (vullingChar == 'h' ? 100 : 255));
  String figuur = (figuurChar == 'r' ? "rechthoek" : (figuurChar == 'e' ? "ellipse" : "driehoek"));

  final float xGridOffset = xPositie*(width/xVelden);
  final float yGridOffset = yPositie*((height - hoogteScorebord)/yVelden);

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

    strokeWeight(3);
    stroke(kleur);
    fill(kleur, vulling);

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

    stroke(wit);
  }
}


// Aanmaken van het scorebord, de hoogte hiervan staat vast op 15% van de hoogte.
void maakScorebord() {
  // Achtergrond verversen
  fill(zwart);
  rect(0, height, width, - hoogteScorebord);

  // Score weergeven, dubbele text velden voor betere allignment.
  fill(wit);
  text("Score: ", 0 + (width * 0.1), height - (hoogteScorebord / 7) * 5); 
  text("Tijd: ", 0 + (width * 0.1), height - (hoogteScorebord / 7) * 4 );  
  text("Kaarten over: ", 0 + (width * 0.1), height - (hoogteScorebord / 7) * 3);
  text("Aantal sets: ", 0 + (width * 0.1), height - (hoogteScorebord / 7) * 2);

  text(scoreSpelerEen, 0 + (width * 0.35), height - (hoogteScorebord / 7) * 5); 
  text(millis()/1000, 0 + (width * 0.35), height - (hoogteScorebord / 7) * 4);  
  text(kaartenArrayList.size(), 0 + (width * 0.35), height - (hoogteScorebord / 7) * 3);
  text(aantalSetsSpeelveld, 0 + (width * 0.35), height - (hoogteScorebord / 7) * 2);
}


// Functie om de veldlijnen te tekenen.
void tekenVeldLijnen() {    
  stroke(255);

  for (int x = 1; x < yVelden; x++) {
    line(0, (height - hoogteScorebord)/yVelden * x, width, (height - hoogteScorebord)/yVelden * x);
  }

  for (int y = 1; y < xVelden; y++) {
    line(width/xVelden * y, 0, width/xVelden * y, height - hoogteScorebord);
  }  

  // Laatste lijn van het speelveld, begin van het scorebord.
  line(0, height - hoogteScorebord, width, height - hoogteScorebord);
}