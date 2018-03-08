// Muisklik functie om kaarten te kunnen selecteren.
// Deze functie triggert het checken op een set na het selecteren van 3 kaarten.
void mousePressed() {  
  println("CLICKED " + mouseX, mouseY);

  if (startSchermActive) { // Wanneer startScherm actief is zijn onderstaande knoppen beschikbaar.
    if (mouseX > width / 4 && mouseX < width / 4 * 3) {

      // Click Subset - 3 variations button
      if (mouseY > height / 10 * 7 && mouseY < height / 10 * 7 + 25) {
        
        startSchermActive = false;
        spelActief = true;       
        aantalVariaties = 3;
        setupSpel();
      }

      // Click Set - 4 variations button
      if (mouseY > height / 10 * 7.5 && mouseY < height / 10 * 7.5 + 25) {

        spelActief = true;                
        startSchermActive = false;
        aantalVariaties = 4;
        setupSpel();
      }      

      // Click clear highscores button 
      if (mouseY > height / 10 * 9 && mouseY < height / 10 * 9 + 25) {
        verwijderHighscores();
      }
    }
    return;
  }

  // return indien er buiten het speelveld geklikt is.
  if (mouseY > speelveldHoogte) { 
    if (mouseX > (width / 8) * 4 && mouseX < ((width / 8) * 4) + 100) {

      if (mouseY < (height - (scorebordHoogte / 5)) && mouseY > (height - (scorebordHoogte / 5))-(scorebordHoogte / 5)) { 
        println("Voeg kaarten toe");
        voegKaartenToe();
      }

      if (mouseY < (height - (scorebordHoogte / 5) * 3) && mouseY > (height - (scorebordHoogte / 5) * 3)-(scorebordHoogte / 5)) {      
        println("Geef hint");
        geefHint();
      }
    }

    if (mouseX > (width / 8) * 6 && mouseX < ((width / 8) * 6) + 100) {
      if (mouseY < (height - (scorebordHoogte / 5)) && mouseY > (height - (scorebordHoogte / 5))-(scorebordHoogte / 5)) {
        println("Beginscherm");
        spelActief = false;
        startSchermActive = true;
        herstart();
      } 

      if (mouseY < (height - (scorebordHoogte / 5) * 3) && mouseY > (height - (scorebordHoogte / 5) * 3)-(scorebordHoogte / 5)) {
        println("Opnieuw");
        spelActief = true;
        startSchermActive = false;
        herstart();
      }
    }
    return;
  }  

  // Wanneer er niet op het scorebord is geklikt wanneer het startScherm niet actief is, is er op een kaart geklikt.
  selecteerKaart();
}

void selecteerKaart() {
  int xVeld = mouseX / kaartBreedte;
  int yVeld = mouseY / kaartHoogte;
  String kaart = "";

  try {
    kaart = speelVeld[xVeld][yVeld];
  } 
  catch (IndexOutOfBoundsException e) {
    println("IndexOutOfBoundsException, mouseX = " + mouseX + ", mouseY = " + mouseY + ".");
    return;
  }

  if (kaart == legeKaart) {
    return;
  }

  if (geselecteerdeKaarten.contains(kaart)) {
    speelVeldKleur[xVeld][yVeld] = zwart;
    geselecteerdeKaarten.remove(kaart);
  } else {  
    if (!geselecteerdeKaarten.contains(kaart) && geselecteerdeKaarten.size() < 3) {
      geselecteerdeKaarten.add(speelVeld[xVeld][yVeld]);
      speelVeldKleur[xVeld][yVeld] = color(wit, 225);
      if (geselecteerdeKaarten.size() == 3) { 
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
      activeerThema("Ateam");
      break;
    case 122:
      activeerThema("Airwolf");
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
  
  resetSpeelveldAchtergrond();

  for (int x = 0; x < speelVeldKleur.length; x++) {
    for (int y = 0; y < speelVeldKleur[x].length; y++) {
      if (java.util.Arrays.asList(set).contains(speelVeld[x][y]) && counter < 2) {         
        speelVeldKleur[x][y] = color(randomKleurRood, randomKleurGeel, randomKleurBlauw, 125);
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

    String[][] nieuwSpeelVeld = new String[xVelden][yVelden];
    color[][] nieuwSpeelVeldKleur = new color[xVelden][yVelden];

    for (int x = 0; x < xVelden-1; x++) {
      for (int y = 0; y < yVelden; y++) {
        nieuwSpeelVeld[x][y] = speelVeld[x][y];
        nieuwSpeelVeldKleur[x][y] = speelVeldKleur[x][y];
      }
    }

    for (int x = 0; x < xVelden; x++) {
      for (int y = 0; y < yVelden; y++) {
        if (nieuwSpeelVeld[x][y] == null || Integer.valueOf(nieuwSpeelVeldKleur[x][y]) == null) {
          nieuwSpeelVeld[x][y] = legeKaart;
          nieuwSpeelVeldKleur[x][y] = zwart;
        }
      }
    }

    speelVeld = nieuwSpeelVeld;
    speelVeldKleur = nieuwSpeelVeldKleur;  
    maakSpeelveld();
    aantalSetsSpeelveld();
    kaartenToegevoegd = true;
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

  for (int charToTest = 0; charToTest < aantalVariaties; charToTest++) {
    if (!(kaartEen == legeKaart || kaartTwee == legeKaart || kaartDrie == legeKaart)) {
      if ((kaartEen.charAt(charToTest) == kaartTwee.charAt(charToTest) && kaartTwee.charAt(charToTest) == kaartDrie.charAt(charToTest)) || 
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