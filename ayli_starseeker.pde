/*
  Eva Yan
  Professor Chung
  Game Design and Programming
  Due: 19 December 2019
  "Ayli: Star Seeker" (Processing Final Game Project)
*/

//----------------------------------------------------------------- Variables
//Managers
InputManager _im = new InputManager();
TimeManager _tm = new TimeManager();
StageManager _stm = new StageManager();
SceneManager _sm = new SceneManager();
UI _ui;

//Camera
Camera cam;
float groundY;

//Ayli
Ayli ayli;

//Platforms
ArrayList<Platforms> platforms1 = new ArrayList<Platforms>(); //stage 1
ArrayList<Platforms> o_platforms1 = new ArrayList<Platforms>();

ArrayList<Platforms> platforms2 = new ArrayList<Platforms>(); //stage 2
ArrayList<Platforms> o_platforms2 = new ArrayList<Platforms>(); 

ArrayList<Platforms> platforms3 = new ArrayList<Platforms>(); //stage 3
ArrayList<Platforms> o_platforms3 = new ArrayList<Platforms>(); 

color platformColor = color(255); //applicable to all platforms
PVector basePlatformPos = new PVector(0, 370); 
PVector smallBPPS;
PVector platformSize = new PVector(160, 20);

//Particle
ArrayList<Particle> particleHistList = new ArrayList<Particle>();

//Starpieces
ArrayList<Starpiece> starpieces1;
ArrayList<Starpiece> o_starpieces1;
ArrayList<Starpiece> starpieces2;
ArrayList<Starpiece> o_starpieces2;
ArrayList<Starpiece> starpieces3;
ArrayList<Starpiece> o_starpieces3;

PImage whitestar;

//Meteors
ArrayList<Meteor> meteors;
ArrayList<Meteor> o_meteors;

//Game scenes
PImage titleScreen;

//Background Sky Images
ArrayList<PVector> bg_pos = new ArrayList<PVector>();
ArrayList<PVector> o_bg_pos = new ArrayList<PVector>();

PImage bg1;
PVector bg1_pos;
PVector o_bg1_pos;

PImage bg2;
PVector bg2_pos;
PVector o_bg2_pos;

PImage bg3;
PVector bg3_pos;
PVector o_bg3_pos;

PImage bg4;
PVector bg4_pos;
PVector o_bg4_pos;

PImage bg5;
PVector bg5_pos;
PVector o_bg5_pos;

PImage bg6;
PVector bg6_pos;
PVector o_bg6_pos;

//Clouds
PImage clouds;
PVector o_clouds_pos;
PVector clouds_pos;
PVector last_clouds_pos; //for "smoothly" changing scenes

//Arrow
PImage arrow;
PVector arrowPos;

//Fonts
PFont font;
PFont start;

//Time Counter
int s_began;
int s_end;

