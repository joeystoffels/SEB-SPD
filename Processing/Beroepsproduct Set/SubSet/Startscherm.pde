//Functie om het startscherm weer te geven.
void toonStartScherm() {  
  tekenLogoAchtergrond();
  tekenLogo(setLogo);  
  tekenKnoppenStartScherm();
}

void tekenLogoAchtergrond() {  
  final float ACHTERGROND_LOGO_X_POS = width * 0.2;
  final float ACHTERGROND_LOGO_Y_POS = height * 0.075;
  final float ACHTERGROND_LOGO_BREEDTE = width * 0.6;
  final float ACHTERGROND_LOGO_HOOGTE = height * 0.5;

  fill(ZWART, 150);
  stroke(WIT, 200);
  strokeWeight(3);
  rect(ACHTERGROND_LOGO_X_POS, ACHTERGROND_LOGO_Y_POS, ACHTERGROND_LOGO_BREEDTE, ACHTERGROND_LOGO_HOOGTE, RECT_HOEK_RADIUS);
}

void tekenLogo(PImage logo) {
  final float LOGO_X_POS = width * 0.3;
  final float LOGO_Y_POS = height * 0.1;
  final float LOGO_BREEDTE = width * 0.4;
  final float LOGO_HOOGTE = height * 0.45; 

  tint(255, 185);
  image(logo, LOGO_X_POS, LOGO_Y_POS, LOGO_BREEDTE, LOGO_HOOGTE);
  noTint();
}

void tekenKnoppenStartScherm() {
  tekenKnopStartScherm("SubSet - 3 variaties", 7);
  tekenKnopStartScherm("Set - 4 variaties", 7.5);
  tekenKnopStartScherm("Spelregels", 8.5);
  tekenKnopStartScherm("Highscores verwijderen", 9);
}

void tekenKnopStartScherm(String text, float gridPosHoogte) {  
  final int KNOP_POS_X = width / 4;
  final int KNOP_BREEDTE = width / 2;
  final int KNOP_HOOGTE = int(height / 10 * gridPosHoogte);
  final int KNOP_DIKTE = 25;

  if (mouseX > KNOP_POS_X && mouseX < KNOP_POS_X + KNOP_BREEDTE &&
    mouseY > KNOP_HOOGTE && mouseY < KNOP_HOOGTE + KNOP_DIKTE) {        
    fill(WIT, 50);
  } else {
    fill(ZWART, 150);
  }

  strokeWeight(2);
  rect(KNOP_POS_X, KNOP_HOOGTE, KNOP_POS_X * 2, KNOP_DIKTE, RECT_HOEK_RADIUS);
  tekenTextInKnopStartScherm(text, gridPosHoogte);
}

void tekenTextInKnopStartScherm(String text, float gridPosHoogte) {
  final int TEXT_X_POS = width / 2;
  final float TEXT_Y_POS = height / 10 * gridPosHoogte;
  final int TEXT_OFFSET_Y = 18;

  fill(WIT);
  textFont(verdanaBold(15));
  textAlign(CENTER);
  text(text, TEXT_X_POS, TEXT_Y_POS + TEXT_OFFSET_Y);
  textAlign(LEFT);
}