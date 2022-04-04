Individual i0, i1, i2;

void setup() {
  size(600, 200);
  makeIndividuals();
}//setup

void draw() {
  background(255);

  //uncomment to display the Individuals
   i0.display(100, 100, true);
   i1.display(300, 100, true);
   i2.display(500, 100, true);

}//draw

/*==========================
  Initialize i0 and i1 as new randomly
  generated Individual objects.

  Set i2 to the result of mating i0 and i1.

  call setFitness(...) on i2, i1, and i0, comparing each to i0.

  Print out i0, i1 and i2.
  ==========================*/
void makeIndividuals() {
  i0 = new Individual(true);
  i1 = new Individual(true);
  i2 = i0.mate(i1);
  i2.setFitness(i0);
  i1.setFitness(i0);
  i0.setFitness(i0);

  println(i0);
  println(i1);
  println(i2);
}//makeIndividuals

void keyPressed() {
  if (key == 'p') {
    makeIndividuals();
  }
}//keyPressed
