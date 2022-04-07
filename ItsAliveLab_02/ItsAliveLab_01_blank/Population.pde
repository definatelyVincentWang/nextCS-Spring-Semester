class Population {
  float totalFitness,mutationRate;
  Individual[] pop;
  
  public Population(int popSize) {
    pop = new Individual[popSize];
    mutationRate = 0.05;
    totalFitness = 0;
  }
  
  public void randomPop() {
    for (int i = 0; i < pop.length; i++) {
      pop[i] = new Individual(true);
    }
  }
  
  public void drawPopGrid(int cols, int rows, int gridSize, int offset, boolean showFitness) {
    for (int i = 0; i < pop.length; i++) {
      int x = i / rows;
      int y = i % rows;
      pop[i].display(gridSize * (x) + gridSize / 2 + offset, gridSize * (y) + gridSize / 2 + offset, showFitness);
    }
  }
  
  public Individual get(int index) {
    return pop[index];  
  }
  
  void setFitness(Individual target) {
    totalFitness = 0;
    for (int i = 0; i < pop.length; i++) {
      pop[i].setFitness(target);
      totalFitness += pop[i].fitness;
    }
  }
}
