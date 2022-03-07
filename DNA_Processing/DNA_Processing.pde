boolean strandMatch(String strand0, String strand1) {
  int matched = 0;
  for (int i = 0; i < strand0.length(); i++) {
    matched += (strand0.charAt(i) == 'T' && strand1.charAt(i) == 'A') ||
               (strand0.charAt(i) == 'A' && strand1.charAt(i) == 'T') ||
               (strand0.charAt(i) == 'G' && strand1.charAt(i) == 'C') ||
               (strand0.charAt(i) == 'C' && strand1.charAt(i) == 'G') ? 1 : 0;
  }
  return matched == strand0.length();
}

int findCodon(String strand, String codon) {
  for (int i = 0; i < strand.length() - 2; i++) {
    if (strand.substring(i,i+3).equals(codon)) {
      return i;
    }
  }
  return Integer.MAX_VALUE;
}

boolean containsProtein(String dna) {
  int start = findCodon(dna,"ATG");
  int end = min(findCodon(dna, "TAA"), min(findCodon(dna, "TGA"),findCodon(dna, "TAG")));
  if (start == Integer.MAX_VALUE || end == Integer.MAX_VALUE) return false;
  return (end - (start + 3)) / 3 >= 5;
}

String getProtein(String dna) {
  if (containsProtein(dna)) {
    int start = findCodon(dna,"ATG");
    int end = min(findCodon(dna, "TAA"), min(findCodon(dna, "TGA"),findCodon(dna, "TAG"))) + 3;
    return dna.substring(start,end);
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
  println(getProtein(noProtein0));
}
