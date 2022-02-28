/* ===================
 The goal of this lab is to write a steganography
 encoding/decoding program.
 This program should encode a scret message within the blue
 value of randomly selected pixels.
 Pixels that contain part of the message will have a red
 value of 255.
 Any pixels that naturally have a red value of 255 will
 change to have a red value of 254.
 To test your decoding function, secret.png has been
 provided. When successfully decoded, you should get
 "hi everybody!"
 Once you know decoding is working, then work on encode,
 and use decode to test your work, then modify the
 keyPressed method to load a normal image.
 =================== */
PImage art;

void setup() {
  size(256, 256);
  art = loadImage("secret.png");
  art.loadPixels();
  image(art, 0, 0);
}

void draw() {
  image(art, 0, 0);
}

void keyPressed() {
  if (key == 'r') {
    //orginal cat image, no secret message
    art = loadImage("cat.jpg");
  }
  if (key == 'e') {
    art = encode(art, "hi everybody!");
    image(art, 0, 0);
    saveFrame("data/secret.png");
  }
  if (key == 'd') {
    println(decode(art));
  }
}//keyPressed

/* ===================
 This function will take an image with a secret message encoded
 via encode, and return the secret message as a String.
 You can concatenate chars with Strings by using +=
 on a String variable. (e.g. message+= 'a')
 =================== */
String decode(PImage img) {
  String message = "";
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    if (red(img.pixels[i]) == 255) {
      message += (char)blue(img.pixels[i]);
    }
  }
  return message;
}


/* ===================
 This function will return an array of randomly chosen integers used
 to help encode our secret message.
 The returned array should contain numSecret random values in the range
 [0, numPixels].
 The random values should be in strcictly increasing order.
 =================== */
int[] getSecretPixels(int numSecrets, int numPixels) {
  int[] secretPixels = new int[ numSecrets ];
  for (int i = 0; i < numSecrets; i++) {
    secretPixels[i] = (int)random(0, numPixels);
  }
  secretPixels = sortArray(0, secretPixels.length-1, secretPixels);
  for (int i = 0; i < secretPixels.length; i++) {
    while (binarySearch(secretPixels[i],0,secretPixels.length-1,secretPixels) != -1) {
      secretPixels[i] = (int)random(0, numPixels);
    }
  }
  return secretPixels;
}

int binarySearch(int num, int start, int end, int[] array) {
  if (start < end) {
    return -1;
  }
  
  int middle = start + (end-start) / 2;
  if (array[middle] == num) {
    return middle;
  } else if (array[middle] < num) {
    start = middle + 1;
  } else if (array[middle] > num) {
    end = middle - 1;
  }
  return binarySearch(num,start,end,array);
}

int[] sortArray(int start, int end, int[] array) {
  if (start < end) {
    int split = (start + end)/2;
    return merge(sortArray(start, split, array), sortArray(split + 1, end, array));
  }
  return new int[] {array[start]};
}

int[] merge(int[] arrayOne, int[] arrayTwo) {
  int[] array = new int [arrayOne.length + arrayTwo.length];
  int onePos = 0;
  int twoPos = 0;
  int pos = 0;
  while (onePos < arrayOne.length && twoPos < arrayTwo.length) {
    if (arrayOne[onePos] < arrayTwo[twoPos]) {
      array[pos] = arrayOne[onePos];
      onePos++;
      pos++;
    } else {
      array[pos] = arrayTwo[twoPos];
      twoPos++;
      pos++;
    }
  }
  while (onePos < arrayOne.length) {
    array[pos] = arrayOne[onePos];
    onePos++;
    pos++;
  }
  while (twoPos < arrayTwo.length) {
    array[pos] = arrayTwo[twoPos];
    twoPos++;
    pos++;
  }
  return array;
}


/* ===================
 This function will return a new PImage that encodes secret in the
 blue value of randomly chosen pixels.
 Pixels that contain encoded chars should have a red value of 255,
 a green value the same as the original image, and a blue value of
 the next charater in message.
 Any pixels in the original image with a red value of 255 should
 become pixels with the same green and blue values, and a red value
 of 254.
 The indices of the encoded pixels will be randomly generated
 by getSecretPixels
 secret.charAt(i) will return the character of secret at index i.
 =================== */
PImage encode(PImage img, String secret) {
  PImage tmp = new PImage(img.width, img.height);
  tmp.loadPixels();

  int[] secretPixels = getSecretPixels(secret.length(), img.pixels.length);
  for (int i = 0; i < img.pixels.length; i++) {
    tmp.pixels[i] = color(min((int)red(img.pixels[i]), 254),green(img.pixels[i]),blue(img.pixels[i]));
  }
  for (int i = 0; i < secretPixels.length; i++) {
    tmp.pixels[secretPixels[i]] = color(255, 
                          green(tmp.pixels[i]), 
                          secret.charAt(i));
  }
  tmp.updatePixels();
  return tmp;
}//encode
