// Functie om een random kaart te kiezen uit de kaartenArrayList en deze 
// vervolgens te verwijderen uit de lijst, de kaartenArrayList stelt dus 
// de huidige stapel speelkaarten voor.
String getAndRemoveFromKaarten() { 
  if (!(kaartenArrayList.size() <= 0)) { 
    int random = int(random(0, kaartenArrayList.size()));
    String kaart = kaartenArrayList.get(random);
    kaartenArrayList.remove(random);  
    return kaart;
  } else {
    return defaultKaart; // return default zodat er geen nieuwe figuur gemaakt wordt
  }
};


// Functie om het speelveld te vullen met kaarten.
void vulSpeelveld() {
  for (int x=0; x < xVelden; x++) {
    for (int y=0; y < yVelden; y++) {
      createFiguur(speelVeld[x][y], x, y);
    }
  }
}


// Functie om het speelveld (array) te initialiseren.
void createSpeelVeld() {  
  if(speelVeld[0][0] == null) {
    for (int x=0; x < xVelden; x++) {
      for (int y=0; y < yVelden; y++) {
        speelVeld[x][y] = getAndRemoveFromKaarten();
      }
    }
  } else {
    for (int x=0; x < xVelden; x++) {
      for (int y=0; y < yVelden; y++) {
        if (speelVeld[x][y].equals("0000")){
          speelVeld[x][y] = getAndRemoveFromKaarten();
        }
      }
    }
  }
}


// Generieke helper functie voor het verifieren van een set.
boolean verifySet(String kaartEen, String kaartTwee, String kaartDrie, int charToCheck) {
  if (!(kaartEen == defaultKaart || kaartTwee == defaultKaart || kaartDrie == defaultKaart)) {
    if ((kaartEen.charAt(charToCheck) == kaartTwee.charAt(charToCheck) && kaartTwee.charAt(charToCheck) == kaartDrie.charAt(charToCheck) && kaartEen.charAt(charToCheck) == kaartDrie.charAt(charToCheck))  || 
      (kaartEen.charAt(charToCheck) != kaartTwee.charAt(charToCheck) && kaartTwee.charAt(charToCheck) != kaartDrie.charAt(charToCheck) && kaartEen.charAt(charToCheck) != kaartDrie.charAt(charToCheck))) {
      //println(kaartEen, kaartTwee, kaartDrie, charToCheck, aantalSetsSpeelveld); 
      return true;
    }
  }
  return false;
}


// Verwijdert de kaart van het huidige speelbord.
void verwijderKaart(String kaart) {
  for (int x = 0; x < xVelden; x++) {
    for (int y = 0; y < yVelden; y++) {      
      if (speelVeld[x][y] == kaart) {
        speelVeld[x][y] = getAndRemoveFromKaarten();
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
                if (verifySet(kaartEen, kaartTwee, kaartDrie, 0) &&
                  verifySet(kaartEen, kaartTwee, kaartDrie, 1) &&
                  verifySet(kaartEen, kaartTwee, kaartDrie, 2) && 
                  (aantalVariaties == 4 ? verifySet(kaartEen, kaartTwee, kaartDrie, 3) : true)) {
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
  if (aantalSetsSpeelveld == 0 && voegXVeldToe == true) {
    // eindeSpel();
  }
}


// Maak de stapel kaartenn adhv. het aantal geconfigureerde variaties.
void maakStapelKaarten(int aantalVariaties) {
  String[] aantal = {"1", "2", "3"};
  String[] kleur = {"r", "g", "b"}; // rood, groen, blauw
  String[] figuur = {"d", "r", "e"}; // driehoek, rechthoek, ellipse
  String[] vulling = {"l", "h", "v"}; // leeg, half, vol

  if (aantalVariaties == 3) {
    for (int a = 0; a < aantal.length; a++) {
      for (int f = 0; f < figuur.length; f++) {
        for (int k = 0; k < kleur.length; k++) {
          kaartenArrayList.add(aantal[a] + figuur[f] + kleur[k] + "0"); // "0" als default waarde zodat verifySet() goed uitgevoerd wordt
        }
      }
    }
  }
  
  if (aantalVariaties == 4) {
    for (int a = 0; a < aantal.length; a++) {
      for (int f = 0; f < figuur.length; f++) {
        for (int k = 0; k < kleur.length; k++) {
          for (int v = 0; v < vulling.length; v++) {
            kaartenArrayList.add(aantal[a] + figuur[f] + kleur[k] + vulling[v]);
          }
        }
      }
    }
  }

  // Console logging.
  println("Kaartenstapel: " + kaartenArrayList);
  println("Totaal aantal kaarten: " + kaartenArrayList.size());
}


// Functie om een set te checken.
void checkForSet() {    
  String kaartEen = selectedKaarten.get(0);
  String kaartTwee = selectedKaarten.get(1);
  String kaartDrie = selectedKaarten.get(2);

  if (verifySet(kaartEen, kaartTwee, kaartDrie, 0) &&
    verifySet(kaartEen, kaartTwee, kaartDrie, 1) &&
    verifySet(kaartEen, kaartTwee, kaartDrie, 2) && 
    verifySet(kaartEen, kaartTwee, kaartDrie, 3)) {
    println("SET: " + kaartEen + " " + kaartTwee + " " + kaartDrie);
    scoreSpelerEen++;
    verwijderKaart(kaartEen);
    verwijderKaart(kaartTwee);
    verwijderKaart(kaartDrie);
    selectedKaarten.removeAll(selectedKaarten);  
    aantalSetsSpeelveld = 0; // reset aantal sets wanneer er een set gevonden is.
    aantalSetsSpeelveld(); // tel opnieuw het aantal sets op het huidige speelveld.    

    // Reset alle kaart achtergrond kleuren.
    for (int x = 0; x < xVelden; x++) {
      for (int y = 0; y < yVelden; y++) {
        speelVeldKleur[x][y] = zwart;
      }
    }
  }
}


// Functie om een hint te geven door 2 kaarten een andere (random) achtergrondkleur te geven.
void geefHint() {   
  if (aantalSetsSpeelveld == 0) {
    return; // Als er geen sets zijn is er geen hint.
  }
  
   String[] set = setList.get(int(random(0, setList.size())));
   
   int counter = 0;
   color randomKleurRood = int(random(0, 255));
   color randomKleurGeel = int(random(0, 255));
   color randomKleurBlauw = int(random(0, 255));
   
   for(int x = 0 ; x < speelVeldKleur.length ; x++) {
     for(int y = 0 ; y < speelVeldKleur[x].length ; y++){
       if(java.util.Arrays.asList(set).contains(speelVeld[x][y]) && counter < 2) {         
         speelVeldKleur[x][y] = color(randomKleurRood, randomKleurGeel, randomKleurBlauw, 125);
         counter++;
       }       
     }
   }    
   scoreSpelerEen = scoreSpelerEen - 0.5;
}


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
    createSpeelVeld();
    aantalSetsSpeelveld();
    voegXVeldToe = true;
  }
}


void eindeSpel() {
   
}