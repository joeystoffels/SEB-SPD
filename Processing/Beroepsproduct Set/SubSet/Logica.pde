// Generieke helper functie voor het verifieren van een set.
boolean verifieerSet(String kaartEen, String kaartTwee, String kaartDrie, int charToCheck) {
  if (!(kaartEen == standaardKaart || kaartTwee == standaardKaart || kaartDrie == standaardKaart)) {
    if ((kaartEen.charAt(charToCheck) == kaartTwee.charAt(charToCheck) && kaartTwee.charAt(charToCheck) == kaartDrie.charAt(charToCheck) && kaartEen.charAt(charToCheck) == kaartDrie.charAt(charToCheck))  || 
      (kaartEen.charAt(charToCheck) != kaartTwee.charAt(charToCheck) && kaartTwee.charAt(charToCheck) != kaartDrie.charAt(charToCheck) && kaartEen.charAt(charToCheck) != kaartDrie.charAt(charToCheck))) {
      //println(kaartEen, kaartTwee, kaartDrie, charToCheck, aantalSetsSpeelveld); 
      return true;
    }
  }
  return false;
}


// Maak de stapel kaarten adhv. het aantal geconfigureerde variaties.
void maakKaartenInSpel(int aantalVariaties) {
  String[] aantal = {"1", "2", "3"};
  String[] kleur = {"r", "g", "b"}; // rood, groen, blauw
  String[] figuur = {"d", "r", "e"}; // driehoek, rechthoek, ellipse
  String[] vulling = {"l", "h", "v"}; // leeg, half, vol

  if (kaartenInSpel.size() > 0) {
   kaartenInSpel = new ArrayList<String>(); 
  }

  if (aantalVariaties == 3) {
    for (int a = 0; a < aantal.length; a++) {
      for (int f = 0; f < figuur.length; f++) {
        for (int k = 0; k < kleur.length; k++) {
          kaartenInSpel.add(aantal[a] + figuur[f] + kleur[k] + "0"); // "0" als default waarde zodat verifySet() goed uitgevoerd wordt
        }
      }
    }
  }
  
  if (aantalVariaties == 4) {
    for (int a = 0; a < aantal.length; a++) {
      for (int f = 0; f < figuur.length; f++) {
        for (int k = 0; k < kleur.length; k++) {
          for (int v = 0; v < vulling.length; v++) {
            kaartenInSpel.add(aantal[a] + figuur[f] + kleur[k] + vulling[v]);
          }
        }
      }
    }
  }

  // Console logging.
  println("Kaartenstapel: " + kaartenInSpel);
  println("Totaal aantal kaarten: " + kaartenInSpel.size());
}


// Functie om een set te checken.
void controleerSet() {    
  String kaartEen = geselecteerdeKaarten.get(0);
  String kaartTwee = geselecteerdeKaarten.get(1);
  String kaartDrie = geselecteerdeKaarten.get(2);

  if (verifieerSet(kaartEen, kaartTwee, kaartDrie, 0) &&
    verifieerSet(kaartEen, kaartTwee, kaartDrie, 1) &&
    verifieerSet(kaartEen, kaartTwee, kaartDrie, 2) && 
    verifieerSet(kaartEen, kaartTwee, kaartDrie, 3)) {
    println("SET: " + kaartEen + " " + kaartTwee + " " + kaartDrie);
    scoreSpelerEen++;
    verwijderKaart(kaartEen);
    verwijderKaart(kaartTwee);
    verwijderKaart(kaartDrie);
    geselecteerdeKaarten.removeAll(geselecteerdeKaarten);  
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
void kleurAchtergrondKaarten() {  
  for (int x = 0; x < xVelden; x++) {
    for (int y = 0; y < yVelden; y++) {
      fill(speelVeldKleur[x][y]);
      rect((width/xVelden) * x, ((height - hoogteScorebord)/yVelden) * y, width/xVelden, (height - hoogteScorebord)/yVelden);
    }
  }
}