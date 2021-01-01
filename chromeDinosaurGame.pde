PImage dinoImages[]=new PImage[2], 
  birdImages[]=new PImage[2], 
  downImages[]=new PImage[2], 
  cactusImages[][]=new PImage[4][1], 
  cloudImage[]=new PImage[1], 
  groundLineImage[]=new PImage[1];

final int screenWidth = 1024, 
  screenHeight = 512;

Dino dino; 
sprite cloud, 
  bird, 
  groundLine[]=new sprite[2], 
  cactus[] = new sprite[4];
int speed=100;
int randCactusPosition[]=new int[5], 
  randBirdTime = (int)random(500, 2000), 
  randCloudTime = (int)random(100, 400);
int cactusStartPosition[] = {1100, 200};
int birdStartPosition[] = {1000, 170};
int birdTime=0;
int cloudTime=0;
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
  bird.setSpeed(100);
  cloud=new sprite(500, 150, cloudImage);
  groundLine[0]=new sprite(0, 230, groundLineImage);
  groundLine[1]=new sprite(groundLineImage[0].width, 230, groundLineImage);
  randCactusPosition[0]=cactusStartPosition[0];
  for (int i = 0; i < 4; i++) {
    cactus[i] = new sprite(randCactusPosition[i], cactusStartPosition[1], cactusImages[i]);
    randCactusPosition[i+1]=randCactusPosition[i]+cactusImages[i][0].width+(int)random(150, 200);
  }
}

int backGround=255;
long scoreTime=0;
long score=1, maxScore=0;
long max(long a, long b) {
  if (a>b)return a;
  return b;
}

void draw()
{

  if (millis()-scoreTime>100) {
    score++;
    maxScore=max(maxScore, score);
    if (score%50==0) backGround=255-backGround;
    scoreTime=millis();
  }

  if (int(random(-100, 100))==0&&!bird.onScreen())bird.setPosition(birdStartPosition[0], birdStartPosition[1]);
  for (int i=0; i<2; i++)if (!groundLine[i].onScreen())groundLine[i].setPosition(groundLineImage[0].width, 230);
  for (int i=0; i<4; i++)if (!cactus[i].onScreen()) {
    cactus[i].setPosition(randCactusPosition[i], 200);
    cactus[i].setImage(cactusImages[(int)random(0,4)]); 
}
  background(backGround);
  textSize(20);
  fill(255-backGround);
  text("HI: "+maxScore+"  "+score, width-200, 30);
  bird.render();
  groundLine[0].render();
  groundLine[1].render();
  cloud.render();
  for (int i=0; i<4; i++)cactus[i].render();
  dino.render();
  dino.move(0);
  bird.move(-5);
  cloud.move(-1);
  groundLine[0].move(-2);
  groundLine[1].move(-2);
  for (int i=0; i<4; i++)cactus[i].move(-2);
  //if(score>100)while(true);
  if (dino.jumped()) dino.walk();

  if (keyPressed)
  {

    if (keyCode == UP||key==' ') {
      if (dino.walking()) dino.jump();
    } else if (keyCode == DOWN) {
      if (dino.isUp())dino.walk();
      if (dino.walking()) dino.setDown();
    }
  } else if (dino.isDown()) dino.setUp();
}
