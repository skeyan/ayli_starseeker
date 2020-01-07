class Camera {
  PVector pos;

  float topBuffer;
  float botBuffer;
  
  Camera() {
    pos = new PVector();
    
    topBuffer = 250;
    botBuffer = 250;
  }
  
  //Member functions go below
  void Update() {    
    if(ayli.vel.y!= 0) {
      pos.y = ayli.yDelta;
    }
    else {
      pos.y = 0;
    }
  }
}

void FakeTheCamera() {
  if(ayli.pos.y < height - cam.botBuffer) {
      //Ayli is going up
      if(ayli.vel.y < 0) {
        MoveStuffDown();
      }
      //Ayli is falling down
      else if(ayli.vel.y > 0) {
        MoveStuffUp();
      }
   }
}

//---------------------------------------------------------------------------------------- Camera Fxns (Stage-Dependent):
//Simulate camera movement as Ayli falls
void MoveStuffUp() {
  //Ayli & Ground
  ayli.pos.y -= cam.pos.y;
  groundY -= cam.pos.y;
  
  //Clouds
  clouds_pos.y -= cam.pos.y * 0.5; //things in the distance move slower
  last_clouds_pos.y -= cam.pos.y * 0.5;
  
  //Arrow
  arrowPos.y -= cam.pos.y;

  
  //BG
  for(int i = _stm.currentStage - 1; i < _stm.currentStage + 1; i++) {
    PVector thisPV = bg_pos.get(i);
    thisPV.y -= cam.pos.y; 
  }

  if(_stm.currentStage == 1) { //STAGE 1
    //Starpieces
    for(int i = 0; i < starpieces1.size(); i++) {
      Starpiece sp = starpieces1.get(i);
      sp.pos.y -= cam.pos.y;
    }
     
    //Platforms
    for(int i = 0; i < platforms1.size(); i++) {
      Platforms thisPlat = platforms1.get(i);
      thisPlat.pos.y -= cam.pos.y;
    }
  }
  
  if(_stm.currentStage == 2) { //STAGE 2
    //Meteors
    for(int i = 0; i < meteors.size(); i++) {
      Meteor m = meteors.get(i);
      m.pos.y -= cam.pos.y;
    }
    //Starpieces
    for(int i = 0; i < starpieces2.size(); i++) {
      Starpiece sp = starpieces2.get(i);
      sp.pos.y -= cam.pos.y;
    }
     
    //Platforms
    for(int i = 0; i < platforms2.size(); i++) {
      Platforms thisPlat = platforms2.get(i);
      thisPlat.pos.y -= cam.pos.y;
    }
  }
  
  if(_stm.currentStage == 3) { //STAGE 3
    //Meteors
    for(int i = 0; i < meteors.size(); i++) {
      Meteor m = meteors.get(i);
      m.pos.y -= cam.pos.y;
    }
    //Starpieces
    for(int i = 0; i < starpieces3.size(); i++) {
      Starpiece sp = starpieces3.get(i);
      sp.pos.y -= cam.pos.y;
    }
     
    //Platforms
    for(int i = 0; i < platforms3.size(); i++) {
      Platforms thisPlat = platforms3.get(i);
      thisPlat.pos.y -= cam.pos.y;
    }
  }
  
}

//Simulate camera movement as Ayli jumps
void MoveStuffDown() {
  //BG
  for(int i = _stm.currentStage - 1; i < _stm.currentStage + 1; i++) {
    PVector thisPV = bg_pos.get(i);
    thisPV.y += cam.pos.y; 
  }
  
  //Ayli & Ground
  ayli.pos.y += cam.pos.y;
  groundY += cam.pos.y;
  
  //Arrow
  arrowPos.y += cam.pos.y;
  
  //Clouds
  clouds_pos.y += cam.pos.y * 0.5;
  last_clouds_pos.y += cam.pos.y * 0.5;

  if(_stm.currentStage == 1) { //STAGE 1
    //Starpieces
    for(int i = 0; i < starpieces1.size(); i++) {
      Starpiece sp = starpieces1.get(i);
      sp.pos.y += cam.pos.y;
    }
     
    //Platforms
    for(int i = 0; i < platforms1.size(); i++) {
      Platforms thisPlat = platforms1.get(i);
      thisPlat.pos.y += cam.pos.y;
    }
  }
  
  if(_stm.currentStage == 2) { //STAGE 2
    //Meteors
    for(int i = 0; i < meteors.size(); i++) {
      Meteor m = meteors.get(i);
      m.pos.y += cam.pos.y;
    }
    //Starpieces
    for(int i = 0; i < starpieces2.size(); i++) {
      Starpiece sp = starpieces2.get(i);
      sp.pos.y += cam.pos.y;
    }
     
    //Platforms
    for(int i = 0; i < platforms2.size(); i++) {
      Platforms thisPlat = platforms2.get(i);
      thisPlat.pos.y += cam.pos.y;
    }
  }
  
  if(_stm.currentStage == 3) { //STAGE 3
    //Meteors
    for(int i = 0; i < meteors.size(); i++) {
      Meteor m = meteors.get(i);
      m.pos.y += cam.pos.y;
    }
    //Starpieces
    for(int i = 0; i < starpieces3.size(); i++) {
      Starpiece sp = starpieces3.get(i);
      sp.pos.y += cam.pos.y;
    }
     
    //Platforms
    for(int i = 0; i < platforms3.size(); i++) {
      Platforms thisPlat = platforms3.get(i);
      thisPlat.pos.y += cam.pos.y;
    }
  }
  
}

