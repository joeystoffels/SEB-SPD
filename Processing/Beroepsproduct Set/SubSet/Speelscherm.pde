void toonSpeelscherm() {
  toonAchtergrondKaarten();    
  tekenKaartFiguren();  
  tekenScorebord(); 
  updateTijd();
  checkEindeSpel();
}

// Functie voor in draw() om continu de achtergrond van de kaarten te kleuren.
void toonAchtergrondKaarten() {  
  for (int xPos = 0; xPos < xVelden; xPos++) {
    for (int yPos = 0; yPos < YVELDEN; yPos++) {
      strokeWeight(3);
      stroke(speelkaartBorderKleur[xPos][yPos]);
      fill(speelVeldKleur[xPos][yPos], 175);
      rect(KAARTBREEDTE * xPos + 10, (SPEELVELDHOOGTE / YVELDEN) * yPos + 10, KAARTBREEDTE - 20, SPEELVELDHOOGTE / YVELDEN - 20, 25);
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