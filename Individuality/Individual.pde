public enum GeneType {
    SIDES(0),
    RAD(1),
    SPIN_RATE(2),
    RED(3),
    BLUE(4),
    GREEN(5);

  private int pos;

  private GeneType(int pos) {
    this.pos = pos;
  }

  public int getPos() {
    return pos;
  }
}

public class Individual {

  Gene chromosome[];
  RegularGon phenotype;
  float fitness;

  public Individual(Boolean randInd) {
    chromosome = new Gene[6];

    if (randInd) {
      chromosome[GeneType.SIDES.getPos()] = new Gene((int)(log(32) / log(2)), 0);
      chromosome[GeneType.RAD.getPos()] = new Gene((int)(log(64) / log(2)), 0);
      chromosome[GeneType.SPIN_RATE.getPos()] = new Gene((int)(log(16) / log(2)), 0);
      chromosome[GeneType.RED.getPos()] = new Gene((int)(log(256) / log(2)), 0);
      chromosome[GeneType.BLUE.getPos()] = new Gene((int)(log(256) / log(2)), 0);
      chromosome[GeneType.GREEN.getPos()] = new Gene((int)(log(256) / log(2)), 0);
    }
    setPhenotype();
  }

  void setPhenotype() {
    color c = color(chromosome[GeneType.RED.getPos()].getValue(), chromosome[GeneType.GREEN.getPos()].getValue(), chromosome[GeneType.BLUE.getPos()].getValue());
    phenotype = new RegularGon(chromosome[GeneType.SIDES.getPos()].getValue(), chromosome[GeneType.RAD.getPos()].getValue(),
      chromosome[GeneType.SPIN_RATE.getPos()].getValue()-7.0, c);
  }

  void mutate(float rate) {
    for (int i = 0; i < chromosome.length; i++) {
      if (random(1) < rate) {
        chromosome[i].mutate();
      }
    }
    setPhenotype();
  }

  String toString() {
    String res = "";
    for (Gene i : chromosome) {
      res += i.toString() + '\n';
    }
    return res;
  }

  void display(int x, int y, boolean showFitness) {
    phenotype.display(x, y);
    if (showFitness) {
      text(fitness, x, y);
    }
  }
}
