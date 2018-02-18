void startScherm() {
  background(zwart);
  
  textFont(createFont("Verdana Bold", 15));
  //text("SET", 200, 375); 
  image(img, 0, 15, 500, 312);
  
  fill(zwart);
  stroke(wit, 150);
  rect(100, 375, 300, 25);
  rect(100, 425, 300, 25);
  
  fill(wit);
  text("SubSet - 3 variaties", 166, 394);
  text("Set - 4 variaties", 186, 443);
}