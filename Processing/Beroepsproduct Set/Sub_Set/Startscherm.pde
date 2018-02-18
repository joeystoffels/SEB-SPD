void startScherm() {
  background(zwart);
  
  textFont(createFont("Verdana Bold", 15));
  image(img, 50, 25, 500, 312);
  
  fill(zwart);
  stroke(wit, 150);
  rect(150, 375, 300, 25);
  rect(150, 425, 300, 25);
  
  fill(wit);
  text("SubSet - 3 variaties", 216, 394);
  text("Set - 4 variaties", 236, 443);
}