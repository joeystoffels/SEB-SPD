// Aanmaken van het scorebord, de hoogte hiervan staat vast op 15% van de hoogte en de positie is onder het speelveld.
void tekenScorebord() {  
  tekenInfoTextScorebord();  
  tekenKnoppenScorebord();
}

// Info teksten toevoegen.
void tekenInfoTextScorebord() { 
  stroke(wit);
  strokeWeight(2);
  fill(zwart, 150);
  rect(width * 0.025, height - scorebordHoogte + 3, width * 0.38, scorebordHoogte - 6, 25);
  
  tekenSpelInfoTextWaarde(""+aantalSetsSpeelveld, 1);
  tekenSpelInfoTextWaarde(""+kaartenInSpel.length, 3);
  tekenSpelInfoTextWaarde(""+int(tijd), 5);
  tekenSpelInfoTextWaarde(nf(scoreSpelerEen), 7);

  tekenSpelInfoTextTitel("Aantal sets: ", 1);
  tekenSpelInfoTextTitel("Kaarten over: ", 3);
  tekenSpelInfoTextTitel("Tijd: ", 5);
  tekenSpelInfoTextTitel("Score: ", 7);
}

// Knoppen toevoegen.
void tekenKnoppenScorebord() {    
  tekenKnopScorebord(4, 1);
  tekenKnopScorebord(4, 3);  
  tekenKnopScorebord(6, 1);  
  tekenKnopScorebord(6, 3);

  tekenTextInKnopScorebord("Hint", 4.1, 3.25);
  tekenTextInKnopScorebord("Voeg " + yVelden + " toe", 4.1, 1.25);
  tekenTextInKnopScorebord("Opnieuw", 6.1, 3.25);
  tekenTextInKnopScorebord("Startscherm", 6.1, 1.25);
}

void tekenKnopScorebord(float gridPosBreedte, float gridPosHoogte) {
  fill(zwart, 175);
  rect((width / 8) * gridPosBreedte, schermHoogte - (scorebordHoogte / 5) * gridPosHoogte, 100, - (scorebordHoogte / 5), 25);
}

void tekenTextInKnopScorebord(String text, float gridPosBreedte, float gridPosHoogte) {
  fill(wit);
  textFont(verdanaBold(12)); 
  text(text, (width / 8) * gridPosBreedte, schermHoogte - (scorebordHoogte / 5) * gridPosHoogte);
}

void tekenSpelInfoTextWaarde(String text, float gridPosHoogte) {
  fill(wit);
  textFont(verdanaBold(scorebordHoogte / 7)); 
  text(text, 0 + (width * 0.3), schermHoogte - (scorebordHoogte / 9) * gridPosHoogte);
}

void tekenSpelInfoTextTitel(String text, float gridPosHoogte) {
  fill(wit);
  textFont(verdanaBold(scorebordHoogte / 7)); 
  text(text, 0 + (width * 0.05), schermHoogte - (scorebordHoogte / 9) * gridPosHoogte);
}