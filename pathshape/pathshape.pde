class PathShape {
  IntList xs;
  IntList ys;
  color border;
  color fill;
  
  public PathShape(color border, color fill) {
    this.xs = new IntList();
    this.ys = new IntList();
    this.border = border;
    this.fill = fill;
  }
  
  void addPoint(int x, int y) {
    xs.append(x);
    ys.append(y);
  }
  
  void display() {
    fill(fill);
    stroke(border);
    beginShape();
    for (int i = 0; i < xs.size(); i++) {
      vertex(xs.get(i), ys.get(i));
    }
    endShape();
  }
}

PathShape shape;

color fill = color(226,88,34);
color stroke = color(0);

void setup() {
  size(400,400);
  shape = new PathShape(stroke, fill);
}

void draw() {
  background(200);
  shape.display();
}

void mousePressed() {
  shape.addPoint(mouseX,mouseY);
}
