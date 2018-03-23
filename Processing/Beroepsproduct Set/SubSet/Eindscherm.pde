void toonEindscherm() {      
  toonHighscoreLijst();
  tekenNaamInvoer();       
  tekenEindeTitel(); 
  tekenAchtergrondScoresEindscherm();

  tekenKnopScorebord("Opnieuw", 6, 3); 
  tekenKnopScorebord("Startscherm", 6, 1);
  
  tekenSpelInfoText("Tijd: ", String.format("%.2f", tijd), 5);
  tekenSpelInfoText("Score: ", nf(scoreSpelerEen), 7);
}

void tekenNaamInvoer() {    
  final float NAAM_INVOER_X_POS = width * 0.25;
  final float NAAM_INVOER_Y_POS = SCHERM_HOOGTE * 0.725;
  
  if (spelAfgelopen && !scoreOpgeslagen) {
    text("Voer naam in: " + naam, NAAM_INVOER_X_POS, NAAM_INVOER_Y_POS);
  } else if (spelAfgelopen && scoreOpgeslagen) {
    text("Je bent geeindigd op de " + plaatsOpHighscoreLijst + "e plaats!", NAAM_INVOER_X_POS, NAAM_INVOER_Y_POS);
  }
}

void tekenEindeTitel() {    
  final float EINDE_TEXT_X_POS = width / 2;
  final float EINDE_TEXT_Y_POS = SPEELVELD_HOOGTE / 5.5;  
  final int FONTSIZE_EINDETITEL = SCOREBORD_HOOGTE / 3;
  
  tekenAchtergrondEindeTitel();

  fill(WIT);
  textAlign(CENTER);
  textFont(verdanaBold(FONTSIZE_EINDETITEL));   
  text("EINDE", EINDE_TEXT_X_POS, EINDE_TEXT_Y_POS);    
  textAlign(LEFT);  
}

void tekenAchtergrondEindeTitel() {  
  final float ACHTERGROND_EINDETITEL_X_POS = width / 7;
  final float ACHTERGROND_EINDETITEL_Y_POS = SPEELVELD_HOOGTE / 9;
  final float ACHTERGROND_EINDETITEL_BREEDTE = ACHTERGROND_EINDETITEL_X_POS * 5;
  final float ACHTERGROND_EINDETITEL_HOOGTE = SPEELVELD_HOOGTE / 9;
  
  fill(ZWART, 150);  
  rect(ACHTERGROND_EINDETITEL_X_POS, ACHTERGROND_EINDETITEL_Y_POS, ACHTERGROND_EINDETITEL_BREEDTE, ACHTERGROND_EINDETITEL_HOOGTE, RECT_HOEK_RADIUS);
}

void tekenAchtergrondScoresEindscherm() { 
  final float ACHTERGROND_SCORES_EINDSCHERM_X_POS = width * 0.025;
  final float ACHTERGROND_SCORES_EINDSCHERM_Y_POS= SCHERM_HOOGTE - SCOREBORD_HOOGTE;
  final float ACHTERGROND_SCORES_EINDSCHERM_BREEDTE = width * 0.38;
  final float ACHTERGROND_SCORES_HOOGTE = SCOREBORD_HOOGTE / 1.6;

  fill(ZWART, 150);
  rect(ACHTERGROND_SCORES_EINDSCHERM_X_POS, ACHTERGROND_SCORES_EINDSCHERM_Y_POS, ACHTERGROND_SCORES_EINDSCHERM_BREEDTE, ACHTERGROND_SCORES_HOOGTE, RECT_HOEK_RADIUS);
}