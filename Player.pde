class Player {
  // player vars
  int x;
  int y;
  int w;
  int h;
  int playerSpeed;
  color c1;

  // player hitbox vars
  int pTop;
  int pBottom;
  int pRight;
  int pLeft;

  // moving booleans
  boolean movingLeft;
  boolean movingRight;
  boolean movingUp;
  boolean movingDown;

  // declare image arrays
  PImage[] idleImages;

  // declare animation objects
  Animation idleAnim;

  // constructor function
  Player(int startingX, int startingY, int startingW,
    int startingH, int startingSpeed, color startingColor) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    playerSpeed = startingSpeed;
    c1 = startingColor;

    // moving booleans
    movingLeft = false;
    movingRight = false;
    movingUp = false;
    movingDown = false;

    // initialize image arrays
    idleImages = new PImage[8];

    for (int index=0; index<= idleImages.length-1; index++) {
      idleImages[index] = loadImage("pickJog" + index + ".png");
    }
    // initialize animation objects
    idleAnim = new Animation(idleImages, 0.1, 0.8);
  }

  //every class needs functions
  void render() {
    //rectMode(CENTER);
    //fill(c1);
    //rect(x, y, w, h);

    idleAnim.display(x, y);
    idleAnim.isAnimating = true;
    //initialize player hitBox vars
    pTop = y - w/2;
    pBottom = y + w/2;
    pRight = x + w/2;
    pLeft = x - w/2;

    if (pLeft < width/4) {
      isMovingLeft = false;
    }
    if (pRight > 3*(width/4)) {
      isMovingRight = false;
    }
    if (pBottom >= 4*(height/5)) {
      isMovingDown = false;
    }
    if (pTop <= 4*(height)/5 - 100) {
      isMovingUp = false;
    }
  }
  void move() {
    //booleans


    if (isMovingUp == true) {
      y -= playerSpeed*2;
    }

    if (isMovingRight == true) {
      x += playerSpeed;
    }
    if (isMovingLeft == true) {
      x -= playerSpeed;
    }
  }
  void jump() {
    if (pTop <= 4*(height)/5 - playerSpeed*2) {
      isMovingDown = true;
    }
    if (isMovingDown == true) {
      y += playerSpeed;
    }
  }
}
