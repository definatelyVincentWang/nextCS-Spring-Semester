int DELETE_MODE = 0;
int GROW_MODE = 1;
int SHRINK_MODE = 2;
int ADD_FIXED_MODE = 3;
int clickMode;

boolean moving;
OrbList slinky;
float GRAVITY = 0.2;
PVector g;

void setup() {
  size(500, 500);
  clickMode = DELETE_MODE;
  moving = false;
  g = new PVector(0, GRAVITY);
  makeSlinky(5, 250);
}//setup
void draw() {
  background(255);
  if (moving) {
    slinky.applyExternalForce(g);
    slinky.applySprings();
    slinky.run();
  }
  slinky.display();
  displayMode();
}//draw

void makeSlinky(int numParts, int y) {
  slinky = new OrbList(50, y, 450, y);
  int dist = (450 - 50) / (numParts);
  for (int i = 1; i <= numParts; i++) {
    slinky.append(dist * i + 50, y, false);
  }
}//makeSlinky

void keyPressed() {
  println("FUCK YOU");
  if (key == ' ') {
    moving = !moving;
  }
  if (key == 'r') {
    makeSlinky(5,250);
  }
  if (key == 'm') {
    clickMode = (clickMode + 1) % (ADD_FIXED_MODE + 1);
  }
}//keyPressed

void mousePressed() {
  OrbNode node = slinky.selectNode(mouseX,mouseY);
  if (node != null) {
    if (clickMode == DELETE_MODE) {
      slinky.removeNode(node);
    } else if (clickMode == GROW_MODE) {
      node.osize++;
    } else if (clickMode == SHRINK_MODE) {
      node.osize--;
    }
  } else {
    boolean isFixed = clickMode == ADD_FIXED_MODE;
    if (mouseX > width / 2) {
      if (slinky.back.previous == null) {
        slinky.append(250,350,isFixed);
        return;
      }
      slinky.append((int)slinky.back.previous.position.x - 25, 350, isFixed);
    } else {
      if (slinky.front.next == null) {
        slinky.append(250,350,isFixed);
        return;
      }
      slinky.addFront((int)slinky.front.next.position.x + 25, 150, isFixed);
    }
  }
}//mousePressed
void displayMode() {
  String message = "DELETE_MODE";
  if (clickMode == GROW_MODE) {
    message = "GROW MODE";
  }
  else if (clickMode == SHRINK_MODE) {
    message = "SHRINK MODE";
  }
  else if (clickMode == ADD_FIXED_MODE) {
    message = "ADD FIXED MODE";
  }
  fill(0);
  textSize(20);
  text(message, 10, height-10);
}
