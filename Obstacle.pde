//import sound library
import processing.sound.*;


class Obstacle {
  // obstacle vars
  int x;
  int y;
  int w;
  int h;
  int obstacleSpeed;
  color c1;
  int position;

  
  // obstacle hitbox vars
int oTop;
int oBottom;
int oRight;
int oLeft;

// declare image arrays
 PImage[] noteImages;

// declare animation objects
  Animation noteAnim;

  // constructor function
  Obstacle(int startingX, int startingY, int startingW,
    int startingH, int startingSpeed, 
    color startingColor) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    obstacleSpeed = startingSpeed;
    c1 = startingColor;
    
      // initialize image arrays
    noteImages = new PImage[4];
    
     for (int index=0; index<= noteImages.length-1; index++) {
      noteImages[index] = loadImage("evilNote" + index + ".png");
    }
    

     // initialize animation objects
    noteAnim = new Animation(noteImages, 0.1, 0.35);
    
  }
  //every class needs functions
  void render() {
    int size;
    size = int(map(y, 0, 600, 10, 73));
    
    //rectMode(CENTER);
    //fill(c1);
    //rect(x, y, size, size);
    
     noteAnim.grow(x, y, map(y, 0, 600, 
                30, 160), map(y, 0, 600, 30, 140));
     noteAnim.isAnimating = true;
   
    //initialize obstacle hitBox vars
    oTop = y - size/2;
    oBottom = y + size/2;
    oRight = x + size/2;
    oLeft = x - size/2;
  }
  void move() {
    y += obstacleSpeed;
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
  
  void randomize(){
    //making our finite state machine
  switch (position) {
    // each state is defined between a case and a break
  case 0:
    x = width/4+50;
   
    break;

  case 1:
   x = (width/4+50)+100 ;
    
    break;

  case 2:
   x = (width/4+150)+100;
   
    break;
    
  case 3:
   x = (width/4+250)+100;
   
    break;
  }
    if (oTop >= height) {
      y = 0 - w/2;
      position = int(random(4));
    }
   }
}

   

 
