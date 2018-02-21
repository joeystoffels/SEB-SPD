// Muisklik functie om kaarten te kunnen selecteren.
// Deze functie triggert het checken op een set na het selecteren van 3 kaarten.
void mousePressed() {  
  
  if (startSchermActive) {    
    // Click Subset - 3 variations button
    if ((mouseX > 150 && mouseX < 450) && 
        mouseY > 350 && mouseY < 375) {
      aantalVariaties = 3;
      //xVelden = 3;
      startSchermActive = false;
      setupGame();   
    }
    
    // Click Set - 4 variations button
    if ((mouseX > 150 && mouseX < 450) && 
        mouseY > 390 && mouseY < 415) {
      aantalVariaties = 4;
      startSchermActive = false;
      setupGame();   
    }      
     
    // Click clear highscores button 
    if ((mouseX > 150 && mouseX < 450) && 
        mouseY > 450 && mouseY < 475) {
      clearHighscores();
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
      restart();
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
      restart();
    } 
    
    return;
  }

  String kaart = speelVeld[xVeld][yVeld]; 

  if (kaart == defaultKaart) {
    return;
  }

  if (selectedKaarten.contains(kaart)) {
    speelVeldKleur[xVeld][yVeld] = zwart;
    selectedKaarten.remove(kaart);
  } else {  
    if (!selectedKaarten.contains(kaart) && selectedKaarten.size() < 3) {
      selectedKaarten.add(speelVeld[xVeld][yVeld]);
      speelVeldKleur[xVeld][yVeld] = color(wit, 125);
      if (selectedKaarten.size() == 3) { 
        checkForSet();
      }
    }
  }
}