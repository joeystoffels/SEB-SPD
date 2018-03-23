// Event functie om een muisklik actie te verwerken. //<>// //<>//
void mousePressed() {  
  // DEBUG: println("CLICKED " + mouseX, mouseY);

  if (startSchermActief) {
    mousePressedStartscherm();
    return;
  } 

  if (spelregelsActief) {
    spelregelsActief = !spelregelsActief;
    startSchermActief = true;
    return;
  }

  if (!startSchermActief) {
    mousePressedSpeelscherm();
    return;
  }
}

// Functie om een muisklik op het startscherm af te handelen.
void mousePressedStartscherm() {
  final float BUTTON_STARTSCHERM_X_POS = width / 4;
  final float BUTTON_STARTSCHERM_BREEDTE = width / 4 * 3;
  final float SUBSET_BUTTON_Y_POS = height / 10 * 7;
  final float SUBSET_BUTTON_HOOGTE = height / 10 * 7 + 25;
  final float SET_BUTTON_Y_POS = height / 10 * 7.5;
  final float SET_BUTTON_HOOGTE = height / 10 * 7.5 + 25;
  final float SPELREGELS_BUTTON_Y_POS = height / 10 * 8.5;
  final float SPELREGELS_BUTTON_HOOGTE = height / 10 * 8.5 + 25;
  final float VERWIJDER_HIGHSCORE_BUTTON_Y_POS = height / 10 * 9;
  final float VERWIJDER_HIGHSCORE_BUTTON_HOOGTE = height / 10 * 9 + 25;

  if (mouseX > BUTTON_STARTSCHERM_X_POS && mouseX < BUTTON_STARTSCHERM_BREEDTE) {

    // Subset - 3 variaties button
    if (mouseY > SUBSET_BUTTON_Y_POS && mouseY < SUBSET_BUTTON_HOOGTE) {        
      startSchermActief = false;
      spelActief = true;       
      aantalVariaties = 3;
      xVelden = 3;
      schermBreedte = int(0.75 * schermBreedte);
      setupSpel();
    }

    // Set - 4 variaties button.
    if (mouseY > SET_BUTTON_Y_POS && mouseY < SET_BUTTON_HOOGTE) {
      spelActief = true;                
      startSchermActief = false;
      aantalVariaties = 4;
      setupSpel();
    }      

    // Speluitleg button.
    if (mouseY > SPELREGELS_BUTTON_Y_POS && mouseY < SPELREGELS_BUTTON_HOOGTE) {
      startSchermActief = false;
      spelregelsActief = true;
    }

    // Highscores verwijderen button.
    if (mouseY > VERWIJDER_HIGHSCORE_BUTTON_Y_POS && mouseY < VERWIJDER_HIGHSCORE_BUTTON_HOOGTE) {
      verwijderHighscores();
    }
    return;
  }
}

// Functie om een muisklik op het speelscherm af te handelen.
void mousePressedSpeelscherm() {
  final float TOP_BUTTON_SPEELSCHERM_X_POS = (width / 8) * 4;
  final float TOP_BUTTON_SPEELSCHERM_BREEDTE = (width / 8) * 4 + 100;
  final float VOEG_KAARTEN_TOE_BUTTON_Y_POS = height - (SCOREBORD_HOOGTE / 5);
  final float VOEG_KAARTEN_TOE_BUTTON_HOOGTE = height - (SCOREBORD_HOOGTE / 5)-(SCOREBORD_HOOGTE / 5);
  final float GEEF_HINT_BUTTON_Y_POS = height - (SCOREBORD_HOOGTE / 5) * 3;
  final float GEEF_HINT_BUTTON_BREEDTE = height - (SCOREBORD_HOOGTE / 5) * 3-(SCOREBORD_HOOGTE / 5);
  final float BOTTOM_BUTTON_SPEELSCHERM_X_POS = (width / 8) * 6;
  final float BOTTOM_BUTTON_SPEELSCHERM_BREEDTE = ((width / 8) * 6) + 100;
  final float BEGINSCHERM_BUTTON_Y_POS = height - (SCOREBORD_HOOGTE / 5);
  final float BEGINSCHERM_BUTTON_HOOGTE = height - (SCOREBORD_HOOGTE / 5)-(SCOREBORD_HOOGTE / 5);
  final float OPNIEUW_BUTTON_Y_POS = height - (SCOREBORD_HOOGTE / 5) * 3;
  final float OPNIEUW_BUTTON_HOOGTE = height - (SCOREBORD_HOOGTE / 5) * 3-(SCOREBORD_HOOGTE / 5);

  // Return indien er buiten het speelveld geklikt is.
  if (mouseY > SPEELVELD_HOOGTE) { 
    if (!spelAfgelopen) {

      // X positie van de knoppen in dit if-blok.
      if (mouseX > TOP_BUTTON_SPEELSCHERM_X_POS && mouseX < TOP_BUTTON_SPEELSCHERM_BREEDTE) {

        // Voeg kaarten toe button.
        if (mouseY < VOEG_KAARTEN_TOE_BUTTON_Y_POS && mouseY > VOEG_KAARTEN_TOE_BUTTON_HOOGTE) { 
          println("Voeg kaarten toe");
          voegKaartenToe();
        }

        // Hint button.
        if (mouseY < GEEF_HINT_BUTTON_Y_POS && mouseY > GEEF_HINT_BUTTON_BREEDTE) {      
          println("Geef hint");
          geefHint();
        }
      }
    }

    // X positie van de knoppen in dit if-blok.
    if (mouseX > BOTTOM_BUTTON_SPEELSCHERM_X_POS && mouseX < BOTTOM_BUTTON_SPEELSCHERM_BREEDTE) {

      // Beginscherm button.
      if (mouseY < BEGINSCHERM_BUTTON_Y_POS && mouseY > BEGINSCHERM_BUTTON_HOOGTE) {
        println("Beginscherm");
        spelActief = false;
        startSchermActief = true;
        xVelden = 4;
        setupSpel();
      } 

      // Opnieuw button.
      if (mouseY < OPNIEUW_BUTTON_Y_POS && mouseY > OPNIEUW_BUTTON_HOOGTE) {
        println("Opnieuw");
        spelActief = true;
        startSchermActief = false;
        xVelden = aantalVariaties;
        setupSpel();
      }
    }
    return;
  }

  // Wanneer er niet op het scorebord is geklikt wanneer het startScherm niet actief is, is er op een kaart geklikt.
  selecteerKaart();
}

