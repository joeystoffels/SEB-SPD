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

  String figuur = (kaart.charAt(1) == 'r' ? "rechthoek" : (kaart.charAt(1) == 'e' ? "ellipse" : "driehoek"));
  color kleur = (kaart.charAt(2) == 'r' ? rood : (kaart.charAt(2) == 'g' ? groen : blauw));
  int vulling = (kaart.charAt(3) == 'l' ? 0 : (kaart.charAt(3) == 'h' ? 100 : 255));  

  final float xGridOffset = xPositie * (width / xVelden);
  final float yGridOffset = yPositie * (hoogteSpeelveld / yVelden);

  float[][] config = (figuur == "rechthoek" ? rechthoekConfig : (figuur == "ellipse" ? ellipseConfig : driehoekConfig));

  final int forLoopHelperValue = aantal - (aantal == 3 ? 0 : 1);

  for (int y = forLoopHelperValue; y < aantal + forLoopHelperValue; y++) { 
    float yHoogteFactorEersteFiguur = config[y][0];
    float yHoogteFactorTweedeFiguur = config[y][1];
    float yHoogteFactorDerdeFiguur = config[y][2];    

    strokeWeight(2);
    stroke(kleur);
    fill(kleur, vulling);

    if (figuur == "driehoek") {
      triangle((kleinGridBreedte * 2.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorEersteFiguur) + yGridOffset, 
        (kleinGridBreedte * 4.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorTweedeFiguur) + yGridOffset, 
        (kleinGridBreedte * 6.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorDerdeFiguur) + yGridOffset);
    }
    if (figuur == "rechthoek") {
      rect((kleinGridBreedte * 2.1) + xGridOffset, (kleinGridHoogte * yHoogteFactorEersteFiguur) + yGridOffset, 
        (kleinGridBreedte * 4.0), (kleinGridHoogte * 1.5));
    }
    if (figuur == "ellipse") {
      ellipse((kleinGridBreedte * 4.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorEersteFiguur) + yGridOffset, 
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
  if (kaartenInSpel.size() > 0) {
   kaartenInSpel = new ArrayList<String>(); 
  }

  if (aantalVariaties == 3) {
    for (int a = 0; a < aantalFiguren.length; a++) {
      for (int f = 0; f < figuurType.length; f++) {
        for (int k = 0; k < kleurFiguur.length; k++) {
          kaartenInSpel.add(aantalFiguren[a] + figuurType[f] + kleurFiguur[k] + "0"); // "0" als default waarde zodat verifySet() goed uitgevoerd wordt
        }
      }
    }
  }
  
  if (aantalVariaties == 4) {
    for (int a = 0; a < aantalFiguren.length; a++) {
      for (int f = 0; f < figuurType.length; f++) {
        for (int k = 0; k < kleurFiguur.length; k++) {
          for (int v = 0; v < vullingFiguur.length; v++) {
            kaartenInSpel.add(aantalFiguren[a] + figuurType[f] + kleurFiguur[k] + vullingFiguur[v]);
          }
        }
      }
    }
  }

  // Console logging.
  println("Kaartenstapel: " + kaartenInSpel);
  println("Totaal aantal kaarten: " + kaartenInSpel.size());
}