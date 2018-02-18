// Aanmaken van het scorebord, de hoogte hiervan staat vast op 15% van de hoogte.
// TODO refactoren
void maakScorebord() {
  // Achtergrond verversen
  fill(zwart);
  rect(0, height, width, - hoogteScorebord);

  // Score weergeven, dubbele text velden voor betere allignment.
  fill(wit, 200);
  textFont(fontVerdanaBold); 
  text("Score: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 7); 
  text("Tijd: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 5);  
  text("Kaarten over: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 3);
  text("Aantal sets: ", 0 + (width * 0.05), height - (hoogteScorebord / 9) * 1);

  text(nf(scoreSpelerEen), 0 + (width * 0.3), height - (hoogteScorebord / 9) * 7); 
  text(millis()/1000, 0 + (width * 0.3), height - (hoogteScorebord / 9) * 5);  
  text(kaartenArrayList.size(), 0 + (width * 0.3), height - (hoogteScorebord / 9) * 3);
  text(aantalSetsSpeelveld, 0 + (width * 0.3), height - (hoogteScorebord / 9) * 1);
  
  // Knoppen toevoegen.
  // TODO text centreren in knop
  fill(zwart);
  rect((width / 8) * 4, height - (hoogteScorebord / 5), width / 6, - (hoogteScorebord / 5));  
  rect((width / 8) * 4, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));  
  rect((width / 8) * 6, height - (hoogteScorebord / 5), width / 6, - (hoogteScorebord / 5));  
  rect((width / 8) * 6, height - (hoogteScorebord / 5) * 3, width / 6, - (hoogteScorebord / 5));
  
  fill(wit);
  text("Hint", (width / 8) * 4.475, height - (hoogteScorebord / 5) * 1.25);
  text("Restart", (width / 8) * 4.34, height - (hoogteScorebord / 5) * 3.25);
  text("Voeg " + yVelden + " toe", (width / 8) * 6.225, height - (hoogteScorebord / 5) * 1.25);
  text("Knop", (width / 8) * 6.425, height - (hoogteScorebord / 5) * 3.25);
}


// Functie om de veldlijnen te tekenen.
void tekenVeldLijnen() {    
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


// Functie om figuur aan te maken.
// Hoogtefactor wijzigt ivm. positie van een, twee of drie figuren ten op zichte van elkaar op 1 kaart.
void createFiguur(String kaart, int xPositie, int yPositie) {  

  int aantal = Integer.parseInt(str(kaart.charAt(0)));
  char figuurChar = kaart.charAt(1);
  char kleurChar = kaart.charAt(2);
  char vullingChar = kaart.charAt(3);

  color kleur = (kleurChar == 'r' ? rood : (kleurChar == 'g' ? groen : blauw));
  int vulling = (vullingChar == 'l' ? 0 : (vullingChar == 'h' ? 100 : 255));
  String figuur = (figuurChar == 'r' ? "rechthoek" : (figuurChar == 'e' ? "ellipse" : "driehoek"));

  final float xGridOffset = xPositie*(width/xVelden);
  final float yGridOffset = yPositie*((height - hoogteScorebord)/yVelden);

  //Configuratie waarden voor de diverse figuren
  final float[][] ellipseConfig = { {4.0, 0, 0}, {3.0, 0, 0}, {5.0, 0, 0}, {2.0, 0, 0}, {4.0, 0, 0}, {6.0, 0, 0} };
  final float[][] rechthoekConfig = { {3.25, 0, 0}, {2.0, 0, 0}, {4.0, 0, 0}, {1.0, 0, 0}, {3.25, 0, 0}, {5.5, 0, 0} };
  final float[][] driehoekConfig = { {4.75, 3.25, 4.75}, {3.75, 2.25, 3.75}, {5.75, 4.25, 5.75}, {2.75, 1.25, 2.75}, {4.75, 3.25, 4.75}, {6.75, 5.25, 6.75} };

  float[][] config = (figuur == "rechthoek" ? rechthoekConfig : (figuur == "ellipse" ? ellipseConfig : driehoekConfig));

  final int forLoopHelperValue = aantal - (aantal == 3 ? 0 : 1);

  for (int y = forLoopHelperValue; y < aantal + forLoopHelperValue; y++) { 
    float yHoogteFactorEerste = config[y][0];
    float yHoogteFactorTweede = config[y][1];
    float yHoogteFactorDerde = config[y][2];    

    strokeWeight(2);
    stroke(kleur);
    fill(kleur, vulling);

    if (figuur == "driehoek") {
      triangle((kleinGridBreedte * 2.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorEerste) + yGridOffset, 
        (kleinGridBreedte * 4.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorTweede) + yGridOffset, 
        (kleinGridBreedte * 6.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorDerde) + yGridOffset);
    }
    if (figuur == "rechthoek") {
      rect((kleinGridBreedte * 2.1) + xGridOffset, (kleinGridHoogte * yHoogteFactorEerste) + yGridOffset, 
        (kleinGridBreedte * 4.0), (kleinGridHoogte * 1.5));
    }
    if (figuur == "ellipse") {
      ellipse((kleinGridBreedte * 4.0) + xGridOffset, (kleinGridHoogte * yHoogteFactorEerste) + yGridOffset, 
        (kleinGridBreedte * 4.0), (kleinGridHoogte * 1.5));
    }

    stroke(wit, 150);
  }
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