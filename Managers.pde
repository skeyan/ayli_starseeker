//--------------------------------------------------- Input Manager
class InputManager {
  //Class variables
  boolean isLeft;
  boolean isRight;
  boolean isJumping;

  //Constructor
  InputManager() { 
  }
  
  //Member functions
  void wasPressed(String keyThatWasPressed) {
    if(keyThatWasPressed == "left") {
       isLeft = true;
    }
    else if(keyThatWasPressed == "right") {
      isRight = true; 
    }
    else if(keyThatWasPressed == "jump") {
      isJumping = true; 
    }
  }
  void wasReleased(String keyThatWasReleased) {
    if(keyThatWasReleased == "left") {
       isLeft = false;
    }
    else if(keyThatWasReleased == "right") {
      isRight = false; 
    }
    else if(keyThatWasReleased == "jump") {
      isJumping = false; 
    }
  }
}

//--------------------------------------------------- Time Manager

class TimeManager {
  float deltaMillis;
  float deltaTime;
  int lastMillis;
  int currentMillis;
  
  TimeManager() { 
  }
  
  //Does the math
  void Update() {
    currentMillis = millis();
    deltaMillis = millis() - lastMillis;
    deltaTime = deltaMillis / 1000;
    lastMillis = currentMillis;
  }
}

//--------------------------------------------------- Stage Manager
class StageManager {
  int currentStage;
  boolean isChangingScreenForScenes;
  
  StageManager() { 
    currentStage = 1; 
    isChangingScreenForScenes = false;
  }
  
  void DetectStageChange() {
    if(currentStage == 1 && _ui.score == 3) {
      _stm.isChangingScreenForScenes = true;
    }
    if(currentStage == 2 && _ui.score == 14) {
      _stm.isChangingScreenForScenes = true;
    }
    if(currentStage == 3 && _ui.score == 25) {
      _sm.scene = 2;
    }
    if(_stm.isChangingScreenForScenes) {
      ShiftStageScreenDown();
    }
  }
  
  //Keep track of what "stage" you're on
  //One size fits all function
  void ChangeStage(int nextStage) {
    currentStage = nextStage;
    _ui.stageAlpha = 0; //re-fade in
    InitializeAndAddPlatforms();
    InitializeAndAddStarpieces();
    InitializeAddMeteors();
  }
}

void ShiftStageScreenDown() {
  if(clouds_pos.y <= last_clouds_pos.y - clouds.height) {
    ayli.vel.y = 0;
    ayli.yDelta = 0;
    cam.pos.y = 0;
    ayli.oldY = 0;
    //Arrow
    arrowPos.y = 0;
    
    for(int i = _stm.currentStage - 1; i < _stm.currentStage + 1; i++) {
      PVector thisPV = bg_pos.get(i);
      thisPV.y +=  350 * _tm.deltaTime; 
    }
  
    ayli.pos.y += 350 * _tm.deltaTime;
    groundY += 350 * _tm.deltaTime;
    clouds_pos.y += 350 * _tm.deltaTime;
    
    for(int i = ayli.history.size() - 1; i >= 0; i--) {
      ayli.history.remove(i);
    }
    
    for(int i = particleHistList.size() - 1; i >= 0; i--) {
      particleHistList.remove(i);
    }
    
    for(int i = meteors.size() -1; i >= 0; i--) {
      meteors.remove(i);
    }
  
    for(int i = 0; i < platforms1.size(); i++) {
      Platforms thisPlat = platforms1.get(i);
      thisPlat.pos.y += 350 * _tm.deltaTime;
    }
    
    for(int i = 0; i < platforms2.size(); i++) {
      Platforms thisPlat = platforms2.get(i);
      thisPlat.pos.y += 350 * _tm.deltaTime;
    }
  }
  else {
    ayli.isGrounded = true;
    ayli.isOnAPlatform = false;
    
    //Put the clouds/reset the clouds back on top after you copy the last value
    last_clouds_pos = clouds_pos;
    clouds_pos = new PVector(-50, -190);
    o_clouds_pos = new PVector(-50, -190);

    _im.isLeft = false;
    _im.isRight = false;
    _im.isJumping = false;
    
    if(_stm.currentStage == 1) {
      _stm.ChangeStage(2);
    }
    else if(_stm.currentStage == 2) {
      _stm.ChangeStage(3);
    }
    if(_stm.currentStage == 2) {
      //Set the next stage's bg to -height
      bg_pos.get(1).y = 0;
      bg_pos.get(2).y = -height;
      o_bg_pos.get(1).y = 0;
      o_bg_pos.get(2).y = -height;
    }
    if(_stm.currentStage == 3) {
      //Set the next stage's bg to -height
      bg_pos.get(2).y = 0;
      bg_pos.get(3).y = -height;
      o_bg_pos.get(2).y = 0;
      o_bg_pos.get(3).y = -height;
    }
    _stm.isChangingScreenForScenes = false;
  }
}

class SceneManager {
  int scene;
  color titleC;
  PVector titleP;
  int titleSize;
  int titleA;
  
  SceneManager() {
    scene = 0;
    titleA = 150;
    titleC = color(255);
    titleP = new PVector(300 - 70, 560);
    titleSize = 42;
  }
  
  void DrawStartScreen() {
    if((mouseX >= (_sm.titleP.x-50)) //press start
    && (mouseX <= (_sm.titleP.x-50 + 200)) 
    && (mouseY >= (_sm.titleP.y-60)) 
    && (mouseY <= (_sm.titleP.y-60 + 90))) {
      if(titleA != 255) {
        titleA = 255;
      }
    }
    else {
      if(titleA != 150) {
       titleA = 150; 
      }
    }
    
    image(titleScreen, 0, 0);
    stroke(255);
    strokeWeight(3);
    noFill();
    rect(_sm.titleP.x-50, _sm.titleP.y-60, 200, 90);
    
    noStroke();
    fill(titleC, titleA);
    textFont(start);
    textAlign(LEFT);
    textSize(titleSize);
    text("Start", titleP.x, titleP.y);
  }

  void DrawGameOverScreen() {
    //BG
    image(bg4, 0, 0);
    
    //Time elapsed
    noStroke();
    fill(titleC);
    textFont(start);
    textAlign(CENTER);
    textSize(60);
    text("Time passed:", width/2, 300);
    textSize(90);
    textFont(font);
    text(_ui.timeElapsed+" seconds!", width/2, height/2 + 60);
    
    //how to restart
    noStroke();
    fill(titleC);
    textFont(font);
    textAlign(CENTER);
    textSize(titleSize);
    text("Reopen to Restart!", width/2, height - 150);
  }
}
