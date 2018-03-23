// Functie om een random kaart te kiezen uit de kaartenInSpel array en deze 
// vervolgens te verwijderen uit de lijst, de kaartenInSpel array stelt dus 
// de huidige stapel speelkaarten voor.
String pakKaart() { 
  if (!(kaartenInSpel.length <= 0)) { 
    int random = int(random(0, kaartenInSpel.length));
    String kaart = kaartenInSpel[random];
    kaartenInSpel = removeFromArray(kaartenInSpel, random);  
    return kaart;
  } else {
    return LEGEKAART; // return standaard zodat er geen nieuwe figuur gemaakt wordt
  }
};

// Functie om figuur aan te maken.
// Hoogtefactor wijzigt ivm. positie van een, twee of drie figuren ten op zichte van elkaar op 1 kaart.
void maakKaartFiguur(String kaart, int xPositie, int yPositie) {    
  
  int aantal = Integer.parseInt(str(kaart.charAt(0)));
  String figuur = (kaart.charAt(1) == 'r' ? "rechthoek" : (kaart.charAt(1) == 'e' ? "ellipse" : "driehoek"));
  color kleur = (kaart.charAt(2) == 'r' ? ROOD : (kaart.charAt(2) == 'g' ? GROEN : BLAUW));
  int vulling = (kaart.charAt(3) == 'l' ? 0 : (kaart.charAt(3) == 'h' ? 100 : 255));  

  final float xPosSpeelveld = xPositie * KAARTBREEDTE + 2;
  final float yPosSpeelveld = yPositie * KAARTHOOGTE + 2;

  float[][] kaartConfig;

  switch (figuur) {
  case "rechthoek": 
    kaartConfig = RECHTHOEKCONFIG; 
    break;
  case "ellipse": 
    kaartConfig = ELLIPSECONFIG; 
    break;
  default: 
    kaartConfig = DRIEHOEKCONFIG; // default ivm compile error in volgende for loop
  }
  
  strokeWeight(3);
  stroke(kleur);
  fill(kleur, vulling);
    
  final int figuurConfigArrayStartIndex = aantal - (aantal == 3 ? 0 : 1);
    
  for (int y = figuurConfigArrayStartIndex; y < aantal + figuurConfigArrayStartIndex; y++) { 
    float yPosEersteConfigFactor = kaartConfig[y][0];
    
    if (figuur == "driehoek") {
      float yPosTweedeConfigFactor = kaartConfig[y][1];
      float yPosDerdeConfigFactor = kaartConfig[y][2];    
      
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
}



// Maak de stapel kaarten adhv. het aantal geconfigureerde variaties.
void maakKaartenStapel() {
  
    for (int a = 0; a < AANTALFIGUREN.length; a++) {
      for (int f = 0; f < FIGUURTYPE.length; f++) {
        for (int k = 0; k < KLEURFIGUUR.length; k++) {     
          if (aantalVariaties == 4) {
            for (int v = 0; v < VULLINGFIGUUR.length; v++) {
              kaartenInSpel = append(kaartenInSpel, (AANTALFIGUREN[a] + FIGUURTYPE[f] + KLEURFIGUUR[k] + VULLINGFIGUUR[v]));
            }
          } else {
            kaartenInSpel = append(kaartenInSpel, AANTALFIGUREN[a] + FIGUURTYPE[f] + KLEURFIGUUR[k] + "0"); // "0" als default waarde zodat verifySet() goed uitgevoerd wordt
          }
        }
      }
    }
  println("Kaartenstapel: " + kaartenInSpel);
  println("Totaal aantal kaarten: " + kaartenInSpel.length);
}