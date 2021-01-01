PImage dinoImages[]=new PImage[2], 
  birdImages[]=new PImage[2], 
  downImages[]=new PImage[2], 
  cactusImages[][]=new PImage[4][1], 
  cloudImage[]=new PImage[1], 
  groundLineImage[]=new PImage[1];

int screenWidth = 1024, 
  screenHeight = 512;

Dino dino; 
sprite  cactus[] = new sprite[4], 
  cloud, 
  bird, 
  groundLine[]=new sprite[2];
int speed=100;
int randCactus[] = {(int)random(0, 4), (int)random(0, 4), (int)random(0, 4)}, 

  randBirdTime = (int)random(0, 4), 
  randCloudTime = (int)random(0, 4);
int cactusStartPosition[] = {900, 203};
int birdStartPosition[] = {1000, 170};

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


  dino=new Dino(50, 200, dinoImages);
  bird=new sprite(1000, 170, birdImages);
  cloud=new sprite(500, 150, cloudImage);
  groundLine[0]=new sprite(0, 230, groundLineImage);
  groundLine[1]=new sprite(0, 230, groundLineImage);
  for (int i = 0; i < 4; i++) {
    cactus[i] = new sprite(cactusStartPosition[0], cactusStartPosition[1], cactusImages[i]);
  }
}
int currentTime=0;
int backGround=255;
void draw()
{
  if (!cactus[randCactus[0]].onScreen()) {
    cactus[randCactus[0]].setPosition(cactusStartPosition[0], cactusStartPosition[1]);
    randCactus[0] = (int)random(0, 4);
  }
  if (millis()-currentTime>5000) {
    backGround=255-backGround;
    currentTime=millis();
  }
  if (int(random(-100, 100))==2&&!bird.onScreen())bird.setPosition(birdStartPosition[0], birdStartPosition[1]);

  background(backGround);
  bird.render();
  groundLine[0].render();
  groundLine[1].render();
  cloud.render();
  dino.render();

  dino.move(0);
  bird.move(-20);
  cloud.move(-3);
  groundLine[0].move(-2);
  cactus[randCactus[0]].move(-2);

  if (dino.jumped()) {
    dino.walk();
  }
  if (keyPressed)
  {

    if (keyCode == UP||key==' ') {
      if (dino.walking()) dino.jump();
    } else if (keyCode == DOWN) {
      if (dino.isUp())dino.walk();
      if (dino.walking()) dino.setDown();
    }
  } else {
    if (dino.isDown()) dino.setUp();
  }
}
