class point {
  int x;
  int y;
  
  boolean compareTo(point other) {
    if (x == other.x && y == other.y) {
      return true;
    }
    return false;
  }
}
// note start must be the leftmost point
boolean intersects(point p1start, point p1end, point p2start, point p2end) {
  int slope1 = abs(p1start.y - p1end.y) / abs(p1end.y - p1start.y);
  boolean[][] graph = new boolean[width][height];
  while (!p1start.compareTo(p1end)) {
    graph[p1start.x][p2start.y] = true;
    p1start.x += slope1;
    p1start.y += slope1;
  }
  return true;
}
