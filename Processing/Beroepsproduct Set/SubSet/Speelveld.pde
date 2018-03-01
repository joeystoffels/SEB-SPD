// Functie om het speelveld (array) te initialiseren.
void maakSpeelveld() {  
  if(speelVeld[0][0] == null) {
    for (int x=0; x < xVelden; x++) {
      for (int y=0; y < yVelden; y++) {
        speelVeld[x][y] = pakKaart();
      }
    }
  } else {
    for (int x=0; x < xVelden; x++) {
      for (int y=0; y < yVelden; y++) {
        if (speelVeld[x][y].equals("0000")){
          speelVeld[x][y] = pakKaart();
        }
      }
    }
  }
}


// Functie om het speelveld te vullen met kaarten.
void vulSpeelveld() {
  for (int x=0; x < xVelden; x++) {
    for (int y=0; y < yVelden; y++) {
      maakKaartFiguur(speelVeld[x][y], x, y);
    }
  }
}


// Functie om een extra kolom kaarten toe te voegen aan het huidige speelveld.
void voegKaartenToe() {
  if(!voegXVeldToe){
    xVelden++;
    surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte); 
    String[][] nieuwSpeelVeld = new String[xVelden][yVelden];
    color[][] nieuwSpeelVeldKleur = new color[xVelden][yVelden];
    
    for(int x = 0 ; x < xVelden-1 ; x++){
      for(int y = 0 ; y < yVelden ; y++) {
        nieuwSpeelVeld[x][y] = speelVeld[x][y];
        nieuwSpeelVeldKleur[x][y] = speelVeldKleur[x][y];    
      }
    }
    
    for(int x = 0 ; x < xVelden ; x++){
      for(int y = 0 ; y < yVelden ; y++) {
        if(nieuwSpeelVeld[x][y] == null || Integer.valueOf(nieuwSpeelVeldKleur[x][y]) == null) {
          nieuwSpeelVeld[x][y] = "0000";
          nieuwSpeelVeldKleur[x][y] = zwart;
        }
      }
    }
    
    speelVeld = nieuwSpeelVeld;
    speelVeldKleur = nieuwSpeelVeldKleur;  
    maakSpeelveld();
    aantalSetsSpeelveld();
    voegXVeldToe = true;
  }
}


// Verwijdert de kaart van het huidige speelveld.
void verwijderKaart(String kaart) {
  for (int x = 0; x < xVelden; x++) {
    for (int y = 0; y < yVelden; y++) {      
      if (speelVeld[x][y] == kaart) {
        speelVeld[x][y] = pakKaart();
      }
    }
  }
}


// Functie om het aantal sets op het speelveld te tellen.
void aantalSetsSpeelveld() {  
  setList.clear();
  
  String[][] arrayEen = speelVeld;
  String[][] arrayTwee = speelVeld;
  String[][] arrayDrie = speelVeld;

  // Loop over alle mogelijke kaart combinaties en check + opslaan welke een set zijn.
  for (int a = 0; a < xVelden; a++) {
    for (int b = 0; b < yVelden; b++) {      
      for (int c = 0; c < xVelden; c++) {
        for (int d = 0; d < yVelden; d++) {      
          for (int e = 0; e < xVelden; e++) {
            for (int f = 0; f < yVelden; f++) {      

              String kaartEen = arrayEen[a][b];
              String kaartTwee = arrayTwee[c][d];
              String kaartDrie = arrayDrie[e][f];

              // Aanmaken gesorteerde temp array om te vergelijken met de arrays in de setList.
              String[] temp = {kaartEen, kaartTwee, kaartDrie};              
              java.util.Arrays.sort(temp);

              // Helper boolean om te checken of de set al geteld is.
              boolean go = true;

              // Check of de 3 kaarten al als een set in de setList aanwezig is.
              for (int x = 0; x < setList.size(); x++) {
                  if (java.util.Arrays.equals(setList.get(x), temp)) {
                    go = false;
                    break;
                  } else {
                    go = true;
                  }                
              }

              // Check of de 3 kaarten een set zijn, zo ja, verhoog het aantalSetsSpeelveld en voeg de set toe aan de setList.
              if ((!kaartEen.equals(kaartTwee) && !kaartTwee.equals(kaartDrie) && !kaartEen.equals(kaartDrie)) && go) {
                if (verifieerSet(kaartEen, kaartTwee, kaartDrie, 0) &&
                  verifieerSet(kaartEen, kaartTwee, kaartDrie, 1) &&
                  verifieerSet(kaartEen, kaartTwee, kaartDrie, 2) && 
                  (aantalVariaties == 4 ? verifieerSet(kaartEen, kaartTwee, kaartDrie, 3) : true)) {
                  aantalSetsSpeelveld++;                  
                  setList.add(temp);
                }
              }
            }
          }
        }
      }
    }
  }
  println("Sets op speelveld:");
  for ( String[] set : setList ) {    
    println(set);
  }
}


// Functie om de speelveldlijnen te tekenen.
void tekenSpeelveldLijnen() {    
  stroke(wit, 150);

  for (int x = 1; x < yVelden; x++) {
    line(0, (height - hoogteScorebord)/yVelden * x, width, (height - hoogteScorebord)/yVelden * x);
  }

  for (int y = 1; y < xVelden; y++) {
    line(width/xVelden * y, 0, width/xVelden * y, height - hoogteScorebord);
  }  

  // Laatste lijn van het speelveld, begin van het scorebord.
  line(0, height - hoogteScorebord, width, height - hoogteScorebord);
}