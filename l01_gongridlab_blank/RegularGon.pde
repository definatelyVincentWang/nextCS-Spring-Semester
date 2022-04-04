class RegularGon extends PathShape {
  int MAX_SIDES = 9;
  int numSides;
  int radius;

  RegularGon(int bX, int bY, int bW, int bH, int radius) {
    super(bX, bY, bW, bH);
    centroid[0] = bX + bW/2;
    centroid[1] = bY + bH/2;
    numSides = (int)random(3,MAX_SIDES);
    this.radius = radius;
    randomize();
    generateRegularPolygon();
  }




/* ============================
  randomize this RegularGon with the following constraints:

  It should have at least 3 sides and at most MAX_SIDES sides.
  The RegularGon should be centered in and fit inside of
  the bounding box (bX, bY, bW, bH)
  The radius of the RegularGon should be at least 5.
  ============================ */
  void randomize() {
    numSides = (int)random(3,MAX_SIDES);
    radius = (int)random(5,MAX_SIZE / 2);
  }
  
/* ============================
  A RegularGon if generated appropriately is automatically valid
  (i.e. we create it centered, correct radius, etc)
  ============================ */
  boolean isValid() {
    return xs.size() > 0; //Done!
  }//isValid
  

  void generateRegularPolygon() {
    centroid[0] = bX + bW/2;
    centroid[1] = bY + bH/2;
    
    float theta = radians(360.0 / numSides); //use float to fix rounding issues
    for (int n=0; n < numSides; n++) {
      int x = int(radius * cos(n * theta)) + centroid[0];
      int y = int(radius * sin(n * theta)) + centroid[1];
      xs.append(x);
      ys.append(y);
    }
  }//generateRegularPolygon

}//RegularGon