//----------------------------------------------------------------- Setup
void setup() {
  //Vertical playing area screen
  size(600, 700);
  surface.setTitle("Ayli: Star Seeker");
  
  //UI
  _ui = new UI();
  font = createFont("nineteenth.regular.otf", 48);
  start = createFont("GIMMICKY.TTF", 48);
  
  //Image assets
  smallBPPS = new PVector(0, height - 130);
  
  titleScreen = loadImage("titlescreen.png");
  
  whitestar = loadImage("star.png");
  
  bg1 = loadImage("orange_gradient.png"); //#FED73A to #FF7463 (bot to top)
  bg1_pos = new PVector(0, 0); 
  o_bg1_pos = new PVector(0, 0);
  bg_pos.add(bg1_pos);
  o_bg_pos.add(o_bg1_pos);
  
  bg2 = loadImage("purple_gradient.png"); //#FF7463 to #5C0093
  bg2_pos = new PVector(0, -height);
  o_bg2_pos = new PVector(0, -height);
  bg_pos.add(bg2_pos);
  o_bg_pos.add(o_bg2_pos);
  
  bg3 = loadImage("navy_gradient.png"); //#5C0093 to #000274
  bg3_pos = new PVector(0, -height);
  o_bg3_pos = new PVector(0, -height);
  bg_pos.add(bg3_pos);
  o_bg_pos.add(o_bg3_pos);
  
  bg4 = loadImage("darkteal_gradient.png");
  bg4_pos = new PVector();
  o_bg4_pos = new PVector();
  bg_pos.add(bg4_pos);
  o_bg_pos.add(o_bg4_pos);
  
  arrow = loadImage("arrow.png");
  arrowPos = new PVector(width/2 - 25, 0);
  
  clouds = loadImage("clouds_1.png");
  clouds_pos = new PVector(-50, -190);
  o_clouds_pos = new PVector(-50, -190);
  last_clouds_pos = new PVector(-50, clouds_pos.y + 780);
  
  //Initialize and add the goods
  InitializeAndAddPlatforms();
  
  //Keep track of the Starpieces
  starpieces1 = new ArrayList<Starpiece>();
  o_starpieces1 = new ArrayList<Starpiece>();
  starpieces2 = new ArrayList<Starpiece>();
  o_starpieces2 = new ArrayList<Starpiece>();
  starpieces3 = new ArrayList<Starpiece>();
  o_starpieces3 = new ArrayList<Starpiece>();
  
  //Keep track of the meteors
  meteors = new ArrayList<Meteor>();

  InitializeAndAddStarpieces();
  
  //This initializes Ayli.
  ayli = new Ayli(new PVector(20, 20), color(255), 20, _im, 
         new PVector(0, 0), new PVector(0, 1));
         
  cam = new Camera();
         
  groundY = height - ayli.size.y - 1;
  
  //Time
  s_began = millis() / 1000;
  s_end = millis() / 1000;
}

//----------------------------------------------------------------- Draw
//Updates every frame
void draw() {
  if(_sm.scene == 0) {
    _sm.DrawStartScreen();
  }
  
  else if(_sm.scene == 1) {
    s_end = millis() / 1000;
    
    CalcTimeElapsed();
    
    DrawTheBackground();
    
    if(!_stm.isChangingScreenForScenes) {
      DrawTheArrow();
    }
    
    DrawTheClouds();
    DrawTheUI();
    DrawAllPlatforms();
    
    if(!_stm.isChangingScreenForScenes)
      DrawTheStarpieces();
      DrawTheMeteors();
    
    _tm.Update(); 
    
    if(!_stm.isChangingScreenForScenes)
      FakeTheCamera();
    
    ayli.UpdateAyli();
    
    if(!_stm.isChangingScreenForScenes) {
      DrawParticles();
      DrawAylisTrail();
      cam.Update();
    }
  
    if(ayli.pos.y >= height - cam.botBuffer && !_stm.isChangingScreenForScenes) 
      FinishMovingDown();
      
    _stm.DetectStageChange();
  }
  else if(_sm.scene == 2) {
    _sm.DrawGameOverScreen();
  }
}

//------------------------------- Setup & Stage Manager Functions
void InitializeAndAddPlatforms() {
  if(_stm.currentStage == 1) {
    InitializeAddPlatforms_1();
  }
  if(_stm.currentStage == 2) {
    InitializeAddPlatforms_2();
  }
  if(_stm.currentStage == 3) {
    InitializeAddPlatforms_3();
  }
}

void InitializeAndAddStarpieces() {
  if(_stm.currentStage == 1) {
    InitializeAddStarpieces_1();
  }
  if(_stm.currentStage == 2) {
    InitializeAddStarpieces_2();
  }
  if(_stm.currentStage == 3) {
    InitializeAddStarpieces_3();
  }
}

void InitializeAddMeteors() {
  for(int i = 0; i < 15; i++) {
    Meteor thisMeteor = new Meteor();
    meteors.add(thisMeteor);
    Meteor o_thisMeteor = new Meteor();
    meteors.add(o_thisMeteor);
  }
}

