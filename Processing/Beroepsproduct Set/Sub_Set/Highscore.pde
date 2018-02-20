void saveHighscore(){
    String[] highscoresOld = loadStrings("highscores.txt");
    String[] highscoresNew = new String[highscoresOld.length + 1];
    
    for (int i = 0 ; i < highscoresOld.length ; i++) {
      highscoresNew[i] = highscoresOld[i]; 
    }
    
    highscoresNew[highscoresNew.length - 1] = naam + "," + scoreSpelerEen + "," + tijd;    
    
    saveStrings("data/highscores.txt", highscoresNew);
}

//TODO: Naar einde verplaatsen
//Knop beginscherm tijdens spel en aan t eind toevoegen
//Highscore max 10
//Highscore array sorteren op score

void createHighscoreLijst() {
    background(zwart);
    text("HIGHSCORES", 25, 25);
    text("Naam ", 25, 50);
    text("Score", 150, 50);
    text("Tijd", 225, 50);
    
    String[] namen = loadStrings("highscores.txt");
    for (int i = 0 ; i < (namen.length > 10 ? 10 : namen.length) ; i++) {
        String[] line = split(namen[i], ',');

    text((i + 1) + ": " + line[0], 25, 75 + 25 * i);
    text(line[1], 150, 75 + 25 * i);
    text(line[2], 225, 75 + 25 * i);
  }
}