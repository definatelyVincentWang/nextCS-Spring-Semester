class TriangleGon extends PathShape {
  public TriangleGon(int bx, int by, int bw, int bh) {
    super(bx,by,bw,bh);
  }
    void setCentroid() {
        int totX = 0;
        int totY = 0;
        for (int i = 0; i < xs.size(); i++) {
            totX += xs.get(i);
            totY += ys.get(i);
        }
        centroid[0] = totX / xs.size();
        centroid[1] = totY / ys.size();
    }

    void addPoint(int x, int y) {
        if (xs.size() >= 3) {
            return;
        }
        xs.append(x);
        ys.append(y);
        setCentroid();
    }
}
