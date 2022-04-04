class PathShape {

  int MAX_RANDOM_POINTS = 10;
  //x, y point lists
  IntList xs;
  IntList ys;
  //bounding box for the shape
  int bX, bY, bW, bH;

  int centroid[];
  float area;

  color inside;
  color border;

  PathShape(int bX, int bY, int bW, int bH) {
    this.bX = bX;
    this.bY = bY;
    this.bW = bW;
    this.bH = bH;
    xs = new IntList();
    ys = new IntList();
    inside = color(155);
    //inside = color(int(random(256)), int(random(256)), int(random(256)));
    border = color(0);
    centroid = new int[2];
    area = 0;
    
    randomize();
  }//constructor


/* ============================
  randomize this PathShape with the following constraints:

  The PathShape should fit inside a single MAX_SIZE x MAX_SIZE square
  and have at most MAX_POINTS vertices.
  You should create the PathShape by generating random points that
  satisfy the conditions above.
  note, randomize() may be called multiple times on the same PathShape,
  you should write code to handle this.
  ============================ */
  void randomize() {
    for (int i = 0; i < MAX_RANDOM_POINTS; i++) {
      addPoint((int)random(bX,bX + bW),(int)random(bY,bY + bH));
    }
  }//random PathShape


/* ============================
  A valid PathShape is one where the centroid is within
  the bounding box (bX, bY, bW, bH)
  Returns true/false based on that condition.
  ============================ */
  boolean isValid() {
    for (int i = 0; i < xs.size(); i++) {
      if (!(xs.get(i) > bX && xs.get(i) < bX + bW &&ys.get(i) > bY && ys.get(i) < bY + bH)) {
        return false;
      }
    }
    return true;
  }//isValid

  void display() {
    stroke(border);
    fill(inside);

    beginShape();
    for ( int i = 0; i < xs.size(); i++ ) {
      vertex( xs.get(i), ys.get(i) );
    }
    endShape(CLOSE);

    noStroke();
    fill(0, 0, 255);
    circle(centroid[0], centroid[1], 5);

  }//display

  void setCentroid() {
    int sumX = 0;
    int sumY = 0;
    for (int i=0; i < xs.size(); i++ ) {
      int p0 = i;
      int p1 = (i + 1) % xs.size(); // % is "modulo", gives the remainder
      sumX += (xs.get(p0) + xs.get(p1)) * ((xs.get(p0) * ys.get(p1)) - (xs.get(p1) * ys.get(p0)));
      sumY += (ys.get(p0) + ys.get(p1)) * ((xs.get(p0) * ys.get(p1)) - (xs.get(p1) * ys.get(p0)));
    }
    setArea();
    centroid[0] = int( (1 / (6 * area)) * sumX );
    centroid[1] = int( (1 / (6 * area)) * sumY );
  }//setCent

  void setArea() {
    area = 0;
    for ( int i=0; i < xs.size(); i++) {
      int p0 = i;
      int p1 = (i + 1) % xs.size(); // % is "modulo", gives the remainder
      area += (xs.get(p0) * ys.get(p1)) - (xs.get(p1) * ys.get(p0));
    }
    area = area * 0.5;
  }//setArea

  void addPoint(int x, int y) {
    xs.append(x);
    ys.append(y);

    setCentroid();
  }//addPoint


}//class PathShape
