// Functie om het speelveld (array) te initialiseren.
void maakSpeelveld() {  
  if (speelVeld[0][0] == null) {
    for (int x=0; x < xVelden; x++) {
      for (int y=0; y < YVELDEN; y++) {
        speelVeld[x][y] = pakKaart();
      }
    }
  } else {
    for (int x=0; x < xVelden; x++) {
      for (int y=0; y < YVELDEN; y++) {
        if (speelVeld[x][y].equals(LEGE_KAART)) {
          speelVeld[x][y] = pakKaart();
        }
      }
    }
  }
}

// Verwijdert de kaart van het huidige speelveld.
void verwijderKaarten(String[] kaarten) {
  for (String kaart : kaarten) {
    for (int x = 0; x < xVelden; x++) {
      for (int y = 0; y < YVELDEN; y++) {      
        if (speelVeld[x][y] == kaart) {
          speelVeld[x][y] = pakKaart();
        }
      }
    }
  }
  geselecteerdeKaarten = new String[0];
}

// Functie om het aantal sets op het speelveld te tellen.
void updateAantalSetsSpeelveld() {  
  setsLijst.clear();
  aantalSetsSpeelveld = 0;  

  String[][] arrayEen = speelVeld;
  String[][] arrayTwee = speelVeld;
  String[][] arrayDrie = speelVeld;

  // Loop over alle mogelijke kaart combinaties en check + opslaan welke een set zijn.
  for (int a = 0; a < xVelden; a++) {
    for (int b = 0; b < YVELDEN; b++) {      
      for (int c = 0; c < xVelden; c++) {
        for (int d = 0; d < YVELDEN; d++) {      
          for (int e = 0; e < xVelden; e++) {
            for (int f = 0; f < YVELDEN; f++) {      

              String kaartEen = arrayEen[a][b];
              String kaartTwee = arrayTwee[c][d];
              String kaartDrie = arrayDrie[e][f];

              // Aanmaken gesorteerde setKaarten array om te vergelijken met de sets in de setsLijst.
              String[] setKaarten = {kaartEen, kaartTwee, kaartDrie};              
              setKaarten = sort(setKaarten);

              boolean isSetInSetsLijst = setInSetsLijst(setKaarten);

              // Check of de 3 kaarten een set zijn, zo ja, verhoog het aantalSetsSpeelveld en voeg de set toe aan de setsLijst.
              if (isSet(kaartEen, kaartTwee, kaartDrie) && !isSetInSetsLijst) {
                aantalSetsSpeelveld++;                  
                setsLijst.add(setKaarten);
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
  boolean isSetInSetsLijst = false;

  for (int x = 0; x < setsLijst.size(); x++) {
    if (java.util.Arrays.equals(setsLijst.get(x), setKaarten)) { //TODO REMOVE!!
      isSetInSetsLijst = true;
      break;
    } else {
      isSetInSetsLijst = false;
    }
  }
  return isSetInSetsLijst;
}