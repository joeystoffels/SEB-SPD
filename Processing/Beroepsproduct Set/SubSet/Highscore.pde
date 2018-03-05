// Functie om de highscore op te slaan.
void opslaanHighscore(){
  String[] highscoresOld = loadStrings("highscores" + aantalVariaties + ".txt");
  String[] highscoresNew = new String[highscoresOld.length + 1];
  
  for (int i = 0 ; i < highscoresOld.length ; i++) {
    highscoresNew[i] = highscoresOld[i]; 
  }
  
  String highscore = naam + "," + scoreSpelerEen + "," + String.format("%.2f", tijd); 
  highscoresNew[highscoresNew.length - 1] = highscore;
  highscoresNew = sorteerHighscores(highscoresNew);

  plaatsOpHighscoreLijst = getIndexOf(highscoresNew, highscore);
  
  saveStrings("data/highscores" + aantalVariaties + ".txt", highscoresNew);
  println("Highscore opgeslagen!");
  println("Plaats op highscore lijst: " + plaatsOpHighscoreLijst);
}


int getIndexOf(String[] array, String value) {
  int x = -1;
    for(int i=0; i<array.length; i++) {
         if(array[i].equals(value))
             x = i + 1;
    }
    return x;             
}


// Hulp functie om de highscore lijst te sorteren op tijd en daarna op score.
String[] sorteerHighscores(String[] array) {
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


// Functie om de highscore lijst aan te maken.
void maakHighscoreLijst() {
  background(zwart);
  text("HIGHSCORES", (width / 6) * 1.5, height / 4);
  text("Naam ", (width / 6) * 1.5, height / 4 + 25);
  text("Tijd", (width / 6) * 3, height / 4 + 25);
  text("Score", (width / 6) * 3.75, height / 4 + 25);
  
  String[] namen = loadStrings("highscores" + aantalVariaties + ".txt");
  namen = sorteerHighscores(namen);
  for (int i = 0 ; i < (namen.length > 10 ? 10 : namen.length) ; i++) {
    String[] line = split(namen[i], ',');

    if(line.length > 1) {
      text(""+(i + 1) + ": " + line[0], (width / 6) * 1.5, (height / 3) + 20 * i);    
      text(line[2], (width / 6) * 3, (height / 3) + 20 * i);
      text(line[1], (width / 6) * 3.75, (height / 3) + 20 * i);
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

//highscore enkel opslaan als de top 10 behaald is?
//realtime naam invoeren in highscore array?