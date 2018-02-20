void startScherm() {
  background(zwart);
  
  textFont(createFont("Verdana Bold", 12));
  
  createHighscoreLijst();
  image(img, 260, 60, 325, 235);

  
  fill(zwart);
  stroke(wit, 150);
  rect(150, 375, 300, 25);
  rect(150, 425, 300, 25);
  
  textFont(createFont("Verdana Bold", 15));
  fill(wit);
  text("SubSet - 3 variaties", 216, 394);
  text("Set - 4 variaties", 236, 443);
}