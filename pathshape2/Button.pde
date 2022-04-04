class Button {
    int x;
    int y;
    int r;
    PImage img;

    boolean clicked;

    public Button(int x, int y, int r, PImage img) {
        this.x = x;
        this.y = y;
        this.r = r;
        
        this.img = img;

        clicked = false;
    }

    void display() {
        
        circle(x,y,r);
    }
} 
