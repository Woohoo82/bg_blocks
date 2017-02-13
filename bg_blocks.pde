int tav = 50;
int siz = 15;

//color bg = #303030;
//color fg = #00bfa5;
color bg = color(255, 127, 0);
color fg = color(255);
color sd = color(0, 150);
color pt = color(0, 32);

int   N = 88; // num of blocks

boolean shadow_enabled = true;
float speed  = 1.0 / tav;
float timing = 0.7; // The average interval (in seconds) to start a move

Universe U;

void setup() {
  //size(pictureW, pictureH);
  size(640, 360);
  noStroke();
  //noLoop();
  timing *= 2000;
  U = new Universe(width / tav, height / tav);
}

void draw() {
  U.move();
  U.show();
  
  //saveFrame("export/bg_blocks-####.png");
}