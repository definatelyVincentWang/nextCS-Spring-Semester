int POP_COLS = 6;
int POP_ROWS = 5;
int OFFSET = 1;
int POP_SIZE = POP_COLS * POP_ROWS;
int GRID_SIZE = int(pow(2, Individual.SIZE_GENE_LENGTH+1) - 1);

Population pop;

void settings() {
  size(POP_COLS*GRID_SIZE + (POP_COLS-1)*OFFSET,
    POP_ROWS*GRID_SIZE + (POP_ROWS-1)*OFFSET);
}//settings
void setup() {
  pop = new Population(POP_SIZE);
  makePopulation();
}//setup

void draw() {
  background(255);
  pop.drawPopGrid(POP_COLS, POP_ROWS, GRID_SIZE, OFFSET, true);
  drawGrid();
}//draw

void keyPressed() {
  if (key == 'p') {
    makePopulation();
  }
  if (key == 'm') {
    pop = pop.matingSeason();
    pop.setFitness(pop.get(0));
    println(pop.totalFitness);
  }
}//keypressed


void makePopulation() {
  pop.randomPop();
  pop.setFitness(pop.get(0));
  println("Total fitness: ", pop.totalFitness);
}//makepopulation()


void drawGrid() {
  stroke(0);
  for (int i=1; i < POP_COLS; i++) {
    int x = i * (GRID_SIZE + OFFSET);
    line(x, 0, x, height-1);
  }//row dividers

  for (int i=1; i < POP_ROWS; i++) {
    int y = i * (GRID_SIZE + OFFSET);
    line(0, y, width-1, y);
  }//column dividers
}//drawgrid
