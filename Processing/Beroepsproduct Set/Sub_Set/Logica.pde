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


// Functie voor in draw() om continu de achtergrond van de kaarten te kleuren.
void kleurCellen() {  
  for (int x = 0; x < xVelden; x++) {
    for (int y = 0; y < yVelden; y++) {
      fill(speelVeldKleur[x][y]);
      rect((width/xVelden) * x, ((height - hoogteScorebord)/yVelden) * y, width/xVelden, (height - hoogteScorebord)/yVelden);
    }
  }
}


void eindeSpel() {  
  int aantalKaartenOpSpeelveld = 0;
  for (int x = 0 ; x < xVelden ; x++) {
    for (int y = 0 ; y < yVelden ; y++) {
      if (speelVeld[x][y] != defaultKaart){
        aantalKaartenOpSpeelveld++;
      }
    }
  }
  
  if (aantalSetsSpeelveld == 0 && ((voegXVeldToe == true || kaartenArrayList.size() <= 0) || aantalKaartenOpSpeelveld == 0)) {
    
    if (tijd == 0) {
      tijd = millis() / 1000;
    }
    
    println("EINDE SPEL");
    background(zwart);
    fill(groen, 175);
    rect((width / 7) * 1, ((height - hoogteScorebord) / 7) * 2, (width / 7) * 5, ((height - hoogteScorebord) / 7) * 3);
    fill(zwart);
    textFont(createFont("Verdana Bold", hoogteScorebord));
    textAlign(CENTER);
    fill(wit, 225);
    text("EINDE", (width / 2), (height - hoogteScorebord / 2) / 1.9);
    
    textAlign(LEFT);
    fill(wit, 200);
    textFont(fontVerdanaBold); 
    text("Score: ", 0 + (width * 0.25), height - (hoogteScorebord / 9) * 7); 
    text("Tijd: ", 0 + (width * 0.25), height - (hoogteScorebord / 9) * 5);  
    //text("Kaarten over: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 3);
  
    text(nf(scoreSpelerEen), 0 + (width * 0.35), height - (hoogteScorebord / 9) * 7); 
    text(tijd, 0 + (width * 0.35), height - (hoogteScorebord / 9) * 5);  
    //text(kaartenArrayList.size(), 0 + (width * 0.3), height - (hoogteScorebord / 9) * 3);
    
    fill(zwart);
    rect((width / 8) * 4, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));  
    
    fill(wit);
    text("Restart", (width / 8) * 4.1, height - (hoogteScorebord / 5) * 3.25);                 
  }
}