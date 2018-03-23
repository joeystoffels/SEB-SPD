// Muisklik functie om kaarten te kunnen selecteren.
// Deze functie triggert het checken op een set na het selecteren van 3 kaarten.
void mousePressed() {  
  //println("CLICKED " + mouseX, mouseY);

  if (startSchermActief) { // Wanneer startScherm actief is zijn onderstaande knoppen beschikbaar.
    if (mouseX > width / 4 && mouseX < width / 4 * 3) {

      // Click Subset - 3 variations button
      if (mouseY > height / 10 * 7 && mouseY < height / 10 * 7 + 25) {        
        startSchermActief = false;
        spelActief = true;       
        aantalVariaties = 3;
        xVelden = 3;
        schermBreedte = (int) 0.75 * schermBreedte;
        setupSpel();
      }

      // Click Set - 4 variations button
      if (mouseY > height / 10 * 7.5 && mouseY < height / 10 * 7.5 + 25) {
        spelActief = true;                
        startSchermActief = false;
        aantalVariaties = 4;
        //xVelden = 4;
        setupSpel();
      }      
      
      if (mouseY > height / 10 * 8.5 && mouseY < height / 10 * 8.5 + 25) {
        startSchermActief = false;
        spelregelsActief = true;
      }

      // Click clear highscores button 
      if (mouseY > height / 10 * 9 && mouseY < height / 10 * 9 + 25) {
        verwijderHighscores();
      }
    }
    return;
  }
  
  if (spelregelsActief) {
    spelregelsActief = !spelregelsActief;
    startSchermActief = true;
  }
    

  // return indien er buiten het speelveld geklikt is.
  if (mouseY > SPEELVELD_HOOGTE) { 
    if (mouseX > (width / 8) * 4 && mouseX < ((width / 8) * 4) + 100) {

      if (mouseY < (height - (SCOREBORD_HOOGTE / 5)) && mouseY > (height - (SCOREBORD_HOOGTE / 5))-(SCOREBORD_HOOGTE / 5)) { 
        println("Voeg kaarten toe");
        voegKaartenToe();
      }

      if (mouseY < (height - (SCOREBORD_HOOGTE / 5) * 3) && mouseY > (height - (SCOREBORD_HOOGTE / 5) * 3)-(SCOREBORD_HOOGTE / 5)) {      
        println("Geef hint");
        geefHint();
      }
    }

    if (mouseX > (width / 8) * 6 && mouseX < ((width / 8) * 6) + 100) {
      if (mouseY < (height - (SCOREBORD_HOOGTE / 5)) && mouseY > (height - (SCOREBORD_HOOGTE / 5))-(SCOREBORD_HOOGTE / 5)) {
        println("Beginscherm");
        spelActief = false;
        startSchermActief = true;
        xVelden = 4;
        setupSpel();
      } 

      if (mouseY < (height - (SCOREBORD_HOOGTE / 5) * 3) && mouseY > (height - (SCOREBORD_HOOGTE / 5) * 3)-(SCOREBORD_HOOGTE / 5)) {
        println("Opnieuw");
        spelActief = true;
        startSchermActief = false;
        xVelden = aantalVariaties;
        setupSpel();
      }
    }
    return;
  }  
  
  if(spelAfgelopen) {
    return;
  }

  // Wanneer er niet op het scorebord is geklikt wanneer het startScherm niet actief is, is er op een kaart geklikt.
  selecteerKaart();
}

void selecteerKaart() {
  int xVeld = mouseX / KAART_BREEDTE;
  int yVeld = mouseY / KAART_HOOGTE;
  String kaart = "";

  try {
    kaart = speelVeld[xVeld][yVeld];
  } 
  catch (IndexOutOfBoundsException e) {
    println("IndexOutOfBoundsException, mouseX = " + mouseX + ", mouseY = " + mouseY + ".");
    return;
  }

  if (kaart.equals(LEGE_KAART)) {
    return;
  }

  if (arrayContains(geselecteerdeKaarten, kaart)) { //<>//
    speelVeldKleur[xVeld][yVeld] = ZWART;
    geselecteerdeKaarten = removeFromArray(geselecteerdeKaarten, arrayIndexOf(geselecteerdeKaarten, kaart));
  } else {  
    if (!arrayContains(geselecteerdeKaarten, kaart) && geselecteerdeKaarten.length < 3) {
      geselecteerdeKaarten = append(geselecteerdeKaarten, kaart); //geselecteerdeKaarten.add(speelVeld[xVeld][yVeld]);
      speelVeldKleur[xVeld][yVeld] = color(ZWART, 75);
      if (geselecteerdeKaarten.length == 3) { 
        verifieerSet();
      }
    }
  }
}

