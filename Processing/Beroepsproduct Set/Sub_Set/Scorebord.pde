// Aanmaken van het scorebord, de hoogte hiervan staat vast op 15% van de hoogte.
// TODO refactoren
void maakScorebord() {
  // Achtergrond verversen
  fill(zwart);
  rect(0, height, width, - hoogteScorebord);

  // Score weergeven, dubbele text velden voor betere allignment.
  fill(wit, 200);
  textFont(fontVerdanaBold); 
  text("Score: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 7); 
  text("Tijd: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 5);  
  text("Kaarten over: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 3);
  text("Aantal sets: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 1);

  text(nf(scoreSpelerEen), 0 + (width * 0.3), height - (hoogteScorebord / 9) * 7); 
  text(millis()/1000, 0 + (width * 0.3), height - (hoogteScorebord / 9) * 5);  
  text(kaartenArrayList.size(), 0 + (width * 0.3), height - (hoogteScorebord / 9) * 3);
  text(aantalSetsSpeelveld, 0 + (width * 0.3), height - (hoogteScorebord / 9) * 1);
  
  // Knoppen toevoegen.
  // TODO text centreren in knop
  fill(zwart);
  rect((width / 8) * 4, height - (hoogteScorebord / 5), width / 6, - (hoogteScorebord / 5));  
  rect((width / 8) * 4, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));  
  rect((width / 8) * 6, height - (hoogteScorebord / 5), width / 6, - (hoogteScorebord / 5));  
  rect((width / 8) * 6, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));
  
  fill(wit);
  text("Hint", (width / 8) * 4.475, height - (hoogteScorebord / 5) * 1.25);
  text("Restart", (width / 8) * 4.34, height - (hoogteScorebord / 5) * 3.25);
  text("Voeg " + yVelden + " toe", (width / 8) * 6.225, height - (hoogteScorebord / 5) * 1.25);
  text("Knop", (width / 8) * 6.425, height - (hoogteScorebord / 5) * 3.25);
}


// Functie om de veldlijnen te tekenen.
void tekenVeldLijnen() {    
  stroke(wit, 150);

  for (int x = 1; x < yVelden; x++) {
    line(0, (height - hoogteScorebord)/yVelden * x, width, (height - hoogteScorebord)/yVelden * x);
  }

  for (int y = 1; y < xVelden; y++) {
    line(width/xVelden * y, 0, width/xVelden * y, height - hoogteScorebord);
  }  

  // Laatste lijn van het speelveld, begin van het scorebord.
  line(0, height - hoogteScorebord, width, height - hoogteScorebord);
}