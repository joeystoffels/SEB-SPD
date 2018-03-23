//Functie om het startscherm weer te geven.
void toonStartScherm() {  
  tekenLogo();
  tekenKnoppenStartScherm();  
}

void tekenLogo() {
  // TODO aanpassen
  fill(ZWART, 150);
  stroke(WIT, 200);
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
  int knopPosX = width / 4;
  int knopBreedte = width / 2;
  int knopHoogte = int(height / 10 * gridPosHoogte);
  int knopDikte = 25;
         
  if(mouseX > knopPosX && mouseX < knopPosX + knopBreedte &&
     mouseY > knopHoogte && mouseY < knopHoogte + knopDikte){        
    fill(WIT, 50);
  } else {
    fill(ZWART, 150);
  }

  strokeWeight(2);
  rect(knopPosX, knopHoogte, knopPosX * 2, knopDikte, rectHoekRadius);
  tekenTextInKnopStartScherm(text, gridPosHoogte);
}

void tekenTextInKnopStartScherm(String text, float gridPosHoogte) {
  int textPositieX = width / 2;
  float textPositieY = height / 10 * gridPosHoogte;
  int textPositieOffset = 18;
  
  fill(WIT);
  textFont(verdanaBold(15));
  textAlign(CENTER);
  text(text, textPositieX, textPositieY + textPositieOffset);
  textAlign(LEFT);
}