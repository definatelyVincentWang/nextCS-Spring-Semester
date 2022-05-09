class OrbNode {
  PVector pos; //position
  PVector vel; //velocity
  PVector nextAccel; //acceleration for the next tick
  float psize;

  color c;
  
  OrbNode prev;
  OrbNode next;

  public OrbNode(int x, int y) {
    pos = new PVector(x, y);
    vel = new PVector();
    nextAccel = new PVector();
    c = color(226, 88, 34);
    psize = 20;
    prev = null;
    next = null;
  }

  void display() {
    stroke(0);
    fill(c);
    circle(pos.x, pos.y, psize);
    if (next != null) {
      stroke(255,0,0);
      line(pos.x-5,pos.y,next.pos.x-5, next.pos.y);
    }
    if (prev != null) {
      stroke(0,255,0);
      line(pos.x+5,pos.y,prev.pos.x+5, prev.pos.y);
    }
  }
  void applyForce(PVector f) {
    nextAccel.add(f);
  }

  boolean checkHitXBound() {
    return psize/2 + pos.x > width || pos.x - psize/2 < 0;
  }

  boolean checkHitYBound() {
    return psize/2 + pos.y > height || pos.y - psize/2 < 0;
  }


  void run() {
    vel.mult(AIR_DAMPING);
    vel.add(nextAccel);
    if (checkHitXBound()) {
      vel.x = -vel.x;
    }
    if (checkHitYBound()) {
      vel.y = -vel.y;
    }
    pos.add(vel);
    nextAccel = new PVector();
  }
  void applySpringForce() {
    if (next != null) {
      applyForce(calculateSpringForce(next));
    }
    if (prev != null) {
      applyForce(calculateSpringForce(prev));
    }
  }
  PVector calculateSpringForce(OrbNode other) {
    float mag = -SPRING_CONST * ((pos.dist(other.pos)) - SPRING_LEN);
    PVector vect = new PVector(pos.x - other.pos.x, pos.y - other.pos.y);
    vect.setMag(mag);
    return vect;
  }
}
