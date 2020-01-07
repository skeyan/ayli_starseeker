class Meteor {
  color Color;
  PVector pos = new PVector();
  float size;
  float vel;
  float grav;
  float choice;
  float distance;
  ArrayList<PVector> history;
  
  Meteor() {
    history = new ArrayList<PVector>();
    grav = 3;
    choice = random(2);
    Color = color(255, 255, 255);
    distance = random(0, 20); //0 - faraway; 20 - close
    size = map(distance, 0, 20, 2, 5);
    if(choice <= 1) {
      pos = new PVector(random(0, width-size), random(-900, -100)); //start offscreen
    }
    else if(choice <= 2) {
      pos = new PVector(random(0, width-size), random(-500, -200)); //start offscreen
    }
    
    vel = map(distance, 0, 20, 1, 2);
  }
  
  void Update() {
    Fall();
    Draw();
  }
  
  void Fall() {
    pos.y += vel;
    if(pos.y >= height - size) {
      pos = new PVector(random(0, width-size), random(-600, -400));
      vel = map(distance, 0, 20, 1, 2);
    }
  }
  
  void Draw() {
    noStroke();
    fill(Color, 200);
    rect(pos.x, pos.y, size, size);
  }
}


//------------------------------------------------------------------------------------- Starpieces
class Starpiece {
  color c;
  PVector pos = new PVector();
  float size;
  int alpha;
  boolean dimmed;
  
  Starpiece(color Color, PVector p, float s) {
    c = Color;
    pos = p;
    size = s;
    alpha = 200;
    dimmed = false;
  }
  
  void Draw() {
    //circle "glowy" thing
    noStroke();
    fill(255, 251, 179, alpha);
    ellipse(pos.x + size/2, pos.y + size/2, size + 10, size + 10);
    
    //actual rectangle for collision
    fill(c, 0);
    rect(pos.x, pos.y, size, size);
    image(whitestar, pos.x, pos.y, 8, 8);
    
    if(alpha > 100 && !dimmed) //fade to 100
      alpha -= 3;
    else if(alpha <= 100 && !dimmed) { //finished fading to 100
      dimmed = true;
    }
    else if(dimmed && alpha < 200) { //finished dimming, haven't reached 200
      alpha += 3;
    }
    else if(dimmed && alpha >= 200) { //dim again after reaching 200
      dimmed = false;
    }
  }
}

void InitializeAddStarpieces_1() {
  Starpiece thisSP = new Starpiece(color(255, 112, 200), new PVector(platforms1.get(0).pos.x + platformSize.x/2, platforms1.get(0).pos.y - 20), 7);
  starpieces1.add(thisSP);
  Starpiece o_thisSP = new Starpiece(color(255, 112, 200), new PVector(platforms1.get(0).pos.x + platformSize.x/2, platforms1.get(0).pos.y - 20), 7);
  o_starpieces1.add(o_thisSP);
  
  Starpiece thisSP2 = new Starpiece(color(255, 112, 200), new PVector(platforms1.get(2).pos.x + platformSize.x/2, platforms1.get(2).pos.y - 20), 7);
  starpieces1.add(thisSP2);
  Starpiece o_thisSP2 = new Starpiece(color(255, 112, 200), new PVector(platforms1.get(2).pos.x + platformSize.x/2, platforms1.get(2).pos.y - 20), 7);
  o_starpieces1.add(o_thisSP2);
  
  Starpiece thisSP3 = new Starpiece(color(255, 112, 200), new PVector(platforms1.get(5).pos.x + platformSize.x/2, platforms1.get(5).pos.y - 20), 7);
  starpieces1.add(thisSP3);
  Starpiece o_thisSP3 = new Starpiece(color(255, 112, 200), new PVector(platforms1.get(5).pos.x + platformSize.x/2, platforms1.get(5).pos.y - 20), 7);
  o_starpieces1.add(o_thisSP3);
}

