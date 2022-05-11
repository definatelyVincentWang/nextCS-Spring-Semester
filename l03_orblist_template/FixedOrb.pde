/*=====================
  This class does not need to be modified.
  =====================*/
class FixedOrb extends OrbNode {

  FixedOrb(int x, int y) {
    super(x, y);
  }//constructor

  void run() {
    acceleration.mult(0);
  }//run

}//FixedOrb
