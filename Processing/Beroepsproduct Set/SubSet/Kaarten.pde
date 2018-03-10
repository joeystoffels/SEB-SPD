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
    return legeKaart; // return standaard zodat er geen nieuwe figuur gemaakt wordt
  }
};

// Functie om figuur aan te maken.
// Hoogtefactor wijzigt ivm. positie van een, twee of drie figuren ten op zichte van elkaar op 1 kaart.
void maakKaartFiguur(String kaart, int xPositie, int yPositie) {    

  int aantal = Integer.parseInt(str(kaart.charAt(0)));
  String figuur = (kaart.charAt(1) == 'r' ? "rechthoek" : (kaart.charAt(1) == 'e' ? "ellipse" : "driehoek"));
  color kleur = (kaart.charAt(2) == 'r' ? rood : (kaart.charAt(2) == 'g' ? groen : blauw));
  int vulling = (kaart.charAt(3) == 'l' ? 0 : (kaart.charAt(3) == 'h' ? 100 : 255));  

  final float xPosSpeelveld = xPositie * kaartBreedte;
  final float yPosSpeelveld = yPositie * kaartHoogte;

  float[][] kaartConfig;

  switch (figuur) {
  case "rechthoek": 
    kaartConfig = rechthoekConfig; 
    break;
  case "ellipse": 
    kaartConfig = ellipseConfig; 
    break;
  default: 
    kaartConfig = driehoekConfig; // default ivm compile error in volgende for loop
  }

  final int forLoopHelperValue = aantal - (aantal == 3 ? 0 : 1);

  for (int y = forLoopHelperValue; y < aantal + forLoopHelperValue; y++) { 
    float yPosEersteConfigFactor = kaartConfig[y][0];
    float yPosTweedeConfigFactor = kaartConfig[y][1];
    float yPosDerdeConfigFactor = kaartConfig[y][2];    

    strokeWeight(2);
    stroke(kleur);
    fill(kleur, vulling);

    if (figuur == "driehoek") {
      triangle((kaartGridBreedte * 2.0) + xPosSpeelveld, (kaartGridHoogte * yPosEersteConfigFactor) + yPosSpeelveld, 
        (kaartGridBreedte * 4.0) + xPosSpeelveld, (kaartGridHoogte * yPosTweedeConfigFactor) + yPosSpeelveld, 
        (kaartGridBreedte * 6.0) + xPosSpeelveld, (kaartGridHoogte * yPosDerdeConfigFactor) + yPosSpeelveld);
    }
    if (figuur == "rechthoek") {
      rect((kaartGridBreedte * 2.1) + xPosSpeelveld, (kaartGridHoogte * yPosEersteConfigFactor) + yPosSpeelveld, 
        (kaartGridBreedte * 4.0), (kaartGridHoogte * 1.5));
    }
    if (figuur == "ellipse") {
      ellipse((kaartGridBreedte * 4.0) + xPosSpeelveld, (kaartGridHoogte * yPosEersteConfigFactor) + yPosSpeelveld, 
        (kaartGridBreedte * 4.0), (kaartGridHoogte * 1.5));
    }

    
  }
  stroke(wit);
}

// Functie voor in draw() om continu de achtergrond van de kaarten te kleuren.
void kleurAchtergrondKaarten() {  
  for (int xPos = 0; xPos < xVelden; xPos++) {
    for (int yPos = 0; yPos < yVelden; yPos++) {
      fill(speelVeldKleur[xPos][yPos], 200);
      rect(kaartBreedte * xPos, (speelveldHoogte / yVelden) * yPos, kaartBreedte, speelveldHoogte / yVelden, 25);
    }
  }
}

// Maak de stapel kaarten adhv. het aantal geconfigureerde variaties.
void maakKaartenStapel(int aantalVariaties) {
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
  println("Kaartenstapel: " + kaartenInSpel);
  println("Totaal aantal kaarten: " + kaartenInSpel.size());
}