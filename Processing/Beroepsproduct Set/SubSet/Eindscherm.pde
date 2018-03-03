// Functie om het einde van het spel te bepalen en dan het eindscherm te tonen.
void eindeSpel() {    
  
  
  if(!spelAfgelopen) {
    for (int x = 0 ; x < xVelden ; x++) {
      for (int y = 0 ; y < yVelden ; y++) {
        if (speelVeld[x][y] != standaardKaart){
          aantalKaartenOpSpeelveld++;
        }
      }
    }
  }
  
  if (aantalSetsSpeelveld == 0 && ((voegXVeldToe == true || kaartenInSpel.size() <= 0) || aantalKaartenOpSpeelveld == 0)) {    
    if (tijd == 0.0) {
      tijd = millis() / 1000.0;
    }
    
    println("EINDE SPEL");    
    spelAfgelopen = true;
    
    maakHighscoreLijst();
    
    if (spelAfgelopen && !scoreOpgeslagen) {
      text("Voer naam in: " + naam, 0 + (width * 0.25), height / 1.25);
    } else if (spelAfgelopen && scoreOpgeslagen) {
      text("Score opgeslagen!", 0 + (width * 0.25), height / 1.25);      
      //TODO add positie op highscore lijst?      
    }       
    
    fill(groen, 175);
    rect((width / 7), ((height - hoogteScorebord) / 9), (width / 7) * 5, ((height - hoogteScorebord) / 9));
    
    fill(zwart);    
    textFont(verdanaBold(hoogteScorebord / 4));    
    textAlign(CENTER);
    fill(wit, 225);
    text("EINDE", (width / 2), (height - hoogteScorebord) / 9 + ((height - hoogteScorebord) / 9) / 1.5);    
    textAlign(LEFT);
    
    fill(wit, 200);
    textFont(verdanaBold(hoogteScorebord / 7)); 
    text("Score: ", 0 + (width * 0.25), height - (hoogteScorebord / 9) * 7); 
    text("Tijd: ", 0 + (width * 0.25), height - (hoogteScorebord / 9) * 5);  
  
    text(nf(scoreSpelerEen), 0 + (width * 0.35), height - (hoogteScorebord / 9) * 7); 
    text(String.format("%.2f", tijd), 0 + (width * 0.35), height - (hoogteScorebord / 9) * 5);  
    
    fill(zwart);
    rect((width / 8) * 4, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));  
    rect((width / 8) * 6, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));  
    
    textFont(verdanaBold(12));
    fill(wit);
    text("Opnieuw", (width / 8) * 4.1, height - (hoogteScorebord / 5) * 3.25);  
    text("Beginscherm", (width / 8) * 6.1, height - (hoogteScorebord / 5) * 3.25);
  }
}