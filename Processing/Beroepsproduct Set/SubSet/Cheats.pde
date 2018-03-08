void activeerThema(String theme) {
  switch (theme) {
    case "Airwolf": 
      airwolfThemeActive = !airwolfThemeActive;
      if (airwolfThemeActive && !ateamThemeActive) {
        airwolfVideo.play();
        airwolfVideo.speed(1);
        airwolfVideo.volume(0);      
        airwolfMuziek.play();
        image(airwolfVideo, 0, 0, width, height);  
      } else {
        airwolfVideo.stop();
        airwolfMuziek.stop();
      }
      break;
    case "Ateam":
      ateamThemeActive = !ateamThemeActive;
      if (ateamThemeActive && !airwolfThemeActive) {
        ateamVideo.play();
        ateamVideo.speed(1);
        ateamVideo.volume(0);      
        ateamMuziek.play();
        image(ateamVideo, 0, 0, width, height); 
      } else {
        ateamVideo.stop();
        ateamMuziek.stop();
      }
      break;
  }
  println("Custom theme activated: - " + theme + "!");
}

void customTheme() {  
  if (airwolfThemeActive) {  
    tint(255, 225);
    image(airwolfVideo, 0, 0, width, height); 
    noTint();
  } 
  
  if (ateamThemeActive) {
    tint(255, 225);
    image(ateamVideo, 0, 0, width, height); 
    noTint();
  }  
}  

void activeerEindeSpel() {
  println("F12 Pressed - Skipping to end game!");
  startSchermActive = false;
  spelAfgelopen = true;
  aantalKaartenOpSpeelveld = 0;
  aantalSetsSpeelveld = 0;  
}