//Ayli's trajectory travelled =/= the amount the other things have to move
//Finish moving the rest of the way while Ayli falls
//As a result, Ayli is not included in this function to be moved
void FinishMovingDown() {
  //BG
  for(int i = _stm.currentStage - 1; i < _stm.currentStage + 1; i++) {
     o_bg_pos.get(_stm.currentStage - 1).x = 0; //prevent overlap after changing stages
     o_bg_pos.get(_stm.currentStage - 1).y = 0;
     PVector thisPV = bg_pos.get(i);
     PVector oldPV = o_bg_pos.get(i);
     int bgamountLeftToGo = int(thisPV.y - oldPV.y);
     thisPV.y -= bgamountLeftToGo / 3;      
  }
  
  //Ground
  int amountLeftToGo = int(groundY - 679);
    groundY -= amountLeftToGo / 20;
     
  //Platforms + Stars
  if(_stm.currentStage == 1) { //STAGE 1
    for(int i = 0; i < platforms1.size(); i++) {
      Platforms thisPlat = platforms1.get(i);
      Platforms origPlat = o_platforms1.get(i);
      int plamountLeftToGo = int(thisPlat.pos.y - origPlat.pos.y);
      thisPlat.pos.y -= plamountLeftToGo / 3;
    }
    
    //Starpieces
    for(int i = 0; i < starpieces1.size(); i++) {
      Starpiece sp = starpieces1.get(i);
      Starpiece osp = o_starpieces1.get(i);
      int spALTG = int(sp.pos.y - osp.pos.y);
      sp.pos.y -= spALTG / 3;
    }
  }
  if(_stm.currentStage == 2) { //STAGE 2
    //Platforms
    for(int i = 0; i < platforms2.size(); i++) {
      Platforms thisPlat = platforms2.get(i);
      Platforms origPlat = o_platforms2.get(i);
      int plamountLeftToGo = int(thisPlat.pos.y - origPlat.pos.y);
      thisPlat.pos.y -= plamountLeftToGo / 3;
    }
    
    //Starpieces
    for(int i = 0; i < starpieces2.size(); i++) {
      Starpiece sp = starpieces2.get(i);
      Starpiece osp = o_starpieces2.get(i);
      int spALTG = int(sp.pos.y - osp.pos.y);
      sp.pos.y -= spALTG / 3;
    }
  }
  if(_stm.currentStage == 3) {  
    for(int i = 0; i < platforms3.size(); i++) {
      Platforms thisPlat = platforms3.get(i);
      Platforms origPlat = o_platforms3.get(i);
      int plamountLeftToGo = int(thisPlat.pos.y - origPlat.pos.y);
      thisPlat.pos.y -= plamountLeftToGo / 3;
    }
    
    //Starpieces
    for(int i = 0; i < starpieces3.size(); i++) {
      Starpiece sp = starpieces3.get(i);
      Starpiece osp = o_starpieces3.get(i);
      int spALTG = int(sp.pos.y - osp.pos.y);
      sp.pos.y -= spALTG / 3;
    }
  }
  
  //Arrow
  int arrowAmountLeftToGo = int(arrowPos.y);
  arrowPos.y -= arrowAmountLeftToGo / 3;
  
  //Clouds
  int camountLeftToGo = int(clouds_pos.y - o_clouds_pos.y);
  clouds_pos.y -= camountLeftToGo / 3;
  int coamountLeftToGo = int(last_clouds_pos.y - 590);
  last_clouds_pos.y -= coamountLeftToGo / 3;
}
