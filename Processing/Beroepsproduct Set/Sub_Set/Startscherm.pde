void startScherm() {
  background(zwart);
  
  textFont(createFont("Verdana Bold", 15));
  //image(img, 50, 25, 500, 312);
  
  text("Naam ", 25, 25);
  text("Score", 150, 25);
  text("Tijd", 225, 25);
  
  String[] namen = loadStrings("highscores.txt");
  for (int i = 0 ; i < namen.length ; i++) {
    
    String[] line = split(namen[i], ',');
    text((i + 1) + ": " + line[0], 25, 50 + 25 * i);
    text(line[1], 150, 50 + 25 * i);
    text(line[2], 225, 50 + 25 * i);
  }
  
  fill(zwart);
  stroke(wit, 150);
  rect(150, 375, 300, 25);
  rect(150, 425, 300, 25);
  
  fill(wit);
  text("SubSet - 3 variaties", 216, 394);
  text("Set - 4 variaties", 236, 443);
  text("Naam: " + naam, 400, 25);
}

void keyPressed() {
 
  if (key==BACKSPACE) { 
  naam = naam.substring(0, naam.length() -1);
  } else
  naam = naam + key;
}