//final int STRT =-1;
final int STAY = 0;
final int mvUP = 1;
final int mvRG = 2;
final int mvDN = 3;
final int mvLF = 4;

class Block {
  int     status;
  int     posX;
  int     posY;
  int     trgX;
  int     trgY;
  float   progress;
  float   size;
  color   colour;
  color   shadowColor;
  boolean shadowEnabled;
  PGraphics img;
  
  Block(int x, int y, float s, color c, color shadow, boolean shadow_enabled) {
    posX = x;
    posY = y;
    trgX = x;
    trgY = y;
    size = s;
    status = STAY;
    colour = c;
    progress = 0.0;
    shadowColor = shadow;
    shadowEnabled = shadow_enabled;
    img = createGraphics(int(3 * size), int(3 * size));
    
    generate();
  }
  
  void show() {
    float x = (posX * (1.0 - progress) + trgX * progress) * tav;
    float y = (posY * (1.0 - progress) + trgY * progress) * tav;
    image(img, x - size/2, y - size/2);
  }
  
  void move() {
    if (status != STAY) {
      progress += speed;
    
      if (progress >= 1.0) {
        posX = trgX;
        posY = trgY;
        status = STAY;
        progress = 0.0;
      }
    }
  }
  
  boolean setTarget() {
    if (status != STAY)
      return false;
      
    int irany = floor(random(4)) + 1;
    
    if (posX <= 0 || posX >= U.xN || posY <= 0 || posY >= U.yM)
      irany = (irany + 1) % 4 + 1;
    
    switch (irany) {
      case mvUP:
        trgY = posY - 1;
        break;
      case mvRG:
        trgX = posX + 1;
        break;
      case mvDN:
        trgY = posY + 1;
        break;
      case mvLF:
        trgX = posX - 1;
        break;
    }
    
    int occupiedBy = 0;
    
    for (int i=0; i<N; i++) {
      if ((U.blocks[i].posX == trgX && U.blocks[i].posY == trgY) ||
          (U.blocks[i].trgX == trgX && U.blocks[i].trgY == trgY))
      {
        occupiedBy++;
      }
    }
    
    if (occupiedBy == 1) {
      progress = 0.0;
    
      status = irany;
      return true;
    }
    return false;
  }
  
  void generate() {
    img.beginDraw();
    img.noStroke();
    
    if (shadowEnabled) {
      img.fill(shadowColor);
      img.rect(size, size, size, size);
      img.filter(BLUR, 2);
    }
    
    img.fill(colour);
    img.rect(size, size, size, size);
    
    img.endDraw();
  }
}