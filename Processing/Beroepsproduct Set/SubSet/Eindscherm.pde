// Functie om het einde van het spel te bepalen en dan het eindscherm te tonen.
void checkEindeSpel() {       
  if(!spelAfgelopen) {
    for (int xPos = 0 ; xPos < xVelden ; xPos++) {
      for (int yPos = 0 ; yPos < yVelden ; yPos++) {
        if (speelVeld[xPos][yPos] != legeKaart){
          aantalKaartenOpSpeelveld++;
        }
      }
    }
  }
  
  if (aantalSetsSpeelveld == 0 && ((kaartenToegevoegd == true || kaartenInSpel.size() <= 0) || aantalKaartenOpSpeelveld == 0)) {    
    spelActief = false;
    spelAfgelopen = true;     
    tekenEindscherm();
  }
}


void tekenEindscherm() {      
  maakHighscoreLijst();
  tekenNaamInvoer();     
  tekenEindeTitel();  
  
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
    text("Voer naam in: " + naam, 0 + (width * 0.25), height * 0.7);
  } else if (spelAfgelopen && scoreOpgeslagen) {
    text("Je bent geeindigd op de " + plaatsOpHighscoreLijst + "e plaats!", 0 + (width * 0.25), height * 0.7);      
  }  
}


void tekenEindeTitel() {
  fill(groen, 175);
  rect((width / 7), (speelveldHoogte / 9), (width / 7) * 5, (speelveldHoogte / 9));
  
  fill(wit, 225);
  textAlign(CENTER);
  textFont(verdanaBold(scorebordHoogte / 4));   
  text("EINDE", (width / 2), speelveldHoogte / 9 + (speelveldHoogte / 9) / 1.5);    
  textAlign(LEFT);
}