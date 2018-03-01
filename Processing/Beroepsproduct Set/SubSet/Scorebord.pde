// Aanmaken van het scorebord, de hoogte hiervan staat vast op 15% van de hoogte en de positie is onder het speelveld.
// TODO refactoren
void maakScorebord() {
  // Achtergrond verversen
  fill(zwart);
  rect(0, height, width, - hoogteScorebord);

  // Score weergeven, dubbele text velden voor betere allignment.
  fill(wit, 225);
  textFont(fontVerdanaBoldGroot); 
  
  text("Score: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 7); 
  text("Tijd: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 5);  
  text("Kaarten over: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 3);
  text("Aantal sets: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 1);

  text(nf(scoreSpelerEen), 0 + (width * 0.3), height - (hoogteScorebord / 9) * 7); 
  text(""+int(tijd), 0 + (width * 0.3), height - (hoogteScorebord / 9) * 5);  
  text(kaartenInSpel.size(), 0 + (width * 0.3), height - (hoogteScorebord / 9) * 3);
  text(aantalSetsSpeelveld, 0 + (width * 0.3), height - (hoogteScorebord / 9) * 1);
  
  // Knoppen toevoegen.
  // TODO text centreren in knop(?)
  fill(zwart);
  rect((width / 8) * 4, height - (hoogteScorebord / 5), width / 6, - (hoogteScorebord / 5));  
  rect((width / 8) * 4, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));  
  rect((width / 8) * 6, height - (hoogteScorebord / 5), width / 6, - (hoogteScorebord / 5));  
  rect((width / 8) * 6, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));
  
  textFont(fontVerdanaBoldKlein); 
  fill(wit);
  text("Hint", (width / 8) * 4.1, height - (hoogteScorebord / 5) * 1.25);
  text("Opnieuw", (width / 8) * 4.1, height - (hoogteScorebord / 5) * 3.25);
  text("Beginscherm", (width / 8) * 6.1, height - (hoogteScorebord / 5) * 3.25);
  text("Voeg " + yVelden + " toe", (width / 8) * 6.1, height - (hoogteScorebord / 5) * 1.25);
}