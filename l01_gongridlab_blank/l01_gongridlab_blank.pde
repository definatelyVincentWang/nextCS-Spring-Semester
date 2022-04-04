int GRID_ROWS = 5;
int GRID_COLS = 5;
int POPULATION_SIZE = GRID_COLS * GRID_ROWS;

//A shape should always fit within a MAX_SIZE x MAX_SIZE square
int MAX_SIZE = 100;
//This allows us to account for the gridlines that will be drawn
int OFFSET = 1;


//Used when we need to check what kind of PathShape to use
int REGS = 0;
int TRIS = 1;
int PATHS = 2;

//Array of PathShapes to work with
PathShape population[];

void settings() {
  //size() can't be called in setup() if you want to use variables
  //settings allows it:  https://processing.org/reference/settings_.html
  size(GRID_COLS*MAX_SIZE + (GRID_COLS-1)*OFFSET,
    GRID_ROWS*MAX_SIZE + (GRID_ROWS-1)*OFFSET);
}
/* ============================
 ============================ */
void setup() {
  //size set in settings()
  background(255);
  population = new PathShape[POPULATION_SIZE];
  populate(REGS);
}//setup

/* ============================
 ============================ */
void draw() {
  background(255);
  drawGrid();
  drawPop();
}

/* ============================
 Loop through the population array and call
 display on each object.
 ============================ */
void drawPop() {
  for (PathShape p : population) {
    if (p == null) continue;
    p.display();
  }
}//drawPop

/* ============================
 Fills the population array by calling
 makeShape with the correct parameters.
 ============================ */
void populate(int type) {
  stroke(0);
  for (int i=0; i < GRID_COLS; i++) {
    for (int j=0; j < GRID_ROWS; j++) {
      int x = i * (MAX_SIZE + OFFSET);
      int y = j * (MAX_SIZE + OFFSET);
      population[i * GRID_COLS + j] = makeShape(type,x,y);
    }
  }
}//populate

/* ============================
 Calls the correct shape making and isValid
 method for the given shape type and position.
 
 The coordinates should represent the top-left
 corener of a MAX_SIZE x MAX_SIZE square that
 will contain the shape.
 
 RegularGons made according to the instructions for
 makeRegularGon are always valid.
 ============================ */
PathShape makeShape(int type, int left_x, int top_y) {
  PathShape ps = null;
  boolean valid = false;
  while (!valid) {
    if (type == REGS) {
      ps = new RegularGon(left_x, top_y, MAX_SIZE, MAX_SIZE, (int)random(5, MAX_SIZE));
    } else if (type == TRIS) {
      ps = new TriangleGon(left_x, top_y, MAX_SIZE, MAX_SIZE);
      ps.randomize();
    } else {
      ps = new PathShape(left_x, top_y, MAX_SIZE, MAX_SIZE);
    }
    valid = ps.isValid();
  }
  return ps;
}


/* ============================
 ============================ */
void drawGrid() {
  stroke(0);
  for (int i=1; i < GRID_COLS; i++) {
    int x = i * (MAX_SIZE + OFFSET);
    line(x, 0, x, height-1);
  }//row dividers

  for (int i=1; i < GRID_ROWS; i++) {
    int y = i * (MAX_SIZE + OFFSET);
    line(0, y, width-1, y);
  }//column dividers
}//drawGrid


void keyPressed() {
  if (key == 'r') {
    populate(REGS);
  } else if (key == 't') {
    populate(TRIS);
  } else if (key == 'p') {
    populate(PATHS);
  } else if (key == ' ') {
    saveFrame("l01_.png");
  }
}
