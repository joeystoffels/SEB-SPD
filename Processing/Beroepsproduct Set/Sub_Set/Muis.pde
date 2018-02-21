// Muisklik functie om kaarten te kunnen selecteren.
// Deze functie triggert het checken op een set na het selecteren van 3 kaarten.
void mousePressed() {      
  if (startSchermActive) { // Wanneer startScherm actief is zijn onderstaande knoppen beschikbaar.
    // Click Subset - 3 variations button
    if ((mouseX > 150 && mouseX < 450) && 
        mouseY > 350 && mouseY < 375) {
      aantalVariaties = 3;
      startSchermActive = false;
      setupSpel();   
    }
    
    // Click Set - 4 variations button
    if ((mouseX > 150 && mouseX < 450) && 
        mouseY > 390 && mouseY < 415) {
      aantalVariaties = 4;
      startSchermActive = false;
      setupSpel();   
    }      
     
    // Click clear highscores button 
    if ((mouseX > 150 && mouseX < 450) && 
        mouseY > 450 && mouseY < 475) {
      verwijderHighscores();
    }      
     
    return;
  }
  
  int xVeld = mouseX / (width/xVelden);
  int yVeld = mouseY / ((height - hoogteScorebord)/yVelden);

  //println("CLICKED " + mouseX, mouseY);
  //println(((width / 8) * 4), (width / 6) + (width / 8) * 4);
  //println((height - (hoogteScorebord / 5)), (height - (hoogteScorebord / 5))-(hoogteScorebord / 5));  
  //println(mouseX > ((width / 8) * 4) && mouseX < (width / 6) + ((width / 8) * 4));
  //print(mouseY < (height - (hoogteScorebord / 5)) && mouseY > (height - (hoogteScorebord / 5))-(hoogteScorebord / 5));

  // return indien er buiten het speelveld geklikt is.
  if (mouseY >= height - hoogteScorebord) {
    
    if (mouseX > ((width / 8) * 4) && mouseX < (width / 6) + ((width / 8) * 4) && 
      mouseY < (height - (hoogteScorebord / 5)) && mouseY > (height - (hoogteScorebord / 5))-(hoogteScorebord / 5)){
      fill(wit);  
      rect((width / 8) * 4, height - (hoogteScorebord / 5), width / 6, - (hoogteScorebord / 5));  
      
      geefHint();
    }
    
    
   if (mouseX > ((width / 8) * 4) && mouseX < (width / 6) + ((width / 8) * 4) && 
      mouseY < (height - (hoogteScorebord / 5) * 3) && mouseY > (height - (hoogteScorebord / 5) * 3)-(hoogteScorebord / 5)){
      fill(wit);  
      rect((width / 8) * 4, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));  
      herstart();
    }
   
    if (mouseX > ((width / 8) * 6) && mouseX < (width / 6) + ((width / 8) * 6) && 
      mouseY < (height - (hoogteScorebord / 5)) && mouseY > (height - (hoogteScorebord / 5))-(hoogteScorebord / 5)){
      fill(wit);  
      rect((width / 8) * 6, height - (hoogteScorebord / 5), width / 6, - (hoogteScorebord / 5));  
      
      voegKaartenToe();
    } 
    
    if (mouseX > ((width / 8) * 6) && mouseX < (width / 6) + ((width / 8) * 6) && 
      mouseY < (height - (hoogteScorebord / 5) * 3) && mouseY > (height - (hoogteScorebord / 5) * 3)-(hoogteScorebord / 5)){
      fill(wit);  
      rect((width / 8) * 6, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));      
      
      startSchermActive = true;
      herstart();
    } 
    
    return;
  }

  String kaart = speelVeld[xVeld][yVeld]; 

  if (kaart == standaardKaart) {
    return;
  }

  if (geselecteerdeKaarten.contains(kaart)) {
    speelVeldKleur[xVeld][yVeld] = zwart;
    geselecteerdeKaarten.remove(kaart);
  } else {  
    if (!geselecteerdeKaarten.contains(kaart) && geselecteerdeKaarten.size() < 3) {
      geselecteerdeKaarten.add(speelVeld[xVeld][yVeld]);
      speelVeldKleur[xVeld][yVeld] = color(wit, 125);
      if (geselecteerdeKaarten.size() == 3) { 
        controleerSet();
      }
    }
  }
}