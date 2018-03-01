//Functie om het startscherm weer te geven.
void startScherm() {
  background(zwart);
  
  textFont(createFont("Verdana Bold", 12));
  
  //maakHighscoreLijst();
  image(img, 100, 20, 425, 300);
  
  fill(zwart);
  stroke(wit, 150);
  rect(150, 350, 300, 25);
  rect(150, 390, 300, 25);
  rect(150, 450, 300, 25);
  
  textFont(createFont("Verdana Bold", 15));
  fill(wit);
  text("SubSet - 3 variaties", 216, 369);
  text("Set - 4 variaties", 236, 409);
  text("Highscores verwijderen", 200, 469);
}