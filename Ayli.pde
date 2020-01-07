class Ayli {
  PVector size;
  color myColor;
  
  PVector pos;
  PVector vel;
  PVector accel;
  
  ArrayList<PVector> history; //size of 300
  float lifespan = 200;
  //int onPlatform;
  
  float yDelta;
  float oldY;
  
  boolean isGrounded;
  boolean isOnAPlatform;
  boolean hasParticled;

  int distanceFromBottom;
  
  InputManager inputs;
  
  //speed is px/sec
  Ayli(PVector s, color c, int d, InputManager i, PVector v, PVector a) {
    size = s;
    myColor = c;
    distanceFromBottom = d;
    inputs = i;
    vel = v;
    accel = a;
    yDelta = 0;
    //onPlatform = -1;
    history = new ArrayList<PVector>();
    isGrounded = true;
    isOnAPlatform = false;
    hasParticled = false;
    pos = new PVector(width/2, height - distanceFromBottom - 1);
    oldY = pos.y;
  }
  
  void UpdateAyli() {
    if(!_stm.isChangingScreenForScenes) {
       ApplyVandA();     
    }
     
     CheckCollisionWithGround();
     CheckCollisionWithStarpieces();
     
     //If falling, check for collision with platforms.
     if(vel.y > 0 && !isGrounded && !isOnAPlatform) {
       CheckCollisionWithPlatforms();
     }
     
     if(AmOffAnyPlatform()) {
       CheckCollisionWithPlatforms();
     }
     
     if(isGrounded) {
       vel.y = 0;
       //onPlatform = -1;
     }
     
     if(!isGrounded && !isOnAPlatform) {
       hasParticled = false;
     }

     if(inputs.isLeft) {
       vel.x = -4.4;
     }
     if(inputs.isRight) {
       vel.x = 4.4;
     }
     if(!inputs.isLeft && !inputs.isRight) {
       vel.x = 0; 
     }
     if(inputs.isJumping && isGrounded) {
       if(_stm.currentStage == 1) {
         vel.y = -27; //jump boost when first on ground
       }
       else {
         vel.y -= 17;
       }
       isGrounded = false;
     }

     if(inputs.isJumping && isOnAPlatform) {
       vel.y = -17;
       isOnAPlatform = false;
        //onPlatform = -1;
     }
    
       
     //Constrain to screen 
     rectMode(CORNER);
     if(pos.y >= height - cam.botBuffer) {
       groundY = 680; 
     } 
     pos.x = constrain(pos.x, 0, 600 - size.x);
     pos.y = constrain(pos.y, 0, groundY);
     
     CalcYDelta();
     
     //Only draw the trail when Ayli is moving to avoid stationary particle blobs
     if(vel.x != 0 || vel.y != 0) {
       UpdateTrail();
     }
     DrawAyli();
  }
  
  //Physics function
  void ApplyVandA() {
    //Acceleration affects velocity
    vel.x += accel.x;
    if(!isOnAPlatform && !isGrounded) {
      vel.y += accel.y;
    }
    
    //Velocity affects position
    pos.x += vel.x;
    if(!isOnAPlatform && !isGrounded) {
      pos.y += vel.y;
    }
  }
  
  void CalcYDelta() {
    yDelta = abs(pos.y - oldY);
    oldY = pos.y;
  }
  
  //Check collisions with platforms
  void CheckCollisionWithGround() {    
    //If on the ground, set boolean for can Jump again. 
    //This is because the player's manual control to activate Jump only
    //occurs when they're on the Ground. 
    if(pos.y >= groundY) {
      isGrounded = true;
      //Particle effect
      if(!hasParticled) {
        CreateParticles();
      }
      
      hasParticled = true;
    }
    else {
      isGrounded = false;
    }
  }
  
  //This function gets called whenever Ayli's velocity is >= 0 (falling).
  void CheckCollisionWithPlatforms() {
    
    if(_stm.currentStage == 1) {
      for(int i = 0; i < platforms1.size(); i++) {
        Platforms currentPlat = platforms1.get(i);
        if(AreTheseRectanglesColliding(pos, size, currentPlat.pos, currentPlat.size)) {

          //If colliding with that platform and falling, 
          //set isOnAPlatform true.
          Land(currentPlat.pos.y);
          
          //Particle effect
          if(!hasParticled) {
            CreateParticles();
          } 
          hasParticled = true;
          return;
        }
      }
    }
    if(_stm.currentStage == 2) {
      for(int i = 0; i < platforms2.size(); i++) {
        Platforms currentPlat = platforms2.get(i);
        if(AreTheseRectanglesColliding(pos, size, currentPlat.pos, currentPlat.size)) {
          //If colliding with that platform and falling, set isOnAPlatform true.
          Land(currentPlat.pos.y);
          //Particle effect
          if(!hasParticled) {
            CreateParticles();
          } 
          hasParticled = true;
          return;
        }
      }
    }
    if(_stm.currentStage == 3) {
      for(int i = 0; i < platforms3.size(); i++) {
        Platforms currentPlat = platforms3.get(i);
        if(AreTheseRectanglesColliding(pos, size, currentPlat.pos, currentPlat.size)) {
          //If colliding with that platform and falling, set isOnAPlatform true.
          Land(currentPlat.pos.y);
          //Particle effect
          if(!hasParticled) {
            CreateParticles();
          } 
          hasParticled = true;
          return;
        }
      }
    }
    isOnAPlatform = false;
  }
  
  void CheckCollisionWithStarpieces() {
    if(_stm.currentStage == 1) {
      for(int i = 0; i < starpieces1.size(); i++) {
        Starpiece sp = starpieces1.get(i);
        if(AreTheseRectanglesColliding(pos, size, sp.pos, 
            new PVector(sp.size, sp.size))) {
              //If colliding with that starpiece,
              //1. increase score by 1, 2. remove starpiece from starpiece arraylist so no longer drawn/detected,
              _ui.score++;
              starpieces1.remove(i);
              o_starpieces1.remove(i);
            }
      }
    }
    if(_stm.currentStage == 2) {
      for(int i = 0; i < starpieces2.size(); i++) {
        Starpiece sp = starpieces2.get(i);
        if(AreTheseRectanglesColliding(pos, size, sp.pos, 
            new PVector(sp.size, sp.size))) {
              //If colliding with that starpiece,
              //1. increase score by 1, 2. remove starpiece from starpiece arraylist so no longer drawn/detected,
              _ui.score++;
              starpieces2.remove(i);
              o_starpieces2.remove(i);
            }
      }
    }    
    if(_stm.currentStage == 3) {
      for(int i = 0; i < starpieces3.size(); i++) {
        Starpiece sp = starpieces3.get(i);
        if(AreTheseRectanglesColliding(pos, size, sp.pos, 
            new PVector(sp.size, sp.size))) {
              //If colliding with that starpiece,
              //1. increase score by 1, 2. remove starpiece from starpiece arraylist so no longer drawn/detected,
              _ui.score++;
              starpieces3.remove(i);
              o_starpieces3.remove(i);
            }
      }
    }
  }
  
  boolean AmOffAnyPlatform() {
    if(_stm.currentStage == 1) {
      for(int i = 0; i < platforms1.size(); i++) {
        Platforms currentPlat = platforms1.get(i);
        if(pos.x + size.x < currentPlat.pos.x || pos.x > currentPlat.pos.x + currentPlat.size.x) {
          return true;
        }
      }
    }
    if(_stm.currentStage == 2) {
      for(int i = 0; i < platforms2.size(); i++) {
        Platforms currentPlat = platforms2.get(i);
        if(pos.x + size.x < currentPlat.pos.x || pos.x > currentPlat.pos.x + currentPlat.size.x) {
          return true;
        }
      }
    }
    if(_stm.currentStage == 3) {
      for(int i = 0; i < platforms3.size(); i++) {
        Platforms currentPlat = platforms3.get(i);
        if(pos.x + size.x < currentPlat.pos.x || pos.x > currentPlat.pos.x + currentPlat.size.x) {
          return true;
        }
      }
    }
    return false;
  }
  
  void Land(float destPosY) {
    vel.y = 0;
    isOnAPlatform = true;
    pos.y = destPosY - size.y;
  }
  
  void UpdateTrail() {
    if(history.size() <= 300) {
      history.add(new PVector(pos.x + size.x / 4, pos.y + size.y / 4, lifespan));
    } 
  }
  
  void CreateParticles() {
    for(int j = 0; j < 5; j++) {
      Particle newPart = new Particle(new PVector(pos.x + size.x/2, pos.y + size.y));
      for(int l = 0; l < 5; l++) {
        newPart.Update();
      }   
      particleHistList.add(newPart);
    }
  }
  
  //Draw Ayli's sprite
  void DrawAyli() {
    if(_stm.currentStage == 1) 
      stroke(250, 212, 100);
    if(_stm.currentStage == 2)
      stroke(255, 235, 51);
    if(_stm.currentStage == 3)
      stroke(87, 179, 175);
      
    strokeWeight(3);
    fill(myColor);
    rect(pos.x, pos.y, size.x, size.y);
  }
}

//------------------------------------------ Ayli Related Functions
void DrawAylisTrail() {
  for(int i = 0; i < ayli.history.size(); i += 2) {
    noStroke();
    fill(255, ayli.history.get(i).z);
    rect(ayli.history.get(i).x, ayli.history.get(i).y, 10, 10); 
  }
  
  if(ayli.history.size() > 300) {
    for(int i = 299; i >= 0; i--) {
      ayli.history.remove(i);
    }
  }
  
  for(int i = 0; i < ayli.history.size(); i++) {
    ayli.history.get(i).z -= 5;
  }
}
