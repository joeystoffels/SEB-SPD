// Functie om het einde van het spel te bepalen en dan het eindscherm te tonen.
void checkEindeSpel() {       
  if (!spelAfgelopen) {
    for (int xPos = 0; xPos < xVelden; xPos++) {
      for (int yPos = 0; yPos < yVelden; yPos++) {
        if (speelVeld[xPos][yPos] != legeKaart) {
          aantalKaartenOpSpeelveld++;
        }
      }
    }
  }

  if (aantalSetsSpeelveld == 0 && ((kaartenToegevoegd == true || kaartenInSpel.length <= 0) || aantalKaartenOpSpeelveld == 0)) {    
    spelActief = false;
    spelAfgelopen = true;     
    toonEindscherm();
  }
}

void toonEindscherm() {      
  toonHighscoreLijst();
  tekenNaamInvoer();       
  tekenEindeTitel();  
  
  fill(zwart, 150);
  rect(width * 0.025, height - scorebordHoogte, width * 0.38, scorebordHoogte / 1.6, 25);

  tekenKnopScorebord(6, 3); 
  tekenKnopScorebord(6, 1);
  tekenTextInKnopScorebord("Opnieuw", 6.1, 3.25);
  tekenTextInKnopScorebord("Startscherm", 6.1, 1.25);  

  tekenSpelInfoTextTitel("Tijd: ", 5);
  tekenSpelInfoTextTitel("Score: ", 7);
  tekenSpelInfoTextWaarde(String.format("%.2f", tijd), 5);
  tekenSpelInfoTextWaarde(nf(scoreSpelerEen), 7);
}

void tekenNaamInvoer() {
  if (spelAfgelopen && !scoreOpgeslagen) {
    text("Voer naam in: " + naam, 0 + (width * 0.25), schermHoogte * 0.725);
  } else if (spelAfgelopen && scoreOpgeslagen) {
    text("Je bent geeindigd op de " + plaatsOpHighscoreLijst + "e plaats!", 0 + (width * 0.25), schermHoogte * 0.725);
  }
}

void tekenEindeTitel() {
  fill(zwart, 150);
  rect((width / 7), (speelveldHoogte / 9), (width / 7) * 5, (speelveldHoogte / 9), 25);

  fill(wit);
  textAlign(CENTER);
  textFont(verdanaBold(scorebordHoogte / 3));   
  text("EINDE", (width / 2), speelveldHoogte / 9 + (speelveldHoogte / 9) / 1.5);    
  textAlign(LEFT);
}