void InitializeAddStarpieces_2() {
  Starpiece thisSP = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(2).pos.x + platformSize.x/2, platforms2.get(2).pos.y - 20), 7);
  starpieces2.add(thisSP);
  Starpiece o_thisSP = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(2).pos.x + platformSize.x/2, platforms2.get(2).pos.y - 20), 7);
  o_starpieces2.add(o_thisSP);
  //Platform 0 Arc
  Starpiece thisSP2 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(0).pos.x + platformSize.x - 15, platforms2.get(0).pos.y - 30), 7);
  starpieces2.add(thisSP2);
  Starpiece o_thisSP2 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(0).pos.x + platformSize.x - 15, platforms2.get(0).pos.y - 30), 7);
  o_starpieces2.add(o_thisSP2);
  Starpiece thisSP3 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(0).pos.x + platformSize.x, platforms2.get(0).pos.y - 65), 7);
  starpieces2.add(thisSP3);
  Starpiece o_thisSP3 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(0).pos.x + platformSize.x, platforms2.get(0).pos.y - 65), 7);
  o_starpieces2.add(o_thisSP3);
  Starpiece thisSP4 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(0).pos.x + 16 + platformSize.x, platforms2.get(0).pos.y - 90), 7);
  starpieces2.add(thisSP4);
  Starpiece o_thisSP4 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(0).pos.x + 16 + platformSize.x, platforms2.get(0).pos.y - 90), 7);
  o_starpieces2.add(o_thisSP4);
  //Platform 4 Arc
  Starpiece thisSP5 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(4).pos.x + platformSize.x - 15, platforms2.get(4).pos.y - 30), 7);
  starpieces2.add(thisSP5);
  Starpiece o_thisSP5 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(4).pos.x + platformSize.x - 15, platforms2.get(4).pos.y - 30), 7);
  o_starpieces2.add(o_thisSP5);
  Starpiece thisSP6 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(4).pos.x + platformSize.x, platforms2.get(4).pos.y - 65), 7);
  starpieces2.add(thisSP6);
  Starpiece o_thisSP6 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(4).pos.x + platformSize.x, platforms2.get(4).pos.y - 65), 7);
  o_starpieces2.add(o_thisSP6);
  Starpiece thisSP7 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(4).pos.x + 16 + platformSize.x, platforms2.get(4).pos.y - 90), 7);
  starpieces2.add(thisSP7);
  Starpiece o_thisSP7 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(4).pos.x + 16 + platformSize.x, platforms2.get(4).pos.y - 90), 7);
  o_starpieces2.add(o_thisSP7);
  //Platform 5 & 2 Stream
  Starpiece thisSP8 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(2).pos.x + platformSize.x/2, platforms2.get(5).pos.y), 7);
  starpieces2.add(thisSP8);
  Starpiece o_thisSP8 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(2).pos.x + platformSize.x/2, platforms2.get(5).pos.y), 7);
  o_starpieces2.add(o_thisSP8);
  Starpiece thisSP9 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(2).pos.x + platformSize.x/2, platforms2.get(5).pos.y + 40), 7);
  starpieces2.add(thisSP9);
  Starpiece o_thisSP9 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(2).pos.x + platformSize.x/2, platforms2.get(5).pos.y + 40), 7);
  o_starpieces2.add(o_thisSP9);
  Starpiece thisSP0 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(2).pos.x + platformSize.x/2, platforms2.get(5).pos.y + 150), 7);
  starpieces2.add(thisSP0);
  Starpiece o_thisSP0 = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(2).pos.x + platformSize.x/2, platforms2.get(5).pos.y + 150), 7);
  o_starpieces2.add(o_thisSP0);
  //Weird
  Starpiece thisSPa = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(1).pos.x + 20, platforms2.get(1).pos.y - 120), 7);
  starpieces2.add(thisSPa);
  Starpiece o_thisSPa = new Starpiece(color(255, 112, 200), new PVector(platforms2.get(1).pos.x + 20, platforms2.get(1).pos.y - 120), 7);
  o_starpieces2.add(o_thisSPa);
}

