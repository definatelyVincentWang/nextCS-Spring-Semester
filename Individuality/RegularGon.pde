class RegularGon extends PathShape {
  int MAX_SIDES = 20;
  int numSides;
  int gonLength;

  //RegularGon(int lx, int ty, int sw) {
  //  super(lx, ty, sw, sw);
  //  numSides = 0;
  //  gonLength = 0;
  //}

  RegularGon(int cx, int cy, int sides, int length) {
    centroid[0] = cx;
    centroid[1] = cy;
    numSides = sides;
    gonLength = length;
    leftX = centroid[0] - gonLength;
    topY = centroid[1] - gonLength;
    shapeWidth = gonLength;
    shapeHeight = gonLength;

    generateRegularPolygon();
  }//PathShape

  RegularGon(int sides, int length, float rSpeed, color c) {
    this(0, 0, sides, length);
    rotationSpeed = rSpeed;
    inside = c;
  }//PathShape

  boolean isValid() {
    return xs.size() > 0;
  }//isValid

  void randomize() {
    centroid[0] = leftX + shapeWidth/2;
    centroid[1] = topY+ shapeHeight/2;
    numSides = int(random(3, MAX_SIDES+1));

    gonLength = int(random(5, shapeWidth/2));
    generateRegularPolygon();
  }

  void generateRegularPolygon() {
    if (numSides > 0) {
      float theta = radians(360 / numSides);
      for (int n=0; n < numSides; n++) {
        float x = gonLength * cos(n * theta) + centroid[0];
        float y = gonLength * sin(n * theta) + centroid[1];
        xs.append(x);
        ys.append(y);
      }
    }
  }//generateRegularPolygon
}//RegularGon
