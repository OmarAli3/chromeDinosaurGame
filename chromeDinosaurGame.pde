PImage dinoImages[]=new PImage[2], 
  birdImages[]=new PImage[2], 
  downImages[]=new PImage[2], 
  cactusImages[][]=new PImage[4][1], 
  cloudImage[]=new PImage[1], 
  groundLineImage[]=new PImage[1], 
  gameOverImage[]=new PImage[1]
  ;

final int screenWidth = 1024, 
  screenHeight = 512;

Dino dino; 
sprite cloud[]=new sprite[3], 
  bird, 
  groundLine[]=new sprite[2], 
  cactus[] = new sprite[4], 
  gameOver;
int speed=100;
int randCactusPosition[]=new int[5], 
  randCloudPosition[]=new int[4];
int cactusStartPosition[] = {1100, 200};
int cloudStartPosition[] = {500, 150};
int birdStartPosition[] = {1000, 175};

void setup()
{
  size(1024, 512);
  //Loading images
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
  gameOverImage[0]=loadImage("sprites/gameOver.png");

  //Initializing sprites
  gameOver=new sprite(200, 80, gameOverImage);
  dino=new Dino(50, 200, dinoImages);
  bird=new sprite(-100, 0, birdImages);
  bird.setSpeed(70);

  //Randomizing initial positions
  randCloudPosition[0]=cloudStartPosition[0];
  for (int i = 0; i < 3; i++) {
    cloud[i] = new sprite(randCloudPosition[i], cloudStartPosition[1]+(int)random(-70, -30), cloudImage);
    randCloudPosition[i+1]=randCloudPosition[i]+cloudImage[0].width+(int)random(100, 250);
  }
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
boolean running=true;
void Stop() {//Stoping the game and reset positions and score
  gameOver.render();
  score=0;
  running=false;
  bird.setPosition(-100, 0);
  for (int i=0; i<4; i++) {
    cactus[i].setPosition(randCactusPosition[i+1], 200);
    cactus[i].setImage(cactusImages[(int)random(0, 4)]);
  }
}
void draw()
{
  if (running) {
    if (millis()-scoreTime>100) {//Updating score every 100 ms
      score++;
      maxScore=max(maxScore, score);
      if (score%200==0) backGround=255-backGround; //Change the background every 200 score
      scoreTime=millis();
    }

    //Re-random the positions of sprites if they out of the screen
    if (int(random(-200, 200))==0&&!bird.onScreen())bird.setPosition(birdStartPosition[0], birdStartPosition[1]);
    for (int i=0; i<2; i++)if (!groundLine[i].onScreen())groundLine[i].setPosition(groundLineImage[0].width, 230);
    for (int i=0; i<4; i++)if (!cactus[i].onScreen()) {
      cactus[i].setPosition(randCactusPosition[i+1], 200);
      cactus[i].setImage(cactusImages[(int)random(0, 4)]);
    }
    for (int i=0; i<3; i++)if (!cloud[i].onScreen()) {
      cloud[i].setPosition(randCloudPosition[i+1], cloudStartPosition[1]+(int)random(-70, -30));
    }

    background(backGround);
    textSize(20);
    fill(255-backGround);
    text("HI: "+maxScore+"  "+score, width-200, 30);

    //Puting images of the sprites on the screen
    bird.render();
    groundLine[0].render();
    groundLine[1].render();
    for (int i=0; i<3; i++)cloud[i].render();
    for (int i=0; i<4; i++)cactus[i].render();
    dino.render();

    //Check collisions
    if (dino.collide(bird))Stop();
    for (int i=0; i<4; i++)if (dino.collide(cactus[i]))Stop();

    //moving the sprites
    dino.move(0);
    bird.move(-20);
    for (int i=0; i<3; i++)cloud[i].move(-1);
    groundLine[0].move(-6);
    groundLine[1].move(-6);
    for (int i=0; i<4; i++)cactus[i].move(-6);

    if (dino.jumped()) dino.walk();//Returning dino back to the ground if the dino is jumped
  } 
  if (keyPressed)
  {

    if (key=='\n')running=true; //press enter to play again if game over

    if (keyCode == UP||key==' ') {//jump if the up key or space is pressed 

      if (dino.walking()) dino.jump(); //jump only if the dino is on the ground and wait for it if it is already jumped
    } else if (keyCode == DOWN) {//Bring the dino's head down if the down key is pressed 

      if (dino.isUp())dino.walk(); //if it is jumped and on the air increase its speed to get back to the gorund
      if (dino.walking()) dino.setDown();//Bring the dino's head down if it is not
    }
  } else if (dino.isDown()) dino.setUp();//Bring the dino's head up if it is not
}
