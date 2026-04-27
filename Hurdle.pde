

class Hurdle {
  // hurdle vars
  int x;
  int y;
  int w;
  int h;
  int hurdleSpeed;
  color c1;
  int startTime;
  int endTime;
  int interval = 6000;

//declaring array of hurdle animation
PImage [] hurdleImages;

//declaring my animation var for the hurdle
Animation hurdleAnimation;

  // constructor function
  Hurdle(int startingX, int startingY, int startingW,
    int startingH, int startingSpeed,
    color startingColor) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    hurdleSpeed = startingSpeed;
    c1 = startingColor;
    
      // initialize image arrays
    hurdleImages = new PImage[2];
    
        //fill the arrray with images loaded from the data folder
  for (int index = 0; index < hurdleImages.length; index++) {
    hurdleImages[index] = loadImage("hurdleAnim2" + index + ".png");
  }
  //initialiing wizard death screen animation
  hurdleAnimation = new Animation(hurdleImages, 0.1, 1);

  }
  //every class needs functions
  void render() {
    int size;
    size = int(map(x, 0, 120, 5, 12));
    //rectMode(CENTER);
    //fill(c1);
    //rect(x, y, size, size);
    
    hurdleAnimation.grow(x, y, map(y, 0, 600, 
                30, 160), map(y, 0, 600, 30, 140));
     hurdleAnimation.isAnimating = true;
    
 
    //initialize obstacle hitBox vars
    oTop = y - size/2;
    oBottom = y + size/2;
    oRight = x + size/2;
    oLeft = x - size/2;
  }
  void move() {
    x += hurdleSpeed;
  }
  void collision(Player aPlayer) {
    if (aPlayer.pRight >= oLeft &&
      aPlayer.pLeft <= oRight &&
      aPlayer.pBottom >= oTop &&
      aPlayer.pTop <= oBottom) {
      println("hit");
      hit.play();
      state = 88;
    }
  }

  void timer() {
    endTime = millis();
    if (endTime-startTime > interval) {
      startTime = endTime;
      x = 0;
    }
  }
}
