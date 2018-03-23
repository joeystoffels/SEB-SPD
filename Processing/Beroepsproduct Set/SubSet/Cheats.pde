void setAchtergrondVideo(Movie video) {   
  achtergrondVideo.stop();
  achtergrondVideo = video;  
  achtergrondVideo.play();
}

void toonAchtergrondVideo() {   
  achtergrondVideo.play();
  achtergrondVideo.loop();
  image(achtergrondVideo, 0, 0, width, height);
}  

void activeerEindeSpel() {
  println("F12 Pressed - Skipping to end game!");
  startSchermActief = false;
  spelAfgelopen = true;
  aantalKaartenOpSpeelveld = 0;
  aantalSetsSpeelveld = 0;
}