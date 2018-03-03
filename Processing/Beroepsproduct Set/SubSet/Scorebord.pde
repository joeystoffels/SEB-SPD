// Aanmaken van het scorebord, de hoogte hiervan staat vast op 15% van de hoogte en de positie is onder het speelveld.
// TODO refactoren
void maakScorebord() {  
  setAchtergrondScorebord();  
  tekenInfoTextScorebord();  
  tekenKnoppenScorebord();
}


// Achtergrond verversen van enkel het scorebord
void setAchtergrondScorebord() {
  fill(zwart);
  rect(0, height, width, - hoogteScorebord);
}


// Info teksten toevoegen.
void tekenInfoTextScorebord() {
  tekenSpelInfoTextWaarde(""+aantalSetsSpeelveld, 1);
  tekenSpelInfoTextWaarde(""+kaartenInSpel.size(), 3);
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
  
  tekenTextInKnopScorebord("Hint", 4.1, 1.25);
  tekenTextInKnopScorebord("Opnieuw", 4.1, 3.25);
  tekenTextInKnopScorebord("Voeg " + yVelden + " toe", 6.1, 1.25);
  tekenTextInKnopScorebord("Beginscherm", 6.1, 3.25);
}


void tekenKnopScorebord(float gridPosBreedte, float gridPosHoogte) {
  fill(zwart);
  rect((width / 8) * gridPosBreedte, height - (hoogteScorebord / 5) * gridPosHoogte, width / 6, - (hoogteScorebord / 5));  
}


void tekenTextInKnopScorebord(String text, float gridPosBreedte, float gridPosHoogte) {
  fill(wit);
  textFont(verdanaBold(hoogteScorebord / 8)); 
  text(text, (width / 8) * gridPosBreedte, height - (hoogteScorebord / 5) * gridPosHoogte);
}


void tekenSpelInfoTextWaarde(String text, float gridPosHoogte) {
  fill(wit, 225);
  textFont(verdanaBold(hoogteScorebord / 7)); 
  text(text,   0 + (width * 0.3), height - (hoogteScorebord / 9) * gridPosHoogte); 
}


void tekenSpelInfoTextTitel(String text, float gridPosHoogte) {
  fill(wit, 225);
  textFont(verdanaBold(hoogteScorebord / 7)); 
  text(text, 0 + (width * 0.05), height - (hoogteScorebord / 9) * gridPosHoogte); 
}