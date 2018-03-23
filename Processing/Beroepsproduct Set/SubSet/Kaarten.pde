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
    return LEGE_KAART; // return standaard zodat er geen nieuwe figuur gemaakt wordt
  }
};

// Functie om figuur aan te maken.
// Hoogtefactor wijzigt ivm. positie van een, twee of drie figuren ten op zichte van elkaar op 1 kaart.
void maakKaartFiguur(String kaart, int xPositie, int yPositie) {      
  int aantal = Integer.parseInt(str(kaart.charAt(0)));
  String figuur = (kaart.charAt(1) == 'r' ? "rechthoek" : (kaart.charAt(1) == 'e' ? "ellipse" : "driehoek"));
  color kleur = (kaart.charAt(2) == 'r' ? ROOD : (kaart.charAt(2) == 'g' ? GROEN : BLAUW));
  int vulling = (kaart.charAt(3) == 'l' ? 0 : (kaart.charAt(3) == 'h' ? 100 : 255));  

  final float xPosSpeelveld = xPositie * KAART_BREEDTE + 2;
  final float yPosSpeelveld = yPositie * KAART_HOOGTE + 2;

  float[][] kaartConfig;

  switch (figuur) {
  case "rechthoek": 
    kaartConfig = RECHTHOEK_CONFIG; 
    break;
  case "ellipse": 
    kaartConfig = ELLIPSE_CONFIG; 
    break;
  default: 
    kaartConfig = DRIEHOEK_CONFIG; // default ivm compile error in volgende for loop
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
      
      triangle((kaartGridBreedte * 2.0) + xPosSpeelveld, (KAART_GRID_HOOGTE * yPosEersteConfigFactor) + yPosSpeelveld, 
        (kaartGridBreedte * 4.0) + xPosSpeelveld, (KAART_GRID_HOOGTE * yPosTweedeConfigFactor) + yPosSpeelveld, 
        (kaartGridBreedte * 6.0) + xPosSpeelveld, (KAART_GRID_HOOGTE * yPosDerdeConfigFactor) + yPosSpeelveld);
    }
    
    if (figuur == "rechthoek") {
      rect((kaartGridBreedte * 2.1) + xPosSpeelveld, (KAART_GRID_HOOGTE * yPosEersteConfigFactor) + yPosSpeelveld, 
        (kaartGridBreedte * 4.0), (KAART_GRID_HOOGTE * 1.5));
    }
    
    if (figuur == "ellipse") {
      ellipse((kaartGridBreedte * 4.0) + xPosSpeelveld, (KAART_GRID_HOOGTE * yPosEersteConfigFactor) + yPosSpeelveld, 
        (kaartGridBreedte * 4.0), (KAART_GRID_HOOGTE * 1.5));
    }    
  }
}



// Maak de stapel kaarten adhv. het aantal geconfigureerde variaties.
void maakKaartenStapel() {  
    for (int a = 0; a < AANTAL_FIGUREN.length; a++) {
      for (int f = 0; f < FIGUUR_TYPE.length; f++) {
        for (int k = 0; k < KLEUR_FIGUUR.length; k++) {     
          if (aantalVariaties == 4) {
            for (int v = 0; v < VULLING_FIGUUR.length; v++) {
              kaartenInSpel = append(kaartenInSpel, (AANTAL_FIGUREN[a] + FIGUUR_TYPE[f] + KLEUR_FIGUUR[k] + VULLING_FIGUUR[v]));
            }
          } else {
            kaartenInSpel = append(kaartenInSpel, AANTAL_FIGUREN[a] + FIGUUR_TYPE[f] + KLEUR_FIGUUR[k] + "0"); // "0" als default waarde zodat verifySet() goed uitgevoerd wordt
          }
        }
      }
    }
  println("Kaartenstapel: " + kaartenInSpel);
  println("Totaal aantal kaarten: " + kaartenInSpel.length);
}