// Functie om de kaart (de)selecteren waar de muis cursor zich op bevind.
void selecteerKaart() {
  int xVeld = mouseX / KAART_BREEDTE;
  int yVeld = mouseY / KAART_HOOGTE;
  String kaart = "";

  // 22-03-2018:
  // Het is mogelijk als er op enkele pixels geklikt wordt dat een IndexOutOfBoundsException optreed.
  // Tot nu toe afgevangen met een try-catch block en console melding.
  // TODO: Bug fixen.
  try {
    kaart = speelVeld[xVeld][yVeld];
  } 
  catch (IndexOutOfBoundsException e) {
    println("WARN: IndexOutOfBoundsException, mouseX = " + mouseX + ", mouseY = " + mouseY + ".");
    return;
  }

  if (kaart.equals(LEGE_KAART)) {
    return;
  }

  if (arrayContains(geselecteerdeKaarten, kaart)) {
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

// Event functie om een toets indruk actie te verwerken.
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

// Functie om keys met code te verwerken.
void keyPressedCoded() {
  switch(keyCode) {
  case 121: // F10 toets.
    aantalHintKaarten = aantalHintKaarten == 3 ? 2 : 3;
    println("Cheat: Hint " + aantalHintKaarten + " kaarten!");
    break;
  case 122: // F11 toets.
    if (airwolfThemeActive) {
      setAchtergrondVideo(rainbowVideo);
      setLogo = loadImage(setImgBestandsLocatie);
    } else {
      setAchtergrondVideo(airwolfVideo);        
      setLogo = airwolfLogo;
    }

    airwolfThemeActive = !airwolfThemeActive;      
    println("Cheat: Airwolf theme " + (airwolfThemeActive ? "activated" : "deactivated") + "!");
    break;
  case 123: // F12 toets.
    activeerEindeSpel();
    break;
  default: 
    return;
  }
}

// Functie om keys zonder code te verwerken.
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
    if (Character.isLetter(key) || Character.isDigit(key)) {
      setNaam(naam + key);
    }
  }
}

// Functie om een hint te geven door twee kaarten een andere borderkleur te geven.
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

// Functie voor het verifieren van een set.
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

// Functie om het einde van het spel te bepalen en te configureren.
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

// Functie voor het afspelen van een Movie bestand.
void movieEvent(Movie movie) {
  movie.read();
}

// Functie om het spelscherm in afmetingen te configureren.
void maakSpelScherm() {
  surface.setSize(xVelden * KAART_BREEDTE, YVELDEN * KAART_HOOGTE + SCOREBORD_HOOGTE);
}

// Functie om alle spelvariabelen te resetten.
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

// Functie om alle mediabestanden in te laden.
void laadMediaBestanden() {
  setLogo = loadImage(setImgBestandsLocatie);  
  setSpelregels = loadImage(SET_SPELREGELS_BESTANDS_LOCATIE);
  airwolfLogo = loadImage(AIRWOLF_LOGO_BESTANDS_LOCATIE);
  achtergrondVideo = new Movie(this, achtergrondVideoBestandsLocatie);  
  rainbowVideo = new Movie(this, achtergrondVideoBestandsLocatie);
  airwolfVideo = new Movie(this, AIRWOLF_VIDEO_BESTANDS_LOCATIE);
}

// Setup van het spel wanneer er een speltype gekozen is.
void setupSpel() {
  resetSpelVariabelen();
  maakSpelScherm(); 
  maakKaartenStapel();
  maakSpeelveld();    
  updateAantalSetsSpeelveld();
}