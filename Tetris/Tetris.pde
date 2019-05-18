//Useful globally
PFont font28; //NES font
int frame = 0; //helpful to keep track as the speed of the game is based on 60 fps
final int lineHeight = height / 20; //useful constant possibly

//For the UI elements
int level = 0;
int speed; //not shown on-screen but calculated from the level via a switch statement
int lines = 0;
int score = 0;

class Block {
  int x;
  int y;
  color c;
  
  Block(int posX, int posY, int r, int g, int b) {
    x = posX;
    y = posY;
    c = color(r, g, b);
    rectMode(CENTER);
    fill(c);
    rect(x, y, 10, 10);
  }
}
void CountH() {
  textFont(font28);
  textAlign(CENTER, CENTER);
  fill(255);
}

void frameCounter() { //top left
  //To clear text
  fill(64, 67, 71); 
  stroke(64, 67, 71);
  rect(40, 30, 60, 60);
  
  CountH();
  text(String.format("%02d", frame % 60), 40, 30); //2 digits
}

void lineCounter() {
  //To clear text
  fill(0);
  stroke(0);
  rect(width/2, height * 0.1, width /3 - 10, height * 0.1 - 10);
  
  CountH();
  text("LINES-" + String.format("%03d", lines % 240), width/2, height * 0.1);
}

void scoreCounter() {
  //To clear text
  fill(0);
  stroke(0);
  rect(width * (0.83), height * 0.25, width/5 - 10, height * 0.1 - 10);
  
  CountH();
  text(String.format("%06d", score), width * (0.83), height * 0.25);
}

void setup() {
  size(960, 720);
  frameRate(60);
  background(64, 71, 71); //gray
  font28 = createFont("PressStart2P-Regular.ttf", 28);
  
  //Playing field
  fill(0);
  rectMode(CENTER);
  stroke(255); //black borders
  strokeWeight(2);
  rect(width / 2, height * 0.55, width/3, height * 0.75); //looks closest to the actual game, by my eye
  
  //Lines box
  rect(width/2, height * 0.1, width/3, height * 0.1); //magic numbers galore!
  
  //Score box 
  rect(width * (13.3/16), height * 0.2, width/5, width/6);
  textFont(font28);
  textAlign(CENTER, CENTER);
  fill(255);
  text("SCORE", width * (13.3/16), height * 0.16);
}

void draw() {
  ++frame; //unless you have the program running a year in a row, this is never overflowing
  ++lines; //those 2 are just to show the numbers changing
  ++score;
  
  frameCounter();
  lineCounter();
  scoreCounter();
}
