class Block {
  float x,y;
  color c;

  Block(float posX, float posY, color c) {
    x = posX;
    y = posY;
    this.c = c;
  }

  void display() {
    rectMode(CENTER);
    fill(c);

    //It looks better blending in imo - Kevin
    stroke(255); //border
    rect(x, y, lh, lh);
  }

  color gColor() {
    return this.c;
  }

  //changes color to black. Useful for "deleting" a block
  void cColor(color col) {
    this.c = col;
  }
}
