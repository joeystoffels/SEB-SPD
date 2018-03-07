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
        if (speelVeld[x][y].equals(legeKaart)){
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


// Verwijdert de kaart van het huidige speelveld.
void verwijderKaarten(ArrayList<String> kaarten) {
  for (String kaart : kaarten) {
    for (int x = 0; x < xVelden; x++) {
      for (int y = 0; y < yVelden; y++) {      
        if (speelVeld[x][y] == kaart) {
          speelVeld[x][y] = pakKaart();
        }
      }
    }
  }
  geselecteerdeKaarten.removeAll(geselecteerdeKaarten);
}


// Functie om het aantal sets op het speelveld te tellen.
void aantalSetsSpeelveld() {  
  setsLijst.clear();
  aantalSetsSpeelveld = 0;  
  
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
              
              // Aanmaken gesorteerde setKaarten array om te vergelijken met de sets in de setsLijst.
              String[] setKaarten = {kaartEen, kaartTwee, kaartDrie};              
              java.util.Arrays.sort(setKaarten);

              boolean isSetInSetsLijst = setInSetsLijst(setKaarten);

              // Check of de 3 kaarten een set zijn, zo ja, verhoog het aantalSetsSpeelveld en voeg de set toe aan de setsLijst.
              if ((!kaartEen.equals(kaartTwee) && !kaartTwee.equals(kaartDrie) && !kaartEen.equals(kaartDrie)) && isSetInSetsLijst) {
                if (isSet(kaartEen, kaartTwee, kaartDrie)) {
                  aantalSetsSpeelveld++;                  
                  setsLijst.add(setKaarten);
                }
              }
            }
          }
        }
      }
    }
  }
  println("Er liggen " + setsLijst.size() + " sets op het speelveld:");
  for ( String[] set : setsLijst ) {   
    println("SET #" + (setsLijst.indexOf(set) + 1) + ": " + set[0] + ", " + set[1] + ", " + set[2]);
  }
}

// Check of de 3 kaarten al als een set in de setsLijst aanwezig is.
boolean setInSetsLijst(String[] setKaarten) {
  boolean isSetInSetsLijst = true;

  for (int x = 0; x < setsLijst.size(); x++) {
      if (java.util.Arrays.equals(setsLijst.get(x), setKaarten)) {
        isSetInSetsLijst = false;
        break;
      } else {
        isSetInSetsLijst = true;
      }                
  }
  return isSetInSetsLijst;
}


// Functie om de speelveldlijnen te tekenen.
void tekenSpeelveldLijnen() {    
  stroke(wit, 150);

  for (int x = 1; x < yVelden; x++) {
    line(0, speelveldHoogte / yVelden * x, width, speelveldHoogte / yVelden * x);
  }

  for (int y = 1; y < xVelden; y++) {
    line(width / xVelden * y, 0, width / xVelden * y, speelveldHoogte);
  }  

  // Laatste lijn van het speelveld, begin van het scorebord.
  line(0, speelveldHoogte, width, speelveldHoogte);
}