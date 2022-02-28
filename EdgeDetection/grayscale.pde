int[] grayscale() {
  if (!camera) {
    img.loadPixels();
  } else {
    video.loadPixels();
  }
  loadPixels();
  int[] grayScale = new int[pixels.length];
  for (int i = 0; i < pixels.length; i++) {
    if (camera) {
      grayScale[i] =  (int)(red(video.pixels[i]) + green(video.pixels[i]) + blue(video.pixels[i])) / 3;
    } else {
      grayScale[i] =  (int)(red(img.pixels[i]) + green(img.pixels[i]) + blue(img.pixels[i])) / 3;
    }
    if (camera) {
      pixels[i] = color(grayScale[i]);
    } else {
      pixels[i] = color(grayScale[i]);
    }
  }
  updatePixels();
  return grayScale;
}
