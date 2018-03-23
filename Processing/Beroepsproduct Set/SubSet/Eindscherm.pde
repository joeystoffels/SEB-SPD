// Functie om het einde van het spel te bepalen en dan het eindscherm te tonen.
void checkEindeSpel() {       
  if (!spelAfgelopen) {
    for (int xPos = 0; xPos < xVelden; xPos++) {
      for (int yPos = 0; yPos < YVELDEN; yPos++) {
        if (speelVeld[xPos][yPos] != LEGEKAART) {
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
  
  fill(ZWART, 150);
  rect(width * 0.025, height - SCOREBORDHOOGTE, width * 0.38, SCOREBORDHOOGTE / 1.6, 25);

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
    text("Voer naam in: " + naam, 0 + (width * 0.25), SCHERMHOOGTE * 0.725);
  } else if (spelAfgelopen && scoreOpgeslagen) {
    text("Je bent geeindigd op de " + plaatsOpHighscoreLijst + "e plaats!", 0 + (width * 0.25), SCHERMHOOGTE * 0.725);
  }
}

void tekenEindeTitel() {
  fill(ZWART, 150);
  
  rect(width /7, (SPEELVELDHOOGTE / 9), (width / 7) * 5, (SPEELVELDHOOGTE / 9), 25);

  fill(WIT);
  textAlign(CENTER);
  textFont(verdanaBold(SCOREBORDHOOGTE / 3));   
  text("EINDE", (width / 2), SPEELVELDHOOGTE / 9 + (SPEELVELDHOOGTE / 9) / 1.5);    
  textAlign(LEFT);
}