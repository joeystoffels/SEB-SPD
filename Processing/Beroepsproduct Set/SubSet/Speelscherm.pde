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
    for (int yPos = 0; yPos < yVelden; yPos++) {
      strokeWeight(3);
      stroke(speelkaartBorderKleur[xPos][yPos]);
      fill(speelVeldKleur[xPos][yPos], 175);
      rect(kaartBreedte * xPos + 10, (speelveldHoogte / yVelden) * yPos + 10, kaartBreedte - 20, speelveldHoogte / yVelden - 20, 25);
    }
  }
}

// Functie om het speelveld te vullen met kaarten.
void tekenKaartFiguren() {
  for (int x=0; x < xVelden; x++) {
    for (int y=0; y < yVelden; y++) {
      maakKaartFiguur(speelVeld[x][y], x, y);
    }
  }
}