class Universe {
  int xN;
  int yM;
  Block[] blocks;
  PGraphics background;
  int timer;
  
  Universe(int n, int m) {
    timer = 0;
    
    xN = n;
    yM = m;
    
    blocks = new Block[N];
    
    for (int i=0; i<N; i++) {
      int tx = floor(random(xN));
      int ty = floor(random(yM));
      
      //if (matrix[tx][ty] == EMTY) {
      //  matrix[tx][ty] = STND;
        blocks[i] = new Block(tx, ty, siz, fg, sd, shadow_enabled);
      //} else {
      //  i--;
      //}
    }
    
    generateBackground();
  }
  
  void move() {
    int theChosenOne = floor(random(N));
    
    if (timer <= millis()) {
      boolean doneToSetTarget = blocks[theChosenOne].setTarget();
      
      if (doneToSetTarget)
        timer += floor(random(timing));
    }
    
    for (int i=0; i<N; i++)
      blocks[i].move();
  }
  
  void show() {
    image(background, 0, 0);
    
    for (int i=0; i<N; i++)
      blocks[i].show();
  }
  
  void generateBackground() {
    Block dot = new Block(0, 0, siz/2, pt, pt, false);
    background = createGraphics(width, height);
    
    background.beginDraw();
    background.noStroke();
    
    background.fill(bg);
    background.rect(0, 0, width, height);
    
    for (int x=0; x<width; x+=tav) {
      for (int y=0; y<height; y+=tav) {
        background.image(dot.img, x + siz / 4, y + siz / 4);
      }
    }
    
    background.endDraw();
  }
}