PathShape shape;
RegularGon regular;
TriangleGon tr;

void setup() {
  size(400,400);
  shape = new PathShape(0,0,0,0);
  regular = new RegularGon(0,0,20,30, 1000000,100);
  tr = new TriangleGon(0,0,0,0);
}

void draw() {
  background(200);
  shape.display();
  regular.display();
  tr.display();
}

void mousePressed() {
  shape.addPoint(mouseX,mouseY);
}

void keyPressed() {
  if (key == ' ') {
    shape.xs = new IntList();
    shape.ys = new IntList();
    shape.centroid = new int[2];
  }
}
