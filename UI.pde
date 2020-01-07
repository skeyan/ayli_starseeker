class UI {
  PVector stagePos;
  int stageAlpha;
  int timeElapsed = 0;
  
  PVector scorePos;
  int score;
  int scoreAlpha;
  
  color color1 = color(56, 32, 0);
  color color2 = color(35, 7, 66);
  color color3 = color(0, 224, 240);
  
  UI() {
    stagePos = new PVector(width - 10, height - 30);
    score = 0;
    stageAlpha = 0;
    scorePos = new PVector(width - 10, height - 62);
    scoreAlpha = 0;
  }
 
  
  void display(String whatToDisplay) {
    textFont(font);
    textAlign(RIGHT);
    textSize(28);
    
    if(whatToDisplay == "stage") {
      if(_stm.currentStage == 1) {  
        fill(color1, stageAlpha);
        text("time: "+timeElapsed, stagePos.x, stagePos.y);
        text("sunset", stagePos.x, stagePos.y - 65);
      }
      if(_stm.currentStage == 2) {
        fill(color2, stageAlpha);
        text("time: "+timeElapsed, stagePos.x, stagePos.y);
        text("meridian", stagePos.x, stagePos.y - 65);
      }
      if(_stm.currentStage == 3) {
        fill(color3, stageAlpha);
        text("time: "+timeElapsed, stagePos.x, stagePos.y);
        text("exosphere", stagePos.x, stagePos.y - 65);
      }
      if(stageAlpha < 245) {
        stageAlpha += 2;
      }
    }
    
    if(whatToDisplay == "score") {
      textSize(28);
      if(_stm.currentStage == 1)
        text("stars: "+score+"/3", scorePos.x, scorePos.y);
      if(_stm.currentStage == 2)
        text("stars: "+score+"/13", scorePos.x, scorePos.y);
      if(_stm.currentStage == 3)
        text("stars: "+score+"/25", scorePos.x, scorePos.y);
      
      if(scoreAlpha < 245) {
        scoreAlpha += 1;
      }
    }
  } 
}

void CalcTimeElapsed() {
  _ui.timeElapsed = s_end - s_began;
}
