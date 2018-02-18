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