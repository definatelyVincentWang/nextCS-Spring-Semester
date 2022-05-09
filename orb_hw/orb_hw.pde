//Constants
static final float SPRING_LEN = 50; // "resting" length
static final float SPRING_CONST = 0.005;
static final float AIR_DAMPING = 0.995;

float GRAVITY = 0.1;

OrbNode orb1;
OrbNode orb2;
OrbNode orb3;
OrbNode orb4;

OrbList o;
PVector g;

boolean moving;



void setup() {
  size(800, 400);
  g = new PVector(0, GRAVITY);
  reset();
}//setup

void reset() {
  moving = false;
  o = new OrbList();
  o.addFront(width/2 + 100, height / 3, false);
  o.append(width / 2, height / 3 + 75, true);
  o.append(width / 2 -100, height / 3 +150, false);
  o.append(width / 2 +150, height / 3 + 225, false);
}//reset


void draw() {
  background(255);
  if (moving) {
    runAStep();
  }
  o.display();
}//draw

void runAStep() {
  o.applySprings();
  o.applyExternalForce(g);
  o.run();
}

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }
  if (key == 'h') {
    o.applyForce(1, new PVector(6, -6));
    o.applyForce(2, new PVector(6, -6));
    moving = true;
  }
  if (key == 'r') {
    reset();
  }
}//keyPressed
