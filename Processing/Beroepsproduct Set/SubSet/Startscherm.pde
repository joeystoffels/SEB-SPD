//Functie om het startscherm weer te geven.
void startScherm() {
  background(zwart);
  image(img, width * 0.15, height * 0.02, width * 0.75, height * 0.6);
  tekenKnoppenStartScherm();
}


void tekenKnoppenStartScherm() {
  fill(zwart);
  stroke(wit, 150);
  tekenKnop(7);
  tekenKnop(7.75);
  tekenKnop(9);
  
  fill(wit);
  textFont(verdanaBold(15));
  textAlign(CENTER);
  tekenTextInKnop("SubSet - 3 variaties", 7);
  tekenTextInKnop("Set - 4 variaties", 7.75);
  tekenTextInKnop("Highscores verwijderen", 9);  
  textAlign(LEFT);
}


void tekenKnop(float gridPosHoogte) {
  rect(width / 4 * 1, height / 10 * gridPosHoogte, width / 2, 25);
}


void tekenTextInKnop(String text, float gridPosHoogte) {
    text(text, width / 2, height / 10 * gridPosHoogte + 19);
}