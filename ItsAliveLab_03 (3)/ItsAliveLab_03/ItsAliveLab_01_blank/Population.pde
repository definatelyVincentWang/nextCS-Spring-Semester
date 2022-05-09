class Population {
  float totalFitness,mutationRate;
  Individual[] pop;
  
  public Population(int popSize) {
    pop = new Individual[popSize];
    mutationRate = .05;
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

  public Population matingSeason() {
    Population p = new Population(pop.length);
    p.pop[0] = pop[0];
    p.mutationRate = mutationRate;
    for (int i = 1; i < p.pop.length; i++) {
      if (i == getBestIndex()) {
        p.pop[i] = pop[i];
        continue;
      }
      Individual p1 = select();
      Individual p2 = select();
      Individual child = p1.mate(p2);
      child.mutate(mutationRate);
      p.pop[i] = child;
    }
    return p;
  }

  Individual select() {
    return pop[rouletteSelection()];
  }

  private int rouletteSelection() {
    float r = random(totalFitness-pop[0].fitness);
    float runningFitness = 0;
    for (int i = 1; i < pop.length; i++) {
      runningFitness += pop[i].fitness;
      if (r < runningFitness) {
        return i;
      }
    }
    return pop.length - 1;
  }
  
  int getBestIndex() {
    float bestFitness = 0;
    int bestPos = 0;
    for (int i = 1; i < pop.length; i++) {
      pop[i].setFitness(pop[0]);
      bestPos = max(bestFitness,pop[i].fitness) == bestFitness ? bestPos : i;
      bestFitness = max(bestFitness,pop[i].fitness);
    }
    return bestPos;
  }
  
  float getBestFitness() {
    float bestFitness = 0;
    for (int i = 1; i < pop.length; i++) {
      pop[i].setFitness(pop[0]);
      bestFitness = max(pop[i].fitness, bestFitness);
    }
    return bestFitness;
  }
  
  float getAvgFitness() {
    setFitness(pop[0]);
    return totalFitness / (pop.length - 1.);
  }
  
  void drawHighlight(int cols, int rows, int gridSize, int offset, int index, color c) {
    noFill();
    stroke(c);
    strokeWeight(5);
    int i = getBestIndex();
    int x = i / rows;
    int y = i % rows;
    square(gridSize * x + offset * 2, gridSize * y + offset * 2,gridSize);
    strokeWeight(1);
  }
}
