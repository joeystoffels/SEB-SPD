// Muisklik functie om kaarten te kunnen selecteren.
// Deze functie triggert het checken op een set na het selecteren van 3 kaarten.
void mousePressed() {      
  if (startSchermActive) { // Wanneer startScherm actief is zijn onderstaande knoppen beschikbaar.
    // Click Subset - 3 variations button
    if ((mouseX > 150 && mouseX < 450) && 
        mouseY > 350 && mouseY < 375) {
      aantalVariaties = 3;
      startSchermActive = false;
      setupSpel();   
    }
    
    // Click Set - 4 variations button
    if ((mouseX > 150 && mouseX < 450) && 
        mouseY > 390 && mouseY < 415) {
      aantalVariaties = 4;
      startSchermActive = false;
      setupSpel();   
    }      
     
    // Click clear highscores button 
    if ((mouseX > 150 && mouseX < 450) && 
        mouseY > 450 && mouseY < 475) {
      verwijderHighscores();
    }          
    return;
  }

  // return indien er buiten het speelveld geklikt is.
  if (mouseY >= height - hoogteScorebord) {
    
    if (mouseX > ((width / 8) * 4) && mouseX < (width / 6) + ((width / 8) * 4) && 
      mouseY < (height - (hoogteScorebord / 5)) && mouseY > (height - (hoogteScorebord / 5))-(hoogteScorebord / 5)){ 
      geefHint();
    }
    
   if (mouseX > ((width / 8) * 4) && mouseX < (width / 6) + ((width / 8) * 4) && 
      mouseY < (height - (hoogteScorebord / 5) * 3) && mouseY > (height - (hoogteScorebord / 5) * 3)-(hoogteScorebord / 5)){
      herstart();
    }
   
    if (mouseX > ((width / 8) * 6) && mouseX < (width / 6) + ((width / 8) * 6) && 
      mouseY < (height - (hoogteScorebord / 5)) && mouseY > (height - (hoogteScorebord / 5))-(hoogteScorebord / 5)){
      voegKaartenToe();
    } 
    
    if (mouseX > ((width / 8) * 6) && mouseX < (width / 6) + ((width / 8) * 6) && 
      mouseY < (height - (hoogteScorebord / 5) * 3) && mouseY > (height - (hoogteScorebord / 5) * 3)-(hoogteScorebord / 5)){
      startSchermActive = true;
      herstart();
    } 
    return;
  }  
  
  // Wanneer er niet op het scorebord is geklikt wanneer het startscherm niet actief is, is er op een kaart geklikt.
  selecteerKaart();
}

void selecteerKaart() {
  int xVeld = mouseX / (width / xVelden);
  int yVeld = mouseY / (hoogteSpeelveld / yVelden);

  println("CLICKED " + mouseX, mouseY);

  String kaart = speelVeld[xVeld][yVeld]; 

  if (kaart == standaardKaart) {
    return;
  }

  if (geselecteerdeKaarten.contains(kaart)) {
    speelVeldKleur[xVeld][yVeld] = zwart;
    geselecteerdeKaarten.remove(kaart);
  } else {  
    if (!geselecteerdeKaarten.contains(kaart) && geselecteerdeKaarten.size() < 3) {
      geselecteerdeKaarten.add(speelVeld[xVeld][yVeld]);
      speelVeldKleur[xVeld][yVeld] = color(wit, 125);
      if (geselecteerdeKaarten.size() == 3) { 
        verifieerSet();
      }
    }
  }
}


// Toetsenbord acties, gebruikt voor het invoeren van de naam van de speler aan het eind van het spel.
void keyPressed() { 
  if (key==CODED){
    if (keyCode==KeyEvent.VK_F12) {
      println("F12 Pressed");
      startSchermActive = false;
      spelAfgelopen = true;
      aantalKaartenOpSpeelveld = 0;
      aantalSetsSpeelveld = 0;
    }
  }
  if (spelAfgelopen){
    if (key==BACKSPACE) { 
      if (naam.length() > 0) {
        setNaam(naam.substring(0, naam.length() -1));
      } else {
        return; // Als naam al 0 lengte heeft dan niks doen.
      }
    } else if (key==ENTER) {
      if (!scoreOpgeslagen) {
        opslaanHighscore();
        scoreOpgeslagen = true;
      }
    } else if (key==CODED){
      if (keyCode==SHIFT){
        return;
      }
    } else {
      setNaam(naam + key);
    }
  } else {
    return; // Niks doen wanneer het spel nog niet klaar is
  }

}


// Functie om een hint te geven door 2 kaarten een andere (random) achtergrondkleur te geven.
void geefHint() {   
  if (aantalSetsSpeelveld == 0) {
    return; // Als er geen sets zijn is er geen hint.
  }
  
   String[] set = setsLijst.get(int(random(0, setsLijst.size())));
   
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


// Functie om een extra kolom kaarten toe te voegen aan het huidige speelveld.
void voegKaartenToe() {
  if(!voegXVeldToe){
    xVelden++;
    surface.setSize(xVelden * kaartBreedte, yVelden * kaartHoogte); 
    //kaartBreedte = width / xVelden;
    //kleinGridBreedte = width / (xVelden * 8);
    
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
          nieuwSpeelVeld[x][y] = standaardKaart;
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


// Functie om een set te checken.
void verifieerSet() {    
  String kaartEen = geselecteerdeKaarten.get(0);
  String kaartTwee = geselecteerdeKaarten.get(1);
  String kaartDrie = geselecteerdeKaarten.get(2);

  if (isSet(kaartEen, kaartTwee, kaartDrie)) {
    println("SET gevonden: " + kaartEen + " " + kaartTwee + " " + kaartDrie);
    scoreSpelerEen++;
    verwijderKaarten(geselecteerdeKaarten);
    aantalSetsSpeelveld(); // tel opnieuw het aantal sets op het huidige speelveld.    
    resetSpeelveldAchtergrond();
  }
}


// Reset alle kaart-achtergronden van de kaarten op het speelveld.
void resetSpeelveldAchtergrond() {     
  for (int x = 0; x < xVelden; x++) {
    for (int y = 0; y < yVelden; y++) {
      speelVeldKleur[x][y] = zwart;
    }
  }
}


// Generieke functie voor het verifieren van een set.
boolean isSet(String kaartEen, String kaartTwee, String kaartDrie) {
  boolean testChar0 = false;
  boolean testChar1 = false;
  boolean testChar2 = false;
  boolean testChar3 = aantalVariaties != 4;  
  
  for (int charToTest = 0; charToTest < aantalVariaties ; charToTest++) {
    if (!(kaartEen == standaardKaart || kaartTwee == standaardKaart || kaartDrie == standaardKaart)) {
      if ((kaartEen.charAt(charToTest) == kaartTwee.charAt(charToTest) && kaartTwee.charAt(charToTest) == kaartDrie.charAt(charToTest) && kaartEen.charAt(charToTest) == kaartDrie.charAt(charToTest))  || 
        (kaartEen.charAt(charToTest) != kaartTwee.charAt(charToTest) && kaartTwee.charAt(charToTest) != kaartDrie.charAt(charToTest) && kaartEen.charAt(charToTest) != kaartDrie.charAt(charToTest))) {
        //println(kaartEen, kaartTwee, kaartDrie, charToCheck, aantalSetsSpeelveld); 
        if (charToTest == 0) testChar0 = true;
        if (charToTest == 1) testChar1 = true;
        if (charToTest == 2) testChar2 = true;
        if (charToTest == 3) testChar3 = true;
      }
    }
  }
  return (testChar0 && testChar1 && testChar2 && testChar3);
}