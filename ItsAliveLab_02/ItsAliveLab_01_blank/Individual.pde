class Individual {

  /*
    Note on the type modifiers used here:
    final: Value cannot be changed after initialization
    static: Value is not attached to a specific instance
            To reference a static variable outside of
            this class use: Individual.<variable name>
            i.e. Indivudal.CHROMOSOME_LENGTH
  */
  static final int CHROMOSOME_LENGTH = 6;
  static final int SIDES_GENE_LENGTH = 5;
  static final int SIZE_GENE_LENGTH = 6;
  static final int SPIN_GENE_LENGTH = 4;
  static final int COLOR_GENE_LENGTH = 8;

  static final int SIDES_IND = 0;
  static final int SIZE_IND = 1;
  static final int SPIN_IND = 2;
  static final int RED_IND = 3;
  static final int GREEN_IND = 4;
  static final int BLUE_IND = 5;

  RegularGon phenotype;
  Gene[] chromosome;
  float fitness;


  Individual(boolean random) {

    chromosome = new Gene[CHROMOSOME_LENGTH];

    if (random) {
      chromosome[SIDES_IND] = new Gene(SIDES_GENE_LENGTH);
      chromosome[SIZE_IND] = new Gene(SIZE_GENE_LENGTH);
      chromosome[SPIN_IND] = new Gene(SPIN_GENE_LENGTH);
      chromosome[RED_IND] = new Gene(COLOR_GENE_LENGTH);
      chromosome[GREEN_IND] = new Gene(COLOR_GENE_LENGTH);
      chromosome[BLUE_IND] = new Gene(COLOR_GENE_LENGTH);

      setPhenotype();
    }
  }//constructor

  void setPhenotype() {
    int sides = chromosome[SIDES_IND].getValue();
    int siz = chromosome[SIZE_IND].getValue();
    float spin = chromosome[SPIN_IND].getValue() - 7;
    color c = color(chromosome[RED_IND].getValue(), chromosome[GREEN_IND].getValue(), chromosome[BLUE_IND].getValue());
    phenotype = new RegularGon(sides, siz, spin, c);
  }

  /*==========================
    Create a new Individual object based on "mating" the
    calling and parameter objects.

    Child should inherit genes from both parents with crossover:
    Randomly select a number of genes to select from
    one parent, copy those into the chromosome of the
    new, "child" Individual. Then copy the remaining
    Genes from the other parent.

    Do not always start from the same parent. The
    "first" parent should be assigned randomly.
    
    Remember, there is a Gene construtor that takes a Gene object
    and creates a copy. Use it.
    ==========================*/
  Individual mate(Individual partner) {
    Individual child = new Individual(true);
    for (int i = 0; i < chromosome.length; i++) {
      child.chromosome[i] = new Gene(chromosome[i].genotype.length);
      child.chromosome[i].genotype = (int)random(2) == 1 ? copyOf(chromosome[i].genotype) : copyOf(partner.chromosome[i].genotype);
    }
    return child;
  }//mate
  
  int[] copyOf(int[] array) {
    int[] copy = new int[array.length];
    for (int i = 0; i < array.length; i++) {
      copy[i] = array[i];
    }
    return copy;
  }

  /*==========================
    Set the fitness based on how close the calling
    object is to the parameter.

    Larger values should mean more fit. You can base this
    calculation on either the gene values, or on the bits of the genotypes,
    though the values may be simpler to work with.
    ==========================*/
  void setFitness(Individual target) {
    fitness = 0;
    for (int i = 0; i < chromosome.length; i++) {
      fitness += abs(chromosome[i].getValue() - target.chromosome[i].getValue());
    }
    if (fitness != 0) {
      fitness = 1 / fitness;
    } else {
      
      fitness = 1;
    }
  }//setFitness

  void mutate(float rate) {
    for (int g=0; g < CHROMOSOME_LENGTH; g++) {
      if (random(1) < rate) {
        chromosome[g].mutate();
        setPhenotype();
      }
    }
  }//mutate

  void display(int x, int y, boolean showFitness) {
    phenotype.display(x, y);
    if (showFitness) {

      //println(fitness);
      textSize(15);
      fill(0);
      textAlign(CENTER);
      text(fitness, x, y);
    }
  }//display()

  String toString() {
    String s = "<Individual:\n";
    for (int i=0; i<CHROMOSOME_LENGTH; i++) {
      s+= "  " + chromosome[i] + "\n";
    }
    s+= "  fitness: " + fitness + ">";
    return s;
  }//toString()

}//Individual
