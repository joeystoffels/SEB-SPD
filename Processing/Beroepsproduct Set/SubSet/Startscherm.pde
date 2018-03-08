//Functie om het startscherm weer te geven.
void tekenStartScherm() {  
  fill(zwart, 150);
  stroke(wit, 200);
  strokeWeight(3);
  rect(width * 0.1, height * 0.075, width * 0.8, height * 0.5, 25);
  image(setImg, width * 0.15, height * 0.1, width * 0.75, height * 0.45);
  tekenKnoppenStartScherm();
  //strokeWeight(2);
}

void tekenKnoppenStartScherm() {
  tekenKnopStartScherm(7);
  tekenKnopStartScherm(7.5);
  tekenKnopStartScherm(9);  

  tekenTextInKnopStartScherm("SubSet - 3 variaties", 7);
  tekenTextInKnopStartScherm("Set - 4 variaties", 7.5);
  tekenTextInKnopStartScherm("Highscores verwijderen", 9);
}

void tekenKnopStartScherm(float gridPosHoogte) {
  fill(zwart, 150);
  strokeWeight(2);
  rect(width / 4, height / 10 * gridPosHoogte, width / 2, 25, 25);
}

void tekenTextInKnopStartScherm(String text, float gridPosHoogte) {
  fill(wit);
  textFont(verdanaBold(15));
  textAlign(CENTER);
  text(text, width / 2, height / 10 * gridPosHoogte + 19);
  textAlign(LEFT);
}