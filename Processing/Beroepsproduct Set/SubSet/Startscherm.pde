//Functie om het startscherm weer te geven.
void toonStartScherm() {  
  tekenLogo();
  tekenKnoppenStartScherm();  
}

void tekenLogo() {
  fill(zwart, 150);
  stroke(wit, 200);
  strokeWeight(3);
  rect(width * 0.2, height * 0.075, width * 0.6, height * 0.5, 25);
  tint(255, 185);
  image(setLogo, width * 0.3, height * 0.1, width * 0.4, height * 0.45);
  noTint();
}

void tekenKnoppenStartScherm() {
  tekenKnopStartScherm("SubSet - 3 variaties", 7);
  tekenKnopStartScherm("Set - 4 variaties", 7.5);
  tekenKnopStartScherm("Spelregels", 8.5);
  tekenKnopStartScherm("Highscores verwijderen", 9);  
}

void tekenKnopStartScherm(String text, float gridPosHoogte) {
  if(mouseX > width / 4 && mouseX < (width / 4 + width / 2) &&
     mouseY > height / 10 * gridPosHoogte && mouseY < height / 10 * gridPosHoogte + 25){ 
    fill(wit, 50);
  } else {
    fill(zwart, 150);
  }

  strokeWeight(2);
  rect(width / 4, height / 10 * gridPosHoogte, width / 2, 25, 25);
  tekenTextInKnopStartScherm(text, gridPosHoogte);
}

void tekenTextInKnopStartScherm(String text, float gridPosHoogte) {
  fill(wit);
  textFont(verdanaBold(15));
  textAlign(CENTER);
  text(text, width / 2, height / 10 * gridPosHoogte + 18);
  textAlign(LEFT);
}