void eindeSpel() {  
  
  int aantalKaartenOpSpeelveld = 0;
  
  if(!spelAfgelopen) {
    for (int x = 0 ; x < xVelden ; x++) {
      for (int y = 0 ; y < yVelden ; y++) {
        if (speelVeld[x][y] != defaultKaart){
          aantalKaartenOpSpeelveld++;
        }
      }
    }
  }
  
  

  
  if (aantalSetsSpeelveld == 0 && ((voegXVeldToe == true || kaartenArrayList.size() <= 0) || aantalKaartenOpSpeelveld == 0)) {
    
    if (tijd == 0.0) {
      tijd = millis() / 1000.0;
    }
    
    println("EINDE SPEL");
    
    spelAfgelopen = true;
    
    if (spelAfgelopen && !scoreSaved) {
      text("Naam: " + naam, 0 + (width * 0.25), height / 1.5);
    } else if (spelAfgelopen && scoreSaved) {
      text("Score opgeslagen!", 0 + (width * 0.25), height / 1.5);
      
      
      
    }
    
    
    
    
    //TODO add positie op highscore lijst
    
    
    fill(groen, 175);
    rect((width / 7) * 1, ((height - hoogteScorebord) / 7) * 2, (width / 7) * 5, ((height - hoogteScorebord) / 7) * 3);
    
    fill(zwart);    
    textFont(createFont("Verdana Bold", hoogteScorebord));
    
    textAlign(CENTER);
    fill(wit, 225);
    text("EINDE", (width / 2), (height - hoogteScorebord / 2) / 1.9);    
    
    textAlign(LEFT);
    fill(wit, 200);
    textFont(fontVerdanaBoldGroot); 

    text("Score: ", 0 + (width * 0.25), height - (hoogteScorebord / 9) * 7); 
    text("Tijd: ", 0 + (width * 0.25), height - (hoogteScorebord / 9) * 5);  
  
    text(nf(scoreSpelerEen), 0 + (width * 0.35), height - (hoogteScorebord / 9) * 7); 
    text(""+tijd, 0 + (width * 0.35), height - (hoogteScorebord / 9) * 5);  
    
    fill(zwart);
    rect((width / 8) * 4, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));  
    rect((width / 8) * 6, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));  
    
    textFont(createFont("Verdana Bold", 12));
    fill(wit);
    text("Restart", (width / 8) * 4.1, height - (hoogteScorebord / 5) * 3.25);  
    text("Beginscherm", (width / 8) * 6.1, height - (hoogteScorebord / 5) * 3.25);
  }
}

void keyPressed() { 
  if (spelAfgelopen){
    if (key==BACKSPACE) { 
      if (naam.length() > 0) {
        setNaam(naam.substring(0, naam.length() -1));
      } else {
        return; // Als naam al 0 lengte heeft dan niks doen.
      }
    } else if (key==ENTER) {
      if (!scoreSaved) {
        saveHighscore();
        scoreSaved = true;
      }
    } else if (key==SHIFT){
      return;
    } else {
      setNaam(naam + key);
    }
  } else {
    return; // Niks doen wanneer het spel nog niet klaar is
  }
}