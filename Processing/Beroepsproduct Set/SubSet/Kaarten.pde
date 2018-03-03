// Functie om een random kaart te kiezen uit de kaartenInSpel array en deze 
// vervolgens te verwijderen uit de lijst, de kaartenInSpel array stelt dus 
// de huidige stapel speelkaarten voor.
String pakKaart() { 
  if (!(kaartenInSpel.size() <= 0)) { 
    int random = int(random(0, kaartenInSpel.size()));
    String kaart = kaartenInSpel.get(random);
    kaartenInSpel.remove(random);  
    return kaart;
  } else {
    return standaardKaart; // return standaard zodat er geen nieuwe figuur gemaakt wordt
  }
};


// Functie om figuur aan te maken.
// Hoogtefactor wijzigt ivm. positie van een, twee of drie figuren ten op zichte van elkaar op 1 kaart.
void maakKaartFiguur(String kaart, int xPositie, int yPositie) {    
  int aantal = Integer.parseInt(str(kaart.charAt(0)));
  char figuurChar = kaart.charAt(1);
  char kleurChar = kaart.charAt(2);
  char vullingChar = kaart.charAt(3);

  color kleur = (kleurChar == 'r' ? rood : (kleurChar == 'g' ? groen : blauw));
  int vulling = (vullingChar == 'l' ? 0 : (vullingChar == 'h' ? 100 : 255));
  String figuur = (figuurChar == 'r' ? "rechthoek" : (figuurChar == 'e' ? "ellipse" : "driehoek"));

  final float xGridOffset = xPositie * (width / xVelden);
  final float yGridOffset = yPositie * (hoogteSpeelveld / yVelden);

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

    strokeWeight(2);
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

    stroke(wit, 150);
  }
}


// Functie voor in draw() om continu de achtergrond van de kaarten te kleuren.
void kleurAchtergrondKaarten() {  
  for (int x = 0; x < xVelden; x++) {
    for (int y = 0; y < yVelden; y++) {
      fill(speelVeldKleur[x][y]);
      rect((width / xVelden) * x, (hoogteSpeelveld / yVelden) * y, width / xVelden, hoogteSpeelveld / yVelden);
    }
  }
}




// Maak de stapel kaarten adhv. het aantal geconfigureerde variaties.
void maakKaartenStapel(int aantalVariaties) {
  String[] aantal = {"1", "2", "3"};
  String[] kleur = {"r", "g", "b"}; // rood, groen, blauw
  String[] figuur = {"d", "r", "e"}; // driehoek, rechthoek, ellipse
  String[] vulling = {"l", "h", "v"}; // leeg, half, vol

  if (kaartenInSpel.size() > 0) {
   kaartenInSpel = new ArrayList<String>(); 
  }

  if (aantalVariaties == 3) {
    for (int a = 0; a < aantal.length; a++) {
      for (int f = 0; f < figuur.length; f++) {
        for (int k = 0; k < kleur.length; k++) {
          kaartenInSpel.add(aantal[a] + figuur[f] + kleur[k] + "0"); // "0" als default waarde zodat verifySet() goed uitgevoerd wordt
        }
      }
    }
  }
  
  if (aantalVariaties == 4) {
    for (int a = 0; a < aantal.length; a++) {
      for (int f = 0; f < figuur.length; f++) {
        for (int k = 0; k < kleur.length; k++) {
          for (int v = 0; v < vulling.length; v++) {
            kaartenInSpel.add(aantal[a] + figuur[f] + kleur[k] + vulling[v]);
          }
        }
      }
    }
  }

  // Console logging.
  println("Kaartenstapel: " + kaartenInSpel);
  println("Totaal aantal kaarten: " + kaartenInSpel.size());
}