void InitializeAddStarpieces_3() {
  //Arc 1
  Starpiece thisSP = new Starpiece(color(255, 112, 200), new PVector(width/2 + 50, height - 90), 7);
  starpieces3.add(thisSP);
  Starpiece o_thisSP = new Starpiece(color(255, 112, 200), new PVector(width/2 + 50, height - 90), 7);
  o_starpieces3.add(o_thisSP);
  Starpiece thisSP1 = new Starpiece(color(255, 112, 200), new PVector(width/2 + 65, height - 125), 7);
  starpieces3.add(thisSP1);
  Starpiece o_thisSP1 = new Starpiece(color(255, 112, 200), new PVector(width/2 + 65, height - 125), 7);
  o_starpieces3.add(o_thisSP1);
  Starpiece thisSP2 = new Starpiece(color(255, 112, 200), new PVector(width/2 + 91, height - 150), 7);
  starpieces3.add(thisSP2);
  Starpiece o_thisSP2 = new Starpiece(color(255, 112, 200), new PVector(width/2 + 91, height - 150), 7);
  o_starpieces3.add(o_thisSP2);
  //Weird
  Starpiece thisSP3 = new Starpiece(color(255, 112, 200), new PVector(platforms3.get(0).pos.x + 40, platforms3.get(0).pos.y - 140), 7);
  starpieces3.add(thisSP3);
  Starpiece o_thisSP3 = new Starpiece(color(255, 112, 200), new PVector(platforms3.get(0).pos.x + 40, platforms3.get(0).pos.y - 140), 7);
  o_starpieces3.add(o_thisSP3);
  //Small Arc 2
  Starpiece thisSP4 = new Starpiece(color(255, 112, 200), new PVector(platforms3.get(1).pos.x + platformSize.x + 20, platforms3.get(1).pos.y - 20), 7);
  starpieces3.add(thisSP4);
  Starpiece o_thisSP4 = new Starpiece(color(255, 112, 200), new PVector(platforms3.get(1).pos.x + platformSize.x + 20, platforms3.get(1).pos.y - 20), 7);
  o_starpieces3.add(o_thisSP4);
  Starpiece thisSP5 = new Starpiece(color(255, 112, 200), new PVector(platforms3.get(1).pos.x + platformSize.x + 35, platforms3.get(1).pos.y + 10), 7);
  starpieces3.add(thisSP5);
  Starpiece o_thisSP5 = new Starpiece(color(255, 112, 200), new PVector(platforms3.get(1).pos.x + platformSize.x + 35, platforms3.get(1).pos.y + 10), 7);
  o_starpieces3.add(o_thisSP5);
  //Fall 1
  Starpiece thisSP6 = new Starpiece(color(255, 112, 200), new PVector(138, platforms3.get(2).pos.y - 40), 7);
  starpieces3.add(thisSP6);
  Starpiece o_thisSP6 = new Starpiece(color(255, 112, 200), new PVector(138, platforms3.get(2).pos.y - 40), 7);
  o_starpieces3.add(o_thisSP6);
  Starpiece thisSP7 = new Starpiece(color(255, 112, 200), new PVector(138, platforms3.get(2).pos.y + 40), 7);
  starpieces3.add(thisSP7);
  Starpiece o_thisSP7 = new Starpiece(color(255, 112, 200), new PVector(138, platforms3.get(2).pos.y + 40), 7);
  o_starpieces3.add(o_thisSP7);
  Starpiece thisSP8 = new Starpiece(color(255, 112, 200), new PVector(138, platforms3.get(2).pos.y + 200), 7);
  starpieces3.add(thisSP8);
  Starpiece o_thisSP8 = new Starpiece(color(255, 112, 200), new PVector(138, platforms3.get(2).pos.y + 200), 7);
  o_starpieces3.add(o_thisSP8);
  //Others/Weird
  Starpiece thisSPb = new Starpiece(color(255, 112, 200), new PVector(platforms3.get(4).pos.x + platformSize.x/2, platforms3.get(4).pos.y - 20), 7);
  starpieces3.add(thisSPb);
  Starpiece o_thisSPb = new Starpiece(color(255, 112, 200), new PVector(platforms3.get(4).pos.x + platformSize.x/2, platforms3.get(4).pos.y - 20), 7);
  o_starpieces3.add(o_thisSPb);
  
  Starpiece thisSPc = new Starpiece(color(255, 112, 200), new PVector(platforms3.get(5).pos.x + platformSize.x/2, platforms3.get(5).pos.y - 110), 7);
  starpieces3.add(thisSPc);
  Starpiece o_thisSPc = new Starpiece(color(255, 112, 200), new PVector(platforms3.get(5).pos.x + platformSize.x/2, platforms3.get(5).pos.y - 110), 7);
  o_starpieces3.add(o_thisSPc);
}
