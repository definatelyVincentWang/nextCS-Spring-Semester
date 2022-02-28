import processing.video.*;
Capture video;

boolean camera;

PImage img;
boolean imageLoaded;
HashMap<String, String> images;

public enum State {
  GRAYSCALE,VERTICAL,HORIZONTAL,OMNI, NONE
};

State state;

void setup() {
  size(400, 400);
  imageLoaded = false; 
  state = State.NONE;
  camera = false;
  
  video = new Capture(this,Capture.list()[0]);
  video.resize(width,height);

  images = new HashMap<String, String>();
  images.put("H", "house.jpg");
  images.put("C", "car.jpg");
  images.put("B", "butterfly.jpg");
}

void draw() {
  brc();
  String changed = brcChanged();
  
  camera = brcValue("Camera").equals("true") ? true : false;
  if (changed.equals("load")) {
    if (camera) {
      video.start();
    } else {
      img = loadImage("images/" + images.get(brcValue("file")));
      img.resize(width, height);
      image(img, 0, 0);
    }
    imageLoaded = true;
  }
  if (!imageLoaded) {
    return;
  }
  if (camera) {
    image(video,0,0);
    video.read();
  }
  int threshold = int(brcValue("threshold"));
  if (changed.equals("grayscale")) {
    state = State.GRAYSCALE;
  } else if (changed.equals("vertical")) {
    state = State.VERTICAL;
  } else if (changed.equals("horizontal")) {
    state = State.HORIZONTAL;
  } else if (changed.equals("omni")) {
    state = State.OMNI;
  }
  if (state == State.GRAYSCALE) {
    grayscale(); //<>//
  } else if (state == State.VERTICAL) {
    vertical(threshold);
  } else if (state == State.HORIZONTAL) {
    horizontal(threshold);
  } else if (state == State.OMNI) {
    omni(threshold);
  }
}

void vertical(int threshold) {
  loadPixels();
  int[] grayIntensity = grayscale();
  for (int i = 0; i < grayIntensity.length; i++) {
    if (i % width - 1 < 0 || i % width + 1 >= width) {
      grayIntensity[i] = 0;
      pixels[i] = color(grayIntensity[i]);
      continue;
    }
    if (abs(grayIntensity[i-1] - grayIntensity[i + 1]) > threshold) {
      pixels[i] = color(255);
    } else {
      pixels[i] = color(0);
    }
  }
  updatePixels();
}

void horizontal(int threshold) {
  loadPixels();
  int[] grayIntensity = grayscale();
  for (int i = 0; i < grayIntensity.length; i++) {
    if (i - width < 0 || i + width >= grayIntensity.length) {
      grayIntensity[i] = 0;
      pixels[i] = color(grayIntensity[i]);
      continue;
    }
    if (abs(grayIntensity[i-width] - grayIntensity[i+width]) > threshold) {
      pixels[i] = color(255);
    } else {
      pixels[i] = color(0);
    }
  }
  updatePixels();
}

void omni(int threshold) {
  loadPixels();
  int[] grayIntensity = grayscale();
  for (int i = 0; i < grayIntensity.length; i++) {
    if (i % width - 1 < 0 || i % width + 1 >= width || i - width < 0 || i + width >= grayIntensity.length) {
      grayIntensity[i] = 0;
      pixels[i] = color(grayIntensity[i]);
      continue;
    }
    if ((abs(grayIntensity[i-1] - grayIntensity[i+1]) > threshold) || (abs(grayIntensity[i-width] - grayIntensity[i+width]) > threshold)) {
      pixels[i] = color(255);
    } else {
      pixels[i] = color(0);
    }
  }
  updatePixels();
}