// Toetsenbord acties, gebruikt voor het invoeren van de naam van de speler aan het eind van het spel.
void keyPressed() {   
  switch(key) {
    case CODED: 
      keyPressedCoded(); 
      break;
    default: 
      keyPressedNonCoded(); 
      break;    
  }
}

void keyPressedCoded() {
  switch(keyCode) {
    case 121: 
      aantalHintKaarten = aantalHintKaarten == 3 ? 2 : 3;
      println("Cheat: Hint " + aantalHintKaarten + " kaarten!");
      break;
    case 122:
      if (airwolfThemeActive) {
        setAchtergrondVideo(rainbowVideo);
        setLogo = loadImage(setImgBestandsLocatie);
      }
      else {
        setAchtergrondVideo(airwolfVideo);        
        setLogo = airwolfLogo;
      }
      
      airwolfThemeActive = !airwolfThemeActive;      
      println("Cheat: Airwolf theme " + (airwolfThemeActive ? "activated" : "deactivated") + "!");
      break;
    case 123:  
      activeerEindeSpel();
      break;
    default: 
      return;
  }
}

void keyPressedNonCoded() {
  switch(key) {
    case BACKSPACE: 
      if (spelAfgelopen && naam.length() > 0) {
        setNaam(naam.substring(0, naam.length() -1));
      } 
      break;
    case ENTER:   
      if (spelAfgelopen && !scoreOpgeslagen) {
        opslaanHighscore();
        scoreOpgeslagen = true;
      }
      break;
    default:     
      if (Character.isLetter(key) || Character.isDigit(key)){
        setNaam(naam + key);
      }
  }
}

// Functie om een hint te geven door 2 kaarten een andere borderkleur te geven.
void geefHint() {   
  if (aantalSetsSpeelveld == 0) {
    return; // Als er geen sets zijn is er geen hint.
  }

  String[] set = setsLijst.get(int(random(0, setsLijst.size())));
  
  resetSpeelveldAchtergrond();
  int counter = 0;
  
  for (int x = 0; x < speelkaartBorderKleur.length; x++) {
    for (int y = 0; y < speelkaartBorderKleur[x].length; y++) {
      if (contains(set, speelVeld[x][y]) && counter < aantalHintKaarten) {
        speelkaartBorderKleur[x][y] = color(255, 0, 255);
        counter++;
      }
    }
  }
  scoreSpelerEen = scoreSpelerEen - 0.5;
}

// Functie om een extra kolom kaarten toe te voegen aan het huidige speelveld.
void voegKaartenToe() {
  if (!kaartenToegevoegd) {
    xVelden++;
    maakSpelScherm();

    String[][] nieuwSpeelVeld = new String[xVelden][YVELDEN];
    color[][] nieuwSpeelVeldKleur = new color[xVelden][YVELDEN];
    color[][] nieuwSpeelkaartBorderKleur = new color[xVelden][YVELDEN];

    for (int x = 0; x < xVelden-1; x++) {
      for (int y = 0; y < YVELDEN; y++) {
        nieuwSpeelVeld[x][y] = speelVeld[x][y];
        nieuwSpeelVeldKleur[x][y] = speelVeldKleur[x][y];
        nieuwSpeelkaartBorderKleur[x][y] = speelkaartBorderKleur[x][y];
      }
    }

    for (int x = 0; x < xVelden; x++) {
      for (int y = 0; y < YVELDEN; y++) {
        if (nieuwSpeelVeld[x][y] == null || Integer.valueOf(nieuwSpeelVeldKleur[x][y]) == null) { // Integer zodat er geen NullPointer kan komen
          nieuwSpeelVeld[x][y] = LEGE_KAART;
          nieuwSpeelVeldKleur[x][y] = ZWART;
          nieuwSpeelkaartBorderKleur[x][y] = WIT;
        }
      }
    }

    speelVeld = nieuwSpeelVeld;
    speelVeldKleur = nieuwSpeelVeldKleur; 
    speelkaartBorderKleur = nieuwSpeelkaartBorderKleur;
    maakSpeelveld();
    updateAantalSetsSpeelveld();
    kaartenToegevoegd = true;
  }
}

