public class Gene {
    private int genotype[];
    private int offset;

    public Gene(int len, int offset) {
        this.offset = offset;
        genotype = new int[len];
        for (int i = 0; i < len; i++) genotype[i] = (int)random(0,2);
    }

    public Gene (Gene other) {
        genotype = new int[other.genotype.length];
        arrayCopy(genotype, other.genotype);
    }

    public int getValue() {
        int val = 0;
        for (int i = genotype.length - 1; i >= 0; i--) {
            val += genotype[i] * Math.pow(2,genotype.length - (i + 1));
        }
        return val + offset;
    }
    void mutate() {
        int i = (int)random(0,genotype.length);
        genotype[i] = genotype[i] == 1 ? 0 : 1;
    }
    String toString() {
        String val = "BE->";
        for (int i = 0; i < genotype.length; i++) {
            val += genotype[i];
        }
        val += " " + (getValue() + offset);
        return val;
    }
}
