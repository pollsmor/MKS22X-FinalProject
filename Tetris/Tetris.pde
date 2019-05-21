//Useful globally
PFont font;
int frame = 0; //helpful to keep track of as the speed of the game is based on 60 fps
color backgroundGray = color(64, 71, 71);
boolean keyLock = false;

PShape b1, b2, b3, b4;
float x1, x2, x3, x4, y1, y2, y3, y4;
float nx1, nx2, nx3, nx4, ny1, ny2, ny3, ny4; //useful for checking bounds
PShape I, O, J, L, S, Z, T;
int rotation = 0;
int maxRotations;
int dx = 0;
int dy = 0;
//Piece colors
color IPieceTurqoise = color(0, 255, 255);
color OPieceYellow = color(255, 255, 0);
color JPieceBlue = color(0, 0, 204);
color LPieceOrange = color(255, 153, 0);
color SPieceGreen = color(0, 255, 0);
color ZPieceRed = color(255, 0, 0);
color TPiecePurple = color(204, 51, 255);

//Constants
float lh = 27.0;
float pFieldWidth = lh * 10;
float pFieldHeight = lh * 20;
float pFieldTopX;
float pFieldTopY;

//For the counters
int lines, score = 0;
int level = 0;


Block[][] pField = new Block[20][10];


int curr = (int) random(7);
PShape currPiece, nextPiece;
//generates a random piece in it's non rotated state.
PShape determine() {
  if (curr == 0) return createI(0);
  else if (curr == 1) return createO(); //square has no new rotation so no point
  else if (curr == 2) return createJ(0);
  else if (curr == 3) return createL(0);
  else if (curr == 4) return createS(0);
  else if (curr == 5) return createZ(0);
  else return createT(0);
}

//Returns how many frames it takes a piece to fall down 1 line (e.g. 48 on level 0)
int getSpeed() {
  switch (level) {
    case 0:
      return 48;
    case 1:
      return 43;
    case 2:
      return 38;
    case 3:
      return 33;
    case 4:
      return 28;
    case 5:
      return 23;
    case 6:
      return 18;
    case 7:
      return 13;
    case 8:
      return 8;
    case 9:
      return 6;
    case 10:
      return 5;
    case 11:
      return 5;
    case 12:
      return 5;
    case 13:
      return 4;
    case 14:
      return 4;
    case 15:
      return 4;
    case 16:
      return 3;
    case 17:
      return 3;
    case 18:
      return 3;
    case 19:
      return 2;
    case 20:
      return 2;
    case 21:
      return 2;
    case 22:
      return 2;
    case 23:
      return 2;
    case 24:
      return 2;
    case 25:
      return 2;
    case 26:
      return 2;
    case 27:
      return 2;
    case 28:
      return 2;
    default: //Level 29 and above: the kill screen
      return 1;
  }
}

void setup() {
  size(960, 720);
  frameRate(60); //believe this is by default but whatever
  background(backgroundGray);
  font = createFont("PressStart2P-Regular.ttf", 28);

  //Assign playing field constants
  pFieldTopY = height * 0.190 + lh/2;
  pFieldTopX = pFieldWidth * 1.275 + lh/2 +5 *lh;
  currPiece = determine();
  //nextPiece changes t the second it is initialized which may screw over redrawing currPiece as it moves
  //nextPiece = determine();//createJ(0);//determine();
}

void draw() {
  background(backgroundGray); //clear screen

  //Those are just to show counter updating works
  ++frame; //unless you have the program running a year in a row, this is never overflowing
  ++lines;
  ++score;

  //pushMatrix();
  //translate(width * .5, height * .55);
  float xB = pFieldWidth/20;
  float yB = pFieldHeight/40;
  for (int r = 0; r < 20; r++) {
    for (int c = 0; c < 10; c++) {
      pField[r][c] = new Block(xB, yB, 0, 0, 0);
      xB += pFieldWidth/10;
    }
    xB = pFieldWidth/20;
    yB += pFieldHeight/20;
  }
  //popMatrix();

  //Playing field
  pushMatrix();
  translate(pFieldWidth * 1.275, height * 0.190);
  for (int r = 0; r < 20; r++) {
    for (int c = 0; c < 10; c++) {
      pField[r][c].display();
    }
  }
  popMatrix();

  frameCounter();
  lineCounter();
  scoreCounter();
  nextPieceCounter();
  levelCounter();

  //Falling piece
   shape(currPiece);
  if (frame % getSpeed() == 0) {
    currPiece = moveDown();
    //currPiece = rotateLeft();
  //if (rotation == 0) delay(100000);
  }
}

void keyPressed() {
  if (!keyLock) {
    switch (key) {
      case 'a':
        currPiece = moveLeft();
        keyLock = true;
        break;

      case 'd':
        currPiece = moveRight();
        keyLock = true;
        break;

      case 's':
        currPiece = moveDown();
        keyLock = true;
        break;

      case '-': //proof of concept: decrease level/speed
        if (level > 0) --level;
        keyLock = true;
        break;

      case '=':
        ++level;
        keyLock = true;
        break;

      case 'j':
        currPiece = rotateRight();
        keyLock = true;
        break;

      case 'k':
      currPiece = rotateLeft();
      keyLock = true;
      break;
    }
  }
}

  void keyReleased() {
    keyLock = false;
  }