//------------------------------- Stage-Dependent Draw Functions
void DrawTheMeteors() {
  for(int i = 0; i < meteors.size(); i++) {
    Meteor m = meteors.get(i);
    m.Update();
  }
}

void DrawTheStarpieces() {
  if(_stm.currentStage == 1) {
    for(int i = 0; i < starpieces1.size(); i++) {
      Starpiece s = starpieces1.get(i);
      s.Draw();
    }
  }
  if(_stm.currentStage == 2) {
    for(int i = 0; i < starpieces2.size(); i++){
      Starpiece s = starpieces2.get(i);
      s.Draw();
    }
  }
  if(_stm.currentStage == 3) {
    for(int i = 0; i < starpieces3.size(); i++){
      Starpiece s = starpieces3.get(i);
      s.Draw();
    }
  }
}

void DrawAllPlatforms() { 
  //Stage 1 platforms
  if(_stm.currentStage == 1) {
    for(int i = 0; i < platforms1.size(); i++) {
      Platforms p = platforms1.get(i);
      p.DrawPlatform();
    } 
  }
  if(_stm.currentStage == 2) {
    for(int i = 0; i < platforms2.size(); i++) {
      Platforms p = platforms2.get(i);
      p.DrawPlatform();
    } 
  }
  if(_stm.currentStage == 3) {  
    for(int i = 0; i < platforms3.size(); i++) {
      Platforms p = platforms3.get(i);
      p.DrawPlatform();
    } 
  }
}

void DrawTheUI() {
  _ui.display("stage");
  _ui.display("score");
}

void DrawTheBackground() {
  noTint();
  if(_stm.currentStage == 1) {
    image(bg1, bg_pos.get(0).x, bg_pos.get(0).y);
    image(bg2, bg_pos.get(1).x, bg_pos.get(1).y);
  }
  if(_stm.currentStage == 2) {    
    image(bg2, bg_pos.get(1).x, bg_pos.get(1).y);
    image(bg3, bg_pos.get(2).x, bg_pos.get(2).y);
  }
  if(_stm.currentStage == 3) {  
    image(bg3, bg_pos.get(2).x, bg_pos.get(2).y);
    image(bg4, bg_pos.get(3).x, bg_pos.get(3).y);
  }
}

void DrawTheClouds() {
  image(clouds, clouds_pos.x, clouds_pos.y); //Left Cloud
  image(clouds, clouds_pos.x + 300, clouds_pos.y); //Right Cloud
  
  //Bottom clouds
  image(clouds, clouds_pos.x, last_clouds_pos.y);
  image(clouds, clouds_pos.x + 300, last_clouds_pos.y);
}

void DrawTheArrow() {
    image(arrow, arrowPos.x, arrowPos.y, 60, 60);
}

//------------------------------- Key Input Functions 
void keyPressed() {
  if(!_stm.isChangingScreenForScenes) {
    if(key == 'A' || key == 'a' || keyCode == LEFT) {
      _im.wasPressed("left"); 
    }
    if(key == 'D' || key == 'd' || keyCode == RIGHT) {
      _im.wasPressed("right"); 
    }
    if(key == 'W' || key =='w' || keyCode == UP) {
      _im.wasPressed("jump");
    }
  }
}

void keyReleased() {
  if(!_stm.isChangingScreenForScenes) {
    if(key == 'A' || key == 'a' || keyCode == LEFT) {
      _im.wasReleased("left"); 
    }
    if(key == 'D' || key == 'd' || keyCode == RIGHT) {
      _im.wasReleased("right"); 
    }
    if(key == 'W' || key == 'w' || keyCode == UP) { 
      _im.wasReleased("jump");
    }
  }
}

void mouseClicked() {
  if(_sm.scene == 0) {
    if((mouseX >= (_sm.titleP.x-50)) //press start
        && (mouseX <= (_sm.titleP.x-50 + 200)) 
        && (mouseY >= (_sm.titleP.y-60)) 
        && (mouseY <= (_sm.titleP.y-60 + 90))) {
          _sm.scene = 1;
     }
  }
}
