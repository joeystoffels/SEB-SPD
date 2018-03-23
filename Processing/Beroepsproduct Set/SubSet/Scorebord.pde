// Aanmaken van het scorebord, de hoogte hiervan staat vast op 15% van de hoogte en de positie is onder het speelveld.
void tekenScorebord() {  
  tekenAchtergrondInfoScorebord();
  toonInfoScorebord();  
  toonKnoppenScorebord();
}

// Functie om de achtergrond van het info scorebord te tekenen.
void tekenAchtergrondInfoScorebord() {
  final float ACHTERGROND_SCORES_SPEELSCHERM_X_POS = width * 0.025;
  final float ACHTERGROND_SCORES_SPEELSCHERM_Y_POS = SCHERM_HOOGTE - SCOREBORD_HOOGTE + 3;
  final float ACHTERGROND_SCORES_SPEELSCHERM_BREEDTE = width * 0.38;
  final float ACHTERGROND_SCORES_SPEELSCHERM_HOOGTE = SCOREBORD_HOOGTE - 6;

  stroke(WIT);
  strokeWeight(2);
  fill(ZWART, 150);
  rect(ACHTERGROND_SCORES_SPEELSCHERM_X_POS, ACHTERGROND_SCORES_SPEELSCHERM_Y_POS, ACHTERGROND_SCORES_SPEELSCHERM_BREEDTE, ACHTERGROND_SCORES_SPEELSCHERM_HOOGTE, RECT_HOEK_RADIUS);
}

// Info teksten tonen.
void toonInfoScorebord() {     
  tekenSpelInfoText("Aantal sets: ", str(aantalSetsSpeelveld), 1);
  tekenSpelInfoText("Kaarten over: ", str(kaartenInSpel.length), 3);
  tekenSpelInfoText("Tijd: ", str(int(tijd)), 5);
  tekenSpelInfoText("Score: ", nf(scoreSpelerEen), 7);
}

// Knoppen tonen.
void toonKnoppenScorebord() {    
  tekenKnopScorebord("Hint", 4, 3);
  tekenKnopScorebord("Voeg " + YVELDEN + " toe", 4, 1);  
  tekenKnopScorebord("Opnieuw", 6, 3);  
  tekenKnopScorebord("Startscherm", 6, 1);
}

// Functie om de spel info text weer te geven.
void tekenSpelInfoText(String titel, String waarde, float gridPosHoogte) {
  final float TITEL_TEXT_X_POS = width * 0.05;  
  final float WAARDE_TEXT_X_POS = width * 0.3;
  final float TEXT_Y_POS = SCHERM_HOOGTE - (SCOREBORD_HOOGTE / 9) * gridPosHoogte;

  fill(WIT);
  textFont(verdanaBold(SCOREBORD_HOOGTE / 7)); 
  text(titel, TITEL_TEXT_X_POS, TEXT_Y_POS);
  text(waarde, WAARDE_TEXT_X_POS, TEXT_Y_POS);
}

// Functie om een knop op het scorebord te tekenen.
void tekenKnopScorebord(String text, float gridPosBreedte, float gridPosHoogte) {  
  final float KNOP_POS_X = (width / 8) * gridPosBreedte;
  final float KNOP_BREEDTE = 100;
  final float KNOP_HOOGTE = SCHERM_HOOGTE - (SCOREBORD_HOOGTE / 5) * gridPosHoogte;
  final int KNOP_DIKTE = -(SCOREBORD_HOOGTE / 5);

  if (mouseX > KNOP_POS_X && mouseX < KNOP_POS_X + KNOP_BREEDTE &&
    mouseY < KNOP_HOOGTE && mouseY > KNOP_HOOGTE + KNOP_DIKTE) {
    fill(WIT, 50);
  } else {      
    fill(ZWART, 175);
  }

  final float ACHTERGROND_SCORES_SPEELSCHERM_X_POS = (width / 8) * gridPosBreedte;
  final float ACHTERGROND_SCORES_SPEELSCHERM_Y_POS = SCHERM_HOOGTE - (SCOREBORD_HOOGTE / 5) * gridPosHoogte;
  final float ACHTERGROND_SCORES_SPEELSCHERM_BREEDTE = 100;
  final float ACHTERGROND_SCORES_SPEELSCHERM_HOOGTE = -(SCOREBORD_HOOGTE / 5);

  rect(ACHTERGROND_SCORES_SPEELSCHERM_X_POS, ACHTERGROND_SCORES_SPEELSCHERM_Y_POS, ACHTERGROND_SCORES_SPEELSCHERM_BREEDTE, ACHTERGROND_SCORES_SPEELSCHERM_HOOGTE, RECT_HOEK_RADIUS);

  final float TEXT_X_POS = (width / 8) * (gridPosBreedte + 0.1);
  final float TEXT_Y_POS = SCHERM_HOOGTE - (SCOREBORD_HOOGTE / 5) * (gridPosHoogte + 0.25);

  fill(WIT);
  textFont(verdanaBold(12)); 
  text(text, TEXT_X_POS, TEXT_Y_POS);
}