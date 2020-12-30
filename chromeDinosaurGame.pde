class point {
  int x;
  int y;
  point(int x, int y) {
    this.x=x;
    this.y=y;
  }
}
PImage dinoImages[]=new PImage[2], 
  birdImages[]=new PImage[2], 
  downImages[]=new PImage[2], 
  cactusImages[][]=new PImage[4][1], 
  cloudImage[]=new PImage[1], 
  groundLineImage[]=new PImage[1];

int screenWidth = 1024, 
  screenHeight = 512;

class sprite {
  private point position;
  private PImage img[];
  private int currentFrame; 
  sprite(int x, int y, PImage img[]) {
    point p=new point(x, y);
    this.position=p;
    this.img=img;
    this.currentFrame=0;
  }
  void setPosition(int x, int y) {
    point p=new point(x, y);
    this.position=p;
  }
  void move(int speed) {
    this.position.x+=speed;
    this.currentFrame++;
    this.currentFrame%=this.img.length;
  }
  PImage getImage() {
    return this.img[this.currentFrame];
  }
  void setImage(PImage[] img) {
    this.img=img;
  }
  void shiftImage(int xshift, int yshift) {
    this.position.x+=xshift;
    this.position.y+=yshift;
  }
  boolean onScreen() {
    return this.position.x >= 0 && this.position.x <= screenWidth;
  }
  void render() {
    image(this.getImage(), this.position.x, this.position.y);
  }
}

class Cactus{
  int currentTime;
  Cactus(){
     currentTime = millis();
  }
  
  
  void render(sprite s){
    if(millis() - currentTime > 500){
      image(s.getImage(), s.position.x, s.position.y);
      currentTime = millis();
    }
  }
}


sprite dino, 
  cactus[] = new sprite[4], 
  cloud, 
  bird, 
  groundLine;
int currentTime=0;
int speed=100;
int randCactus[] = {(int)random(0, 4), (int)random(0, 4), (int)random(0, 4)}, 

  randBirdTime = (int)random(0, 4), 
  randCloudTime = (int)random(0, 4);
int cactusStartPosition[] = {900, 203};
Cactus ayEsm;
void setup()
{
  size(1024, 512);
  dinoImages[0] =loadImage("sprites/dino3.png");
  dinoImages[1] =loadImage("sprites/dino4.png");

  birdImages[0] =loadImage("sprites/bird1.png");
  birdImages[1] =loadImage("sprites/bird2.png");

  downImages[0] =loadImage("sprites/dino7.png");
  downImages[1] =loadImage("sprites/dino8.png");

  cactusImages[0][0] =loadImage("sprites/cactus1.png");
  cactusImages[1][0] =loadImage("sprites/cactus2.png");
  cactusImages[2][0] =loadImage("sprites/cactus3.png");
  cactusImages[3][0] =loadImage("sprites/cactus4.png");
  cloudImage[0]=loadImage("sprites/cloud.png");
  groundLineImage[0]=loadImage("sprites/groundLine.png");


  dino=new sprite(50, 200, dinoImages);
  bird=new sprite(500, 170, birdImages);
  cloud=new sprite(500, 150, cloudImage);
  groundLine=new sprite(0, 230, groundLineImage);
  for (int i = 0; i < 4; i++) {
    cactus[i] = new sprite(cactusStartPosition[0], cactusStartPosition[1], cactusImages[i]);
  }
  currentTime=millis();
  
  
  
  ayEsm = new Cactus();
  
  
}
boolean shiftedDown=false, 
  shiftedUp=false, 
  isUp=false;

void draw()
{
  if (!cactus[randCactus[0]].onScreen()) {
    cactus[randCactus[0]].setPosition(cactusStartPosition[0], cactusStartPosition[1]);
    randCactus[0] = (int)random(0, 4);
  }


  background(0, 0, 0);
  dino.render();
  bird.render();
  cloud.render();
  groundLine.render();
  //cactus[randCactus[0]].render();
  ayEsm.render(cactus[(int)random(0, 4)]);
  ayEsm.render(cactus[(int)random(0, 4)]);
  ayEsm.render(cactus[(int)random(0, 4)]);
  
  delay(speed);
  dino.move(0);
  bird.move(-5);
  cloud.move(-3);
  cactus[randCactus[0]].move(-20);
  if (shiftedUp&&(millis()-currentTime)>100) {
    shiftedUp=false;
    dino.shiftImage(0, 50);
  }
  if (isUp&&(millis()-currentTime)>300) {
    isUp=false;
  }
  if (keyPressed && (key == CODED))
  {
    if (keyCode == LEFT) {
    } else if (keyCode == RIGHT) {
    } else if (keyCode == UP) {
      int x=(millis()-currentTime)%50;
      if (!shiftedUp&&!isUp) {
        dino.shiftImage(0, -50);
        shiftedUp=true; 
        isUp=true;
        currentTime=millis();
      }
    } else if (keyCode == DOWN) {
      dino.setImage(downImages);
      if (!shiftedDown) {
        dino.shiftImage(0, 17);
        shiftedDown=true;
      }
    }
  } else {
    dino.setImage(dinoImages);
    if (shiftedDown) {
      dino.shiftImage(0, -17);
      shiftedDown=false;
    }
  }
  fill(255, 255, 0);
}
