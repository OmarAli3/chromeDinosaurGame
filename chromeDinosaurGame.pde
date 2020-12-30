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
  cactusImages[]=new PImage[4], 
  cloudImage[]=new PImage[1] , 
  groundLineImage[]=new PImage[1];
  
class sprite {
  private point position;
  private PImage img[];
  private int currentFrame; 
  private int ypos;
  sprite(int x, int y, PImage img[]) {
    point p=new point(x, y);
    this.position=p;
    //this.img=new PImage[fNumber];
    this.img=img;
    this.currentFrame=0;
    this.ypos=0;
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
}
sprite dino,
       cactus,
       cloud,
       bird,
       groundLine;
int currentTime=0;
int speed=100;
void setup()
{
  size(1024, 512);
  dinoImages[0] =loadImage("sprites/dino3.png");
  dinoImages[1] =loadImage("sprites/dino4.png");

  birdImages[0] =loadImage("sprites/bird1.png");
  birdImages[1] =loadImage("sprites/bird2.png");

  downImages[0] =loadImage("sprites/dino7.png");
  downImages[1] =loadImage("sprites/dino8.png");

  cactusImages[0] =loadImage("sprites/cactus1.png");
  cactusImages[1] =loadImage("sprites/cactus2.png");
  cactusImages[2] =loadImage("sprites/cactus3.png");
  cactusImages[3] =loadImage("sprites/cactus4.png");
  cloudImage[0]=loadImage("sprites/cloud.png");
  groundLineImage[0]=loadImage("sprites/groundLine.png");
  /* 
   cloud,
   groundLine;*/
  dino=new sprite(50, 200, dinoImages);
  bird=new sprite(500,170, birdImages);
  cloud=new sprite(500,150, cloudImage);
  groundLine=new sprite(0,230, groundLineImage);
  currentTime=millis();
}
boolean shiftedDown=false, 
  shiftedUp=false, 
  isUp=false;

void draw()
{
  background(0, 0, 0);
  image(dino.getImage(), dino.position.x, dino.position.y);
  image(bird.getImage(), bird.position.x, bird.position.y);
  image(cloud.getImage(), cloud.position.x, cloud.position.y);
  image(groundLine.getImage(), groundLine.position.x, groundLine.position.y);
  delay(speed);
  dino.move(0);
  bird.move(-5);
  cloud.move(-3);
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
