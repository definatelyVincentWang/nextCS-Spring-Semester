import processing.video.*;
Capture video;

void setup(){
  size(640,480);
  video = new Capture(this,Capture.list()[0]);
  video.start();
  frameRate(60);
}

void draw(){
  image(video,0,0);
  video.resize(640,480);
  video.read();
}
