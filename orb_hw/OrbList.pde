class OrbList {
  OrbNode front;
  OrbNode back;

  public OrbList() {
    front = null;
    back = null;
  }

  public OrbList(int x, int y) {
    front = new OrbNode(x, y);
  }

  public void display() {
    OrbNode cur = front;
    if (cur == null) {
      return;
    }
    cur.display();
    while (cur.next != null) {
      cur = cur.next;
      cur.display();
    }
  }
  void addFront(OrbNode o) {
    if (front == null) {
      front = o;
      back = front;
      return;
    }
    OrbNode tmp = front;
    o.next = tmp;
    tmp.prev = o;
    front = o;
  }

  void addFront(int x, int y, boolean fixed) {
    OrbNode tmp = new OrbNode(x, y);;
    if (fixed) {
      tmp = new FixedOrbNode(x,y);
    }
    addFront(tmp);
  }

  void append(int x, int y, boolean fixed) {
    OrbNode tmp = new OrbNode(x, y);
    if (fixed) {
      tmp = new FixedOrbNode(x,y);
    }
    append(tmp);
  }

  void append(OrbNode o) {
    OrbNode b = back;
    b.next = o;
    o.prev = b;
    back = o;
  }

  void run() {
    OrbNode cur = front;
    if (cur == null) {
      return;
    }
    cur.run();
    while (cur.next != null) {
      cur = cur.next;
      cur.run();
    }
  }

  void applySprings() {
    OrbNode cur = front;
    if (cur == null) {
      return;
    }
    cur.applySpringForce();
    while (cur.next != null) {
      cur = cur.next;
      cur.applySpringForce();
    }
  }

  void clear() {
    front = null;
    back = null;
  }

  void applyForce(int pos, PVector force) {
    int curPos = 0;
    OrbNode cur = front;
    while (curPos != pos && cur.next != null) {
      cur = cur.next;
      pos++;
    }
    cur.applyForce(force);
  }
  
  void applyExternalForce(PVector f) {
    OrbNode cur = front;
    if (cur == null) {
      return;
    }
    cur.applyForce(f);
    while (cur.next != null) {
      cur = cur.next;
      cur.applyForce(f);
    }
    cur.applyForce(f);
  }
}
