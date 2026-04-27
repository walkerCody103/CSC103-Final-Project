Player guy1;
Obstacle o1;
Obstacle o2;
Obstacle o3;
Hurdle h1;



//background music
SoundFile mop;
//hit sound
SoundFile hit;
//evil laugh sound
SoundFile laugh;
//titleScreen sound
SoundFile thunder;
//winScreen sound
SoundFile smash;
//endSound
SoundFile mario;

//intializing game timers
int level1StartTime;
int level1EndTime;
int game1Interval;


//state for startScreen, loseScreen, levels, and winScreen
int state;


boolean isMovingUp = false;
boolean isMovingDown = false;
boolean isMovingLeft = false;
boolean isMovingRight = false;

// player hitbox vars
int pTop;
int pBottom;
int pRight;
int pLeft;

//player vars
int pW;
int pH;
int pSpeed;
color pC;

// obstacle hitbox vars
int oTop;
int oBottom;
int oRight;
int oLeft;

//obstacle vars;

int oX;
int oY;
int oSpeed;
color oC;

//hurdle vars

int hX;
int hY;
int hSpeed;
color hC;

//declaring my background image
PImage backgroundImage;

//declaring array of background animation
PImage [] fretBoardImages;

// declaring array of death screen images
PImage [] wizardImages;

//declaring array of titleScreen animation
PImage [] titleScreenImages;

//declaring array of winScreen animation
PImage [] winScreenImages;

//declationg array of endScreen animation
PImage [] endScreenImages;




//declaring my animation var for the backgroundscreen
Animation fretBoardAnimation;

//declaring my animation var for the death screen
Animation wizardAnimation;

//declaring my animation var for the titleScreen
Animation titleScreenAnimation;

//declaring my animation var for the winScreen
Animation winScreenAnimation;

//declaring my animation var for the endScreen
Animation endScreenAnimation;


void setup() {
  size(800, 600);

  //initialize background
  backgroundImage = loadImage("backnground0.png");

  //timer start
  game1Interval = 40000;

  //initializing hit sound
  hit = new SoundFile(this, "hit1.wav");

  //initilize background music
  mop = new SoundFile(this, "mop2.wav");
  
  //initializing laugh sound
  laugh = new SoundFile(this, "evilLaugh.wav");
  laugh.rate(3);
  
  //initialize thunder sound
  thunder = new SoundFile(this, "thunderSound.mp3");
  
   //initialize win sound
  smash = new SoundFile(this, "smash.mp3");
  
  //initialize end sound
  mario = new SoundFile(this, "mario.mp3");

  //initialize my array of background images
  fretBoardImages = new PImage[3];

  //fill the arrray with images loaded from the data folder
  for (int index = 0; index < fretBoardImages.length; index++) {
    fretBoardImages[index] = loadImage("fretboard" + index + ".png");
  }
  //initialiing wizard death screen animation
  fretBoardAnimation = new Animation(fretBoardImages, 0.07, 0.5);

  //initialize my array of wizard images
  wizardImages = new PImage[5];

  //fill the arrray with images loaded from the data folder
  for (int index = 0; index < wizardImages.length; index++) {
    wizardImages[index] = loadImage("deathWizard" + index + ".png");
  }
  //initialiing wizard death screen animation
  wizardAnimation = new Animation(wizardImages, 0.07, 0.75);
  
  //initialize my array of titleScreen images
  titleScreenImages = new PImage[3];

  //fill the arrray with images loaded from the data folder
  for (int index = 0; index < titleScreenImages.length; index++) {
    titleScreenImages[index] = loadImage("startScreen" + index + ".png");
  }
  //initialiing wizard death screen animation
  titleScreenAnimation = new Animation(titleScreenImages, 0.07, 1.35);
  
  //int my array of winScreen images
  winScreenImages = new PImage [15];
  
  //fill the arrray with images loaded from the data folder
  for (int index = 0; index < winScreenImages.length; index++) {
    winScreenImages[index] = loadImage("byeWizard" + index + ".png");
  }
  //initialiing wizard death screen animation
  winScreenAnimation = new Animation(winScreenImages, 0.13, 0.6);
  
  //initialize my array of background images
  endScreenImages = new PImage[2];

  //fill the arrray with images loaded from the data folder
  for (int index = 0; index < endScreenImages.length; index++) {
    endScreenImages[index] = loadImage("endAnim" + index + ".png");
  }
  //initialiing wizard death screen animation
  endScreenAnimation = new Animation(endScreenImages, 0.07, 0.35);
  

  //intitialize state machine
  state = 0;

  //initialize player vars
  pW = 50;
  pH = 50;
  pSpeed = 7;
  pC = #69DEFC;

  // initialize obstacle vars
  oX = width/4+50;
  oY = -5;
  oSpeed = 6;
  oC = color(255, 0, 0);

  //initialize hurdle vars
  hX = 0;
  hY = 4*(height/5)+20;
  hSpeed = 6;
  hC = color(255, 0, 0);

  guy1 = new Player(width/2, 4*(height/5), pW, pH, pSpeed, pC);

  o1 = new Obstacle(oX, oY, 10, 10,
    oSpeed, oC);
  o2 = new Obstacle(oX, oY, 10, 10,
    oSpeed, oC);
  o3 = new Obstacle(oX, oY, 10, 10,
    oSpeed, oC);

  h1 = new Hurdle(hX, hY, 10, 10,
    hSpeed, hC);
}


void draw() {
  background(124);

  stateFunction();
}


