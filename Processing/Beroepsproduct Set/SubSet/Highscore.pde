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


int getPlaatsInHighscoresLijst(String[] highscores, String highscore) {
  int x = -1;
  for (int i=0; i<highscores.length; i++) {
    if (highscores[i].equals(highscore))
      x = i + 1;
  }
  return x;
}

// Hulp functie om de highscore lijst te sorteren op tijd en daarna op score.
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
  fill(zwart, 175);
  rect(width * 0.15, height * 0.21, width * 0.7, height * 0.56, 25);
  
  fill(wit);
  text("HIGHSCORES", (width / 6) * 1.5, schermHoogte / 4);
  text("Naam ", (width / 6) * 1.5, schermHoogte / 4 + 25);
  text("Tijd", (width / 6) * 3, schermHoogte / 4 + 25);
  text("Score", (width / 6) * 3.75, schermHoogte / 4 + 25);
  
  String[] namen = loadStrings("highscores" + aantalVariaties + ".txt");
  namen = sorteerHighscores(namen);
  
  fill(wit);
  for (int i = 0; i < (namen.length > 10 ? 10 : namen.length); i++) {
    String[] line = split(namen[i], ',');

    if (line.length > 1) {
      text(""+(i + 1) + ": " + line[0], (width / 6) * 1.5, (schermHoogte / 3) + 20 * i);    
      text(line[2], (width / 6) * 3, (schermHoogte / 3) + 20 * i);
      text(line[1], (width / 6) * 3.75, (schermHoogte / 3) + 20 * i);
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