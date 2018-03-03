//Functie om het startscherm weer te geven.
void startScherm() {
  background(zwart);
  image(img, width * 0.15, height * 0.02, width * 0.75, height * 0.6);
  tekenKnoppenStartScherm();
}


void tekenKnoppenStartScherm() {
  tekenKnopStartScherm(7);
  tekenKnopStartScherm(7.75);
  tekenKnopStartScherm(9);  

  tekenTextInKnopStartScherm("SubSet - 3 variaties", 7);
  tekenTextInKnopStartScherm("Set - 4 variaties", 7.75);
  tekenTextInKnopStartScherm("Highscores verwijderen", 9);    
}


void tekenKnopStartScherm(float gridPosHoogte) {
  fill(zwart);
  stroke(wit, 150);
  rect(width / 4 * 1, height / 10 * gridPosHoogte, width / 2, 25);  
}


void tekenTextInKnopStartScherm(String text, float gridPosHoogte) {
  fill(wit);
  textFont(verdanaBold(15));
  textAlign(CENTER);
  text(text, width / 2, height / 10 * gridPosHoogte + 19);
  textAlign(LEFT);
}