// Functie om een set te checken.
void verifieerSet() {    
  String kaartEen = geselecteerdeKaarten[0];
  String kaartTwee = geselecteerdeKaarten[1];
  String kaartDrie = geselecteerdeKaarten[2];

  if (isSet(kaartEen, kaartTwee, kaartDrie)) {
    println("SET gevonden: " + kaartEen + " " + kaartTwee + " " + kaartDrie);
    scoreSpelerEen++;
    verwijderKaarten(geselecteerdeKaarten);
    updateAantalSetsSpeelveld(); // tel opnieuw het aantal sets op het huidige speelveld.    
    resetSpeelveldAchtergrond();
  }
}

// Reset alle kaart-achtergronden van de kaarten op het speelveld.
void resetSpeelveldAchtergrond() {     
  for (int x = 0; x < xVelden; x++) {
    for (int y = 0; y < YVELDEN; y++) {
      speelVeldKleur[x][y] = ZWART;
      speelkaartBorderKleur[x][y] = WIT;
    }
  }
}

// Generieke functie voor het verifieren van een set.
boolean isSet(String kaartEen, String kaartTwee, String kaartDrie) {
  boolean testCharResult = false;
  if ((!kaartEen.equals(kaartTwee) && !kaartTwee.equals(kaartDrie) && !kaartEen.equals(kaartDrie))) {
    if (!(kaartEen.equals(LEGE_KAART) || kaartTwee.equals(LEGE_KAART) || kaartDrie.equals(LEGE_KAART))) { 
      for (int charToTest = 0; charToTest < aantalVariaties; charToTest++) {
        if ((kaartEen.charAt(charToTest) == kaartTwee.charAt(charToTest) && kaartTwee.charAt(charToTest) == kaartDrie.charAt(charToTest)) || 
          (kaartEen.charAt(charToTest) != kaartTwee.charAt(charToTest) && kaartTwee.charAt(charToTest) != kaartDrie.charAt(charToTest) && kaartEen.charAt(charToTest) != kaartDrie.charAt(charToTest))) {
          testCharResult = true;
        } else {
          return false;
        }
      }
    }
  }
  return testCharResult;
}

// Functie om het einde van het spel te bepalen en dan het eindscherm te tonen.
void checkEindeSpel() {       
  if (!spelAfgelopen) {
    for (int xPos = 0; xPos < xVelden; xPos++) {
      for (int yPos = 0; yPos < YVELDEN; yPos++) {
        if (speelVeld[xPos][yPos] != LEGE_KAART) {
          aantalKaartenOpSpeelveld++;
        }
      }
    }
  }

  if (aantalSetsSpeelveld == 0 && ((kaartenToegevoegd == true || kaartenInSpel.length <= 0) || aantalKaartenOpSpeelveld == 0)) {    
    spelActief = false;
    spelAfgelopen = true;     
  }
}

void movieEvent(Movie movie) {
  movie.read(); 
}

void maakSpelScherm() {
  surface.setSize(xVelden * KAART_BREEDTE, YVELDEN * KAART_HOOGTE + SCOREBORD_HOOGTE);
}

void resetSpelVariabelen() { 
  scoreOpgeslagen = false;
  spelAfgelopen = false;
  kaartenInSpel = new String[0];
  geselecteerdeKaarten = new String[0];
  setsLijst = new ArrayList<String[]>();
  speelVeld = new String[xVelden][YVELDEN];
  speelVeldKleur = new color[xVelden][YVELDEN];  
  speelkaartBorderKleur = new color[xVelden][YVELDEN];
  resetSpeelveldAchtergrond();
  naam = "";
  scoreSpelerEen = 0;
  aantalHintKaarten = 2;
  kaartenToegevoegd = false;
  restartTijd = millis() / 1000.0;
}

void laadMediaBestanden() {
  setLogo = loadImage(setImgBestandsLocatie);  
  setSpelregels = loadImage(SET_SPELREGELS_BESTANDS_LOCATIE);
  airwolfLogo = loadImage(AIRWOLF_LOGO_BESTANDS_LOCATIE);
  achtergrondVideo = new Movie(this, achtergrondVideoBestandsLocatie);  
  rainbowVideo = new Movie(this, achtergrondVideoBestandsLocatie);
  airwolfVideo = new Movie(this, AIRWOLF_VIDEO_BESTANDS_LOCATIE);
}