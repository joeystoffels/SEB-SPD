void toonSpeelscherm() {
  toonAchtergrondKaarten(speelkaartBorderKleur, speelVeldKleur);    
  tekenKaartFiguren();  
  tekenScorebord(); 
  updateTijd();
  checkEindeSpel();
}

// Functie voor in draw() om continu de achtergrond van de kaarten te kleuren.
void toonAchtergrondKaarten(int[][] speelkaartBorderKleur, int[][] speelVeldKleur) {  
  final int KAART_OFFSET_X_POS = 10;
  final int KAART_OFFSET_Y_POS = -20;
  for (int xPos = 0; xPos < xVelden; xPos++) {
    for (int yPos = 0; yPos < YVELDEN; yPos++) {
      strokeWeight(3);
      stroke(speelkaartBorderKleur[xPos][yPos]);
      fill(speelVeldKleur[xPos][yPos], 175);
      rect(KAART_BREEDTE * xPos + KAART_OFFSET_X_POS, (SPEELVELD_HOOGTE / YVELDEN) * yPos + KAART_OFFSET_X_POS, KAART_BREEDTE + KAART_OFFSET_Y_POS, SPEELVELD_HOOGTE / YVELDEN + KAART_OFFSET_Y_POS, RECT_HOEK_RADIUS);
    }
  }
}

// Functie om het speelveld te vullen met kaarten.
void tekenKaartFiguren() {
  for (int x=0; x < xVelden; x++) {
    for (int y=0; y < YVELDEN; y++) {
      maakKaartFiguur(speelVeld[x][y], x, y);
    }
  }
}