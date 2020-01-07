//Jump land effect particle system class
//Inspiration from https://www.youtube.com/watch?v=krRpZFU6rSI
class Particle {
  //Class Variables
  PVector loc;
  PVector vel;
  PVector acc;
  ArrayList<PVector> history;
  
  float lifespan = 255;
  
  //Constructor
  Particle(PVector l) {
    acc = new PVector(0, -1);
    vel = new PVector(-random(-5, 5), -random(0, 5));
    loc = l;
    history = new ArrayList<PVector>();
  }

  //Member functions
  void Update() {
    //Move it
    vel = AddPVector(vel, acc);
    loc = AddPVector(loc, vel);
    
    //Remember where it has been to make a trail when needed
    //Each particle keeps its own history trail
    if(history.size() <= 3) {
      history.add(new PVector(loc.x, loc.y, lifespan));
    }

    //Will eventually fade away
    lifespan -= 90;
  }
}

//-------------------------------------------- Particle Related Functions
void DrawParticles() {
  //Remove remaining particles
  if(particleHistList.size() > 5) {
    for(int i = 4; i >= 0; i--) {
      particleHistList.remove(i);
    }
  }
  
  //Draw particles
  for(int i = 0; i < particleHistList.size(); i++) {
    Particle thisPart = particleHistList.get(i);
    for(int j = 0; j < thisPart.history.size(); j++) {
      stroke(255, thisPart.history.get(j).z);
      strokeWeight(0.6);
      if(_stm.currentStage == 1)
        fill(120, 226, 255, thisPart.history.get(j).z);
      if(_stm.currentStage == 2)
        fill(255, 243, 115, thisPart.history.get(j).z);
      if(_stm.currentStage == 3)
        fill(149, 194, 245, thisPart.history.get(j).z);
      
      ellipse(thisPart.history.get(j).x, thisPart.history.get(j).y, 8, 8);
    }
  }
  
  //Fade particles on screen
  for(int i = 0; i < particleHistList.size(); i++) {
    Particle thisPart = particleHistList.get(i);
    for(int j = 0; j < thisPart.history.size(); j++){
      thisPart.history.get(j).z -= 11;
    }
  }
}
