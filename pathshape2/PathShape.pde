class PathShape {
  int bX, bY, bW, bH; 
  IntList xs, ys;
  final color border = color(0);
  final color fill = color(226,88,34);
  final color centroidColor = color(155,155,155);
  int[] centroid = new int[2];
  float area;
  
  public PathShape(int bX, int bY, int bW, int bH) {
    this.xs = new IntList();
    this.ys = new IntList();
 
    area = 0.0;
    
    this.bX = bX;
    this.bY = bY;
    this.bW = bW;
    this.bH = bH;
  }
  
  void addPoint(int x, int y) {
    xs.append(x);
    ys.append(y);
    setArea();
    setCentroid();
  }
  
  void display() {
    fill(fill);
    stroke(border);
    beginShape();
    for (int i = 0; i < xs.size(); i++) {
      vertex(xs.get(i), ys.get(i));
    }
    if (xs.size() > 0) {
      vertex(xs.get(0), ys.get(0));
    }
    endShape();
    fill(centroidColor);
    circle(centroid[0],centroid[1],5);
  }
  
  void setCentroid() {
    int sumX = 0;
    int sumY = 0;
    for (int i = 0; i < xs.size(); i++) {
      int nextX = xs.get(0);
      int nextY = ys.get(0);
      if (i < xs.size() - 1) {
        nextX = xs.get(i+1);
        nextY = ys.get(i+1);
      }
      int x = xs.get(i);
      int y = ys.get(i);
      int mp = x * nextY - nextX * y;
      sumX += (x + nextX) * mp;
      sumY += (y + nextY) * mp;
    }
    centroid[0] = int(sumX / (6 * area));
    centroid[1] = int(sumY / (6 * area));
  }
  
  void setArea() {
    float sum = 0;
    for (int i = 0; i < xs.size(); i++) {
      int nextX = xs.get(0);
      int nextY = ys.get(0);
      if (i < xs.size() - 1) {
        nextX = xs.get(i+1);
        nextY = ys.get(i+1);
      }
      int x = xs.get(i);
      int y = ys.get(i);
      sum += x * nextY - nextX * y;
    }
    area = sum / 2;
  }
}