void keyPressed() {
  if (key == 'w') {
    isMovingUp = true;
  }
  if (key == 'a') {
    isMovingLeft = true;
  }
  if (key == 'd') {
    isMovingRight = true;
  }
  if (key == 'r') {
    state = 1;
  }
}

void keyReleased() {
  if (key == 'w') {
    isMovingUp = false;
  }
  if (key == 'a') {
    isMovingLeft = false;
  }
  if (key == 'd') {
    isMovingRight = false;
  }
}

void timer() {
  level1EndTime = millis();
  if (level1EndTime-level1StartTime > game1Interval) {
    level1StartTime = level1EndTime;
    state += 1;
  }
}

void level1() {
  
  thunder.stop();
  game1Interval = 45000;
  
  //allows only one loop of the sound to play at a time
  if (mop.isPlaying() == false) {
    mop.play();
  }
  timer();

  imageMode(CENTER);
  image(backgroundImage, width/2, height/2);

  fretBoardAnimation.display(width/2, height/2);
  fretBoardAnimation.isAnimating = true;


  guy1.render();
  guy1.move();
  guy1.jump();

  o1.render();
  o1.move();
  o1.collision(guy1);
  o1.randomize();

  o2.render();
  o2.move();
  o2.collision(guy1);
  o2.randomize();
}

void level2() {
  imageMode(CENTER);
  image(backgroundImage, width/2, height/2);

  fretBoardAnimation.display(width/2, height/2);
  fretBoardAnimation.isAnimating = true;

  timer();
  game1Interval = 45000;

  guy1.render();
  guy1.move();
  guy1.jump();

  o1.render();
  o1.move();
  o1.collision(guy1);
  o1.randomize();

  o2.render();
  o2.move();
  o2.collision(guy1);
  o2.randomize();

  o3.render();
  o3.move();
  o3.collision(guy1);
  o3.randomize();
}

void level3() {
  imageMode(CENTER);
  image(backgroundImage, width/2, height/2);

  fretBoardAnimation.display(width/2, height/2);
  fretBoardAnimation.isAnimating = true;

  timer();
  game1Interval = 40000;

  guy1.render();
  guy1.move();
  guy1.jump();

  o1.render();
  o1.move();
  o1.collision(guy1);
  o1.randomize();

  o2.render();
  o2.move();
  o2.collision(guy1);
  o2.randomize();

  o3.render();
  o3.move();
  o3.collision(guy1);
  o3.randomize();
  oSpeed = 8;

  h1.render();
  h1.move();
  h1.collision(guy1);
  h1.timer();
}

void level4() {
  imageMode(CENTER);
  image(backgroundImage, width/2, height/2);

  timer();
  game1Interval = 30000;

  fretBoardAnimation.display(width/2, height/2);
  fretBoardAnimation.isAnimating = true;


  guy1.render();
  guy1.move();
  guy1.jump();

  oY = 0;

  o1.render();
  o1.move();
  o1.collision(guy1);
  o1.randomize();

  o2.render();
  o2.move();
  o2.collision(guy1);
  o2.randomize();

  o3.render();
  o3.move();
  o3.collision(guy1);
  o3.randomize();
  oSpeed = 10;

  h1.render();
  h1.move();
  h1.collision(guy1);
  h1.timer();
  h1.interval = 3000;
}



void winScreen() {
  timer();
  game1Interval = 2000;
  imageMode(CENTER);
  image(backgroundImage, width/2, height/2);
  winScreenAnimation.display(width/2, height/2);
  winScreenAnimation.isAnimating = true;
  mop.stop();
  if (smash.isPlaying() == false) {
    smash.play();
  }
}

void deathScreen() {
  
  background(0);
  wizardAnimation.display(width/2, height/2 + 80);
  wizardAnimation.isAnimating = true;
  textAlign(CENTER);
  textSize(100);
  fill(200, 0, 255);
  text("GAME OVER", width/2, 1*(height/4));
  mop.stop();
  
  if(laugh.isPlaying() == false){
  laugh.play();
  }
}

void endScreen(){
  background(150, 0, 100);
  textAlign(CENTER);
  textSize(65);
  fill(0, 0, 255);
  endScreenAnimation.display(width/2 - 50, height/2);
  endScreenAnimation.isAnimating = true;
  text("YOU WIN", width/2, 1*(height/5));
   if(mario.isPlaying() == false){
  mario.play();
}
}
void stateFunction() {

  //making our finite state machine
  switch (state) {
    // each state is defined between a case and a break

    //start screen
  case 0:
background(42);
 if (thunder.isPlaying() == false) {
    thunder.play();
  }
  titleScreenAnimation.display(width/2, height/2);
  titleScreenAnimation.isAnimating = true;
    textAlign(CENTER);
    textSize(45);
    fill(255);
    text("Press 'r' to accept this challenge!", 
    width/2, 1*(height/2));
  
    break;
    
    //level 1
  case 1:

    level1();

    break;


  case 2:

    level2();

    break;
  case 3:

    level3();

    break;

    //are you ready?
  case 4:
    imageMode(CENTER);
    image(backgroundImage, width/2, height/2);

    timer();
    game1Interval = 3000;

    fretBoardAnimation.display(width/2, height/2);
    fretBoardAnimation.isAnimating = true;

    guy1.render();
    guy1.move();
    guy1.jump();
    textAlign(CENTER);
    textSize(65);
    fill(255, 0, 0);
    text("ARE YOU READY?", width/2, 1*(height/3));

    break;

  case 5:

    level4();

    break;

    //winScreen
  case 6:
    winScreen();
    break;

  case 7:
  endScreen();
  break;
    //death screen
  case 88:
    deathScreen();
    break;
  }
}
