void drawBase(char base, int x, int y, int sz) {
  noStroke();
  if (base == 'A') {
    fill(color(255, 121, 58));
  } else if (base == 'G') {
    fill(color(15, 32, 128));
  } else if (base == 'T') {
    fill(color(169, 90, 161));
  } else if (base == 'C') {
    fill(color(133, 192, 249));
  }
  square(x, y, sz);
  fill(255);
  textAlign(CENTER);
  text(base, x + sz / 2, y + sz / 2);
}
void drawStrand(String dna, int x, int y, int sz) {
  for (int i = 0; i < dna.length(); i++) {
    drawBase(dna.charAt(i), x, y, sz);
    x += sz;
  }
}

int findCodon(String strand, String codon) {
  for (int i = 0; i < strand.length() - 2; i++) {
    if (strand.substring(i, i+3).equals(codon)) {
      return i;
    }
  }
  return Integer.MAX_VALUE;
}

void strandMatch(String strand0, String strand1, int x, int y, int sz) {
  for (int i = 0; i < strand0.length(); i++) {
    if (!((strand0.charAt(i) == 'T' && strand1.charAt(i) == 'A') ||
      (strand0.charAt(i) == 'A' && strand1.charAt(i) == 'T') ||
      (strand0.charAt(i) == 'G' && strand1.charAt(i) == 'C') ||
      (strand0.charAt(i) == 'C' && strand1.charAt(i) == 'G'))) {
      noFill();
      stroke(255, 0, 0);
      strokeWeight(5);
      square(x + sz * i, y, sz);
      square(x + sz * i, y + sz, sz);
    }
  }
}

void strandCompare(String strand0, String strand1, int x, int y, int sz) {
  drawStrand(strand0, x, y, sz);
  drawStrand(strand1, x, y + sz, sz);
  strandMatch(strand0, strand1, x, y, sz);
}

void showProtein(String dna, int x, int y, int sz) {
  int start = findCodon(dna, "ATG");
  int end = min(findCodon(dna, "TAA"), min(findCodon(dna, "TGA"), findCodon(dna, "TAG")));
  drawStrand(dna, x, y, sz);
  for (int i = 0; i < 3; i++) {
    noStroke();
    fill(200);
    square(x + (start + i) * sz, y + sz, sz);
  }
  for (int i = 0; i < 3; i++) {
    noStroke();
    fill(255, 0, 0);
    square(x + (end + i) * sz, y + sz, sz);
  }
}

boolean containsProtein(String dna) {
  int start = findCodon(dna, "ATG");
  int end = min(findCodon(dna, "TAA"), min(findCodon(dna, "TGA"), findCodon(dna, "TAG")));
  if (start == Integer.MAX_VALUE || end == Integer.MAX_VALUE) return false;
  return (end - (start + 3)) / 3 >= 5;
}

String getProtein(String dna) {
  if (containsProtein(dna)) {
    int start = findCodon(dna, "ATG");
    int end = min(findCodon(dna, "TAA"), min(findCodon(dna, "TGA"), findCodon(dna, "TAG"))) + 3;
    return dna.substring(start, end);
  }
  return "";
}

String protein0 =   "ATGTCGCAGCTCGAACCACTGTGA";
String protein1 =   "TCGATGCAGCTCGAACCACTGTAG";
String noProtein0 = "TCGATGCAGCTCGAACCACTG";
String noProtein1 = "TCGCAGCTCGAACCACTGTAG";
String noProtein2 = "TCGTAGCAGCTCGAACCACTGATG";
String noProtein3 = "ATGTCGCAGTAACTCGAACCACTG";
String noProtein4 = "TCGATGCAGCTCGAACACTGTAG";

void setup() {
  size(600, 600);
  background(0);
  drawStrand(protein0, 0, 0, width / protein0.length());
  drawStrand(protein0, 0, width / protein0.length() * 3, width / protein0.length());
  showProtein(protein0, 0, width / protein0.length() * 4, width / protein0.length());

  strandCompare(protein1, protein0, 0, width / protein0.length() * 6, width / protein0.length());
}
