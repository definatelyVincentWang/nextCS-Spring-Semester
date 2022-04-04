class TriangleGon extends PathShape {

  int MIN_AREA = 300;
  int MAX_RANDOM_POINTS = 3; //Overrides pathshape

  TriangleGon(int bX, int bY, int bW, int bH) {
    super(bX, bY, bW, bH);
  }

/* ============================
  randomize TriangleGon with the following constraints:

  The TriangleGon should fit inside the bounding box (bX, bY, bW, bH)
  You should create the TriangleGon by generating 3 random points that
  satisfy the condition above.
  ============================ */
  //randomize() Should just work for free!
  //since we inherit PathShape randomize(), 
  //and have overridden MAX_RANDOM_POINTS to 3

/* ============================
  A valid TriangleGon has an area of at least 300.
  Returns true/false based on that condition.
  ============================ */
  boolean isValid() {
    /*if (xs.size() < 3 || ys.size() < 3) return false;
    int x1 = xs.get(0);
    int x2 = xs.get(1);
    int x3 = xs.get(2);
    int y1 = xs.get(0);
    int y2 = xs.get(1);
    int y3 = xs.get(2);
    return (1/2) * abs(x1 * (y2-y3) + x2 * (y3-y1) + x3 * (y1-y2)) >= 300;
    */
    return area >= 300;
  }

  void addPoint(int x, int y) {
    if (xs.size() < 3) {
      super.addPoint(x, y);
    }
    setArea();
  }

  void setCentroid() {
    int sumX = 0;
    int sumY = 0;

    for (int i=0; i < xs.size(); i++) {
      sumX+= xs.get(i);
      sumY+= ys.get(i);
    }
    centroid[0] = sumX / 3;
    centroid[1] = sumY / 3;
  }//setCentroid

  void setArea() {
    if (xs.size() == 3) {
     area = xs.get(0) * (ys.get(1)-ys.get(2));
     area+= xs.get(1) * (ys.get(2)-ys.get(0));
     area+= xs.get(2) * (ys.get(0)-ys.get(1));
     area = abs(area / 2);
   }
   else {
     area = 0;
   }
  }//setArea
  
}//TriangleGon
