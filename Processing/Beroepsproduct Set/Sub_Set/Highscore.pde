void saveHighscore(){
    String[] highscoresOld = loadStrings("highscores.txt");
    String[] highscoresNew = new String[highscoresOld.length + 1];
    
    for (int i = 0 ; i < highscoresOld.length ; i++) {
      highscoresNew[i] = highscoresOld[i]; 
    }
    
    highscoresNew[highscoresNew.length - 1] = naam + "," + scoreSpelerEen + "," + String.format("%.2f", tijd);    
        
    highscoresNew = highscoreSorter(highscoresNew);
    
    saveStrings("data/highscores.txt", highscoresNew);
}

String[] highscoreSorter(String[] array) {
  for (int x = 0 ; x < array.length ; x++) {
    for (int i = 0 ; i < array.length - 1; i++) {
      
      String array1 = array[i];
      String array2 = array[i+1];
      
      String[] test1 = split(array[i], ',');    
      String[] test2 = split(array[i+1], ',');
      
      if (float(test1[2]) > float(test2[2])) {
        array[i] = array2;
        array[i+1] = array1;
      } 
      
      if (float(test1[2]) == float(test2[2])) {
        if (float(test1[1]) < float(test2[1])) {
          array[i] = array2;
          array[i+1] = array1;
        } 
      }    
    }
  }
  return array;
}

//TODO: Naar einde verplaatsen
//Knop beginscherm tijdens spel en aan t eind toevoegen
//Highscore max 10
//Highscore array sorteren op score

void createHighscoreLijst() {
  background(zwart);
  text("HIGHSCORES", 85, 65);
  text("Naam ", 25, 90);
  text("Tijd", 135, 90);
  text("Score", 200, 90);
  
  String[] namen = loadStrings("highscores.txt");
  namen = highscoreSorter(namen);
  for (int i = 0 ; i < (namen.length > 10 ? 10 : namen.length) ; i++) {
    String[] line = split(namen[i], ',');

    if(line.length > 1) {
      text(""+(i + 1) + ": " + line[0], 25, 115 + 20 * i);    
      text(line[2], 135, 115 + 20 * i);
      text(line[1], 200, 115 + 20 * i);
    }
  }
}

void clearHighscores() {
  String[] namen = new String[0];
  saveStrings("data/highscores.txt", namen);
}

//TODO voeg moeilijkheisgraad toe??