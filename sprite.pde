class point {
  int x;
  int y;
  point(int x, int y) {
    this.x=x;
    this.y=y;
  }
}

class sprite {
  protected point position;
  private PImage img[];
  private int currentFrame; 
  private long currentTime;
  private int speed;
  protected boolean changeFrame;
  sprite(int x, int y, PImage img[]) {
    point p=new point(x, y);
    this.position=p;
    this.img=img;
    this.currentFrame=0;
    this.currentTime=millis();
    this.speed=20;
    this.changeFrame=true;
  }
  void setPosition(int x, int y) {
    point p=new point(x, y);
    this.position=p;
  }
  void move(int xStep) {
    if (millis()-this.currentTime>this.speed) {
      this.shiftImage(xStep, 0);
      if (changeFrame) {
        this.currentFrame++;
        this.currentFrame%=this.img.length;
        this.currentTime=millis();
      }
    }
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
    return this.position.x+this.getImage().width > 0;
  }
  void render() {
    image(this.getImage(), this.position.x, this.position.y);
  }
  void setSpeed(int speed) {
    this.speed=speed;
  }
  int getYPosition() {
    return this.position.y;
  }
  int getXPosition() {
    return this.position.x;
  }
}

class Dino extends sprite {
  private int yGradient;
  private boolean down;
  Dino(int x, int y, PImage img[]) {
    super(x, y, img);
    this.yGradient=0;
    this.down=false;
  }
  void move(int xStep) {
    if (!down)this.position.y=constrain(this.position.y+this.yGradient, 80, 200);
    if (this.position.y>=200) {
      this.setSpeed(100);
      this.changeFrame=true;
    }
    super.move(xStep);
  }
  void jump() {
    this.changeFrame=false;
    this.setSpeed(2);
    this.yGradient=-5;
    down=false;
  }
  void walk() {
    this.setSpeed(2);
    this.yGradient=5;
    down=false;
  }
  void setDown() {
    dino.setImage(downImages);
    this.shiftImage(0, 17);
    down=true;
  }
  void setUp() {
    dino.setImage(dinoImages);
    this.shiftImage(0, -17);
    down=false;
  }
  boolean jumped() {
    return this.position.y==80;
  }
  boolean walking() {
    return this.position.y==200;
  }
  boolean isDown() {
    return this.down;
  }
  boolean isUp() {
    return !this.down;
  }
  boolean collide(sprite s){
    int xStart=this.getXPosition(),
    xEnd=this.getImage().width/2+this.getXPosition(),
    yStart=this.getYPosition(),
    yEnd=this.getImage().height/2+this.getYPosition();
    if((xStart>=s.getXPosition()&&xStart<=s.getImage().width/2+s.getXPosition()&&
    yStart>=s.getYPosition()&&yStart<=s.getImage().height/2+s.getYPosition())||
    
    (xEnd>=s.getXPosition()&&xEnd<=s.getImage().width/2+s.getXPosition()&&
    yEnd>=s.getYPosition()&&yEnd<=s.getImage().height/2+s.getYPosition())
    )return true;
    return false;
  }
}
