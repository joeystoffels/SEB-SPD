void setAchtergrondVideo(String theme) {  
  switch (theme) {
    case "Airwolf": 
      airwolfThemeActive = !airwolfThemeActive;
      if (airwolfThemeActive) {
        achtergrondVideo.stop();
        airwolfVideo.play();
        airwolfVideo.volume(0);      
        airwolfMuziek.play();
        image(airwolfVideo, 0, 0, width, height);  
      } else {
        achtergrondVideo.play();
        airwolfVideo.stop();
        airwolfMuziek.stop();
      }
      break;        
  }
  println(theme + " theme " + (airwolfThemeActive ? "activated" : "deactivated") + "!");
}

void toonAchtergrondVideo() {  
  if (airwolfThemeActive) {  
    tint(255, 225);
    image(airwolfVideo, 0, 0, width, height); 
    noTint();
  } else {
    tint(255, 175);
    image(achtergrondVideo, 0, 0, width, height); 
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