// Functie om de highscore op te slaan.
void opslaanHighscore() {
  String[] highscoresOud = loadStrings("highscores" + aantalVariaties + ".txt");
  String[] highscoresNieuw = new String[highscoresOud.length + 1];

  for (int i = 0; i < highscoresOud.length; i++) {
    highscoresNieuw[i] = highscoresOud[i];
  }

  String highscore = naam + "," + scoreSpelerEen + "," + String.format("%.2f", tijd); 
  highscoresNieuw[highscoresNieuw.length - 1] = highscore;
  highscoresNieuw = sorteerHighscores(highscoresNieuw);

  plaatsOpHighscoreLijst = getPlaatsInHighscoresLijst(highscoresNieuw, highscore);

  saveStrings("data/highscores" + aantalVariaties + ".txt", highscoresNieuw);
  println("Highscore opgeslagen! \n Plaats op highscore lijst: " + plaatsOpHighscoreLijst);
}

// Functie om de plaats in de highscores lijst op te halen.
int getPlaatsInHighscoresLijst(String[] highscores, String highscore) {
  int plaatsInHighscoresLijst = -1;
  for (int i=0; i<highscores.length; i++) {
    if (highscores[i].equals(highscore))
      plaatsInHighscoresLijst = i + 1;
  }
  return plaatsInHighscoresLijst;
}

// Functie om de highscore lijst te sorteren op tijd en daarna op score.
String[] sorteerHighscores(String[] highscoreLijst) {
  for (int x = 0; x < highscoreLijst.length; x++) {
    for (int i = 0; i < highscoreLijst.length - 1; i++) {

      String huidigeHighscore = highscoreLijst[i];
      String volgendeHighscore = highscoreLijst[i+1];

      String[] scoreHuidigeHighscore = split(highscoreLijst[i], ',');    
      String[] scoreVolgendeHighscore = split(highscoreLijst[i+1], ',');

      // Sorteer op tijd
      if (float(scoreHuidigeHighscore[2]) > float(scoreVolgendeHighscore[2])) {
        highscoreLijst[i] = volgendeHighscore;
        highscoreLijst[i+1] = huidigeHighscore;
      } 

      // Wanneer tijden gelijk zijn, sorteer op score
      if (float(scoreHuidigeHighscore[2]) == float(scoreVolgendeHighscore[2])) {
        if (float(scoreHuidigeHighscore[1]) < float(scoreVolgendeHighscore[1])) {
          highscoreLijst[i] = volgendeHighscore;
          highscoreLijst[i+1] = huidigeHighscore;
        }
      }
    }
  }
  return highscoreLijst;
}

// Functie om de highscore lijst weer te geven.
void toonHighscoreLijst() {    
  final float TITELTEXT_EINDSCHERM_X_POS = width / 4;
  final float TITELTEXT_EINDSCHERM_Y_POS = SCHERM_HOOGTE / 4 + 40;    
  final float TIJD_TITELTEXT_EINDSCHERM_X_POS = TITELTEXT_EINDSCHERM_X_POS * 2; 
  final float SCORE_TITELTEXT_EINDSCHERM_X_POS = TITELTEXT_EINDSCHERM_X_POS * 2.5;  
  final float HIGHSCORES_TITELTEXT_EINDSCHERM_Y_POS = SCHERM_HOOGTE / 4;
  final float NAAM_HIGHSCORE_EINDSCHERM_START_Y_POS = SCHERM_HOOGTE / 3;  
  final float ACHTERGROND_HIGHSCORES_X_POS = width * 0.15;
  final float ACHTERGROND_HIGHSCORES_Y_POS = SCHERM_HOOGTE * 0.21;
  final float ACHTERGROND_HIGHSCORES_BREEDTE = width * 0.7;
  final float ACHTERGROND_HIGHSCORES_HOOGTE = SCHERM_HOOGTE * 0.56;  
  final int NAAM_HIGHSCORE_OFFSET_Y_POS = 20;

  fill(ZWART, 175);
  rect(ACHTERGROND_HIGHSCORES_X_POS, ACHTERGROND_HIGHSCORES_Y_POS, ACHTERGROND_HIGHSCORES_BREEDTE, ACHTERGROND_HIGHSCORES_HOOGTE, RECT_HOEK_RADIUS);   

  fill(WIT);
  text("HIGHSCORES", TITELTEXT_EINDSCHERM_X_POS, HIGHSCORES_TITELTEXT_EINDSCHERM_Y_POS);
  text("Naam ", TITELTEXT_EINDSCHERM_X_POS, TITELTEXT_EINDSCHERM_Y_POS);
  text("Tijd", TIJD_TITELTEXT_EINDSCHERM_X_POS, TITELTEXT_EINDSCHERM_Y_POS);
  text("Score", SCORE_TITELTEXT_EINDSCHERM_X_POS, TITELTEXT_EINDSCHERM_Y_POS);

  String[] namen = loadStrings("highscores" + aantalVariaties + ".txt");
  namen = sorteerHighscores(namen);

  fill(WIT);
  for (int i = 0; i < (namen.length > 10 ? 10 : namen.length); i++) {
    String[] line = split(namen[i], ',');

    if (line.length > 1) {
      text(""+(i + 1) + ": " + line[0], TITELTEXT_EINDSCHERM_X_POS, NAAM_HIGHSCORE_EINDSCHERM_START_Y_POS + NAAM_HIGHSCORE_OFFSET_Y_POS * i);    
      text(line[2], TIJD_TITELTEXT_EINDSCHERM_X_POS, NAAM_HIGHSCORE_EINDSCHERM_START_Y_POS + NAAM_HIGHSCORE_OFFSET_Y_POS * i);
      text(line[1], SCORE_TITELTEXT_EINDSCHERM_X_POS, NAAM_HIGHSCORE_EINDSCHERM_START_Y_POS + NAAM_HIGHSCORE_OFFSET_Y_POS * i);
    }
  }
}

// Functie om de highscore lijst leeg te maken.
void verwijderHighscores() {
  String[] namen = new String[0];
  saveStrings("data/highscores3.txt", namen);
  saveStrings("data/highscores4.txt", namen);
  println("Highscores verwijderd!");
}