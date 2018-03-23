// Functie voor het zetten van een achtergrond video.
void setAchtergrondVideo(Movie video) {   
  achtergrondVideo.stop();
  achtergrondVideo = video;  
  achtergrondVideo.play();
}

// Functie voor het tonten van de achtergrond video.
void toonAchtergrondVideo() {   
  achtergrondVideo.play();
  achtergrondVideo.loop();
  image(achtergrondVideo, 0, 0, width, height);
}  

// Functie om het einde van het spel te activeren.
void activeerEindeSpel() {
  println("F12 Pressed - Skipping to end game!");
  startSchermActief = false;
  spelAfgelopen = true;
  aantalKaartenOpSpeelveld = 0;
  aantalSetsSpeelveld = 0;
}