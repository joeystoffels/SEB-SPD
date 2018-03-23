// Functie om de spelregels te tonen.
void toonSpelregels() {
  final float SPELREGELS_ACHTERGROND_X_POS = width * 0.09;
  final float SPELREGELS_ACHTERGROND_Y_POS = SCHERM_HOOGTE * 0.21;
  final float SPELREGELS_ACHTERGROND_BREEDTE = width * 0.82;
  final float SPELREGELS_ACHTERGROND_HOOGTE = SCHERM_HOOGTE * 0.58;

  fill(ZWART, 150);
  stroke(WIT, 200);
  strokeWeight(3);
  rect(SPELREGELS_ACHTERGROND_X_POS, SPELREGELS_ACHTERGROND_Y_POS, SPELREGELS_ACHTERGROND_BREEDTE, SPELREGELS_ACHTERGROND_HOOGTE, RECT_HOEK_RADIUS);  

  final float SPELREGELS_IMG_X_POS = width * 0.14;
  final float SPELREGELS_IMG_Y_POS = SCHERM_HOOGTE * 0.25;
  final float SPELREGELS_IMG_BREEDTE = width * 0.72;
  final float SPELREGELS_IMG_HOOGTE = SCHERM_HOOGTE * 0.5;

  image(setSpelregels, SPELREGELS_IMG_X_POS, SPELREGELS_IMG_Y_POS, SPELREGELS_IMG_BREEDTE, SPELREGELS_IMG_HOOGTE);
  
  textAlign(CENTER);
  fill(WIT);
  text("Klik om terug te gaan!", width / 2, SCHERM_HOOGTE * 0.85);
  textAlign(LEFT);
}