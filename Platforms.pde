class Platforms {
  PVector size;
  PVector pos;
  PVector o_pos;
  color myColor;
  
  //for movement
  //String axis;
  //float spd;
  //int reachedFarLimit; 
  //float farLimit;
  //int indexInStage;
  
  Platforms(PVector s, PVector p, color c, String a, float sp, float FL) {
    size = s;
    pos = p;
    PVector separatePV = new PVector(p.x, p.y);
    o_pos = separatePV;
    myColor = c;
  }
  
  void DrawPlatform() {
    rectMode(CORNER);
    fill(myColor, 150);
    stroke(255);
    strokeWeight(1.3);
    rect(pos.x, pos.y, size.x, size.y, 7);
  }
}

//----------------------------------------------------------------------------------- Other Platform Fxns
//---------------------------------------------------------------- 1
void InitializeAddPlatforms_1() {
  Platforms thisPlat = new Platforms(platformSize, new PVector(0, basePlatformPos.y), platformColor, 
      "NONE", 0, 0);
  platforms1.add(thisPlat);
  Platforms oldPlat = new Platforms(platformSize, new PVector(0, basePlatformPos.y), platformColor, 
      "NONE", 0, 0);
  o_platforms1.add(oldPlat);
  
  Platforms thisPlat2 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, basePlatformPos.y - 80), platformColor, 
      "NONE", 0, 0);
  platforms1.add(thisPlat2);
  Platforms oldPlat2 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, basePlatformPos.y - 80), platformColor, 
      "NONE", 0, 0);
  o_platforms1.add(oldPlat2);
  
  Platforms thisPlat3 = new Platforms(platformSize, new PVector(width-platformSize.x, basePlatformPos.y - 160), platformColor, 
      "NONE", 0, 0);
  platforms1.add(thisPlat3);
  Platforms oldPlat3 = new Platforms(platformSize, new PVector(width-platformSize.x, basePlatformPos.y - 160), platformColor, 
      "NONE", 0, 0);
  o_platforms1.add(oldPlat3);
  
  Platforms thisPlat4 = new Platforms(platformSize, new PVector(width/2 - platformSize.x/2, basePlatformPos.y - 260), platformColor, 
      "NONE", 0, 0);
  platforms1.add(thisPlat4);
  Platforms oldPlat4 = new Platforms(platformSize, new PVector(width/2 - platformSize.x/2, basePlatformPos.y - 260), platformColor, 
      "NONE", 0, 0);
  o_platforms1.add(oldPlat4);
  
  Platforms thisPlat5 = new Platforms(platformSize, new PVector(0, basePlatformPos.y - 340), platformColor, 
      "NONE", 0, 0);
  platforms1.add(thisPlat5);
  Platforms oldPlat5 = new Platforms(platformSize, new PVector(0, basePlatformPos.y - 340), platformColor, 
      "NONE", 0, 0);
  o_platforms1.add(oldPlat5);
  
  Platforms thisPlat6 = new Platforms(platformSize, new PVector(width/2 - platformSize.x/2, basePlatformPos.y - 440), platformColor, 
      "NONE", 0, 0);
  platforms1.add(thisPlat6);
  Platforms oldPlat6 = new Platforms(platformSize, new PVector(0, basePlatformPos.y - 440), platformColor, 
      "NONE", 0, 0);
  o_platforms1.add(oldPlat6);
}
//---------------------------------------------------------------- 2
void InitializeAddPlatforms_2() {
  Platforms thisPlat = new Platforms(platformSize, new PVector(0, smallBPPS.y), platformColor, 
      "X", 130, 600-platformSize.x);
  platforms2.add(thisPlat);
  Platforms oldPlat = new Platforms(platformSize, new PVector(0, smallBPPS.y), platformColor, 
      "NONE", 0, 0);
  o_platforms2.add(oldPlat);
  
  Platforms thisPlat2 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, smallBPPS.y - 140), platformColor, 
      "NONE", 0, 0);
  platforms2.add(thisPlat2);
  Platforms oldPlat2 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, smallBPPS.y - 140), platformColor, 
      "NONE", 0, 0);
  o_platforms2.add(oldPlat2);
  
  Platforms thisPlat3 = new Platforms(platformSize, new PVector(width-platformSize.x, smallBPPS.y - 260), platformColor, 
      "NONE", 0, 0);
  platforms2.add(thisPlat3);
  Platforms oldPlat3 = new Platforms(platformSize, new PVector(width-platformSize.x, smallBPPS.y - 260), platformColor, 
      "NONE", 0, 0);
  o_platforms2.add(oldPlat3);
  
  Platforms thisPlat4 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, smallBPPS.y - 390), platformColor, 
      "X", 180, 600-platformSize.x);
  platforms2.add(thisPlat4);
  Platforms oldPlat4 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, smallBPPS.y - 390), platformColor, 
      "X", 180, 600-platformSize.x);
  o_platforms2.add(oldPlat4);
  
  Platforms thisPlat5 = new Platforms(platformSize, new PVector(0, smallBPPS.y - 520), platformColor, 
      "NONE", 0, 0);
  platforms2.add(thisPlat5);
  Platforms oldPlat5 = new Platforms(platformSize, new PVector(0, smallBPPS.y - 520), platformColor, 
      "NONE", 0, 0);
  o_platforms2.add(oldPlat5);
  
  Platforms thisPlat6 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, smallBPPS.y - 650), platformColor, 
      "NONE", 0, 0);
  platforms2.add(thisPlat6);
  Platforms oldPlat6 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, smallBPPS.y - 650), platformColor, 
      "NONE", 0, 0);
  o_platforms2.add(oldPlat6);
}
//---------------------------------------------------------------- 3
void InitializeAddPlatforms_3() {
  Platforms thisPlat = new Platforms(platformSize, new PVector(width - platformSize.x, smallBPPS.y), platformColor, 
      "NONE", 0, 0);
  platforms3.add(thisPlat);
  Platforms oldPlat = new Platforms(platformSize, new PVector(width - platformSize.x, smallBPPS.y), platformColor, 
      "NONE", 0, 0);
  o_platforms3.add(oldPlat);
  
  Platforms thisPlat1 = new Platforms(platformSize, new PVector(width/2 - platformSize.x/2, smallBPPS.y - 130), platformColor, 
      "NONE", 0, 0);
  platforms3.add(thisPlat1);
  Platforms oldPlat1 = new Platforms(platformSize, new PVector(width/2 - platformSize.x/2, smallBPPS.y - 130), platformColor, 
      "NONE", 0, 0);
  o_platforms3.add(oldPlat1);
  
  Platforms thisPlat2 = new Platforms(platformSize, new PVector(width-platformSize.x, smallBPPS.y - 260), platformColor, 
      "NONE", 0, 0);
  platforms3.add(thisPlat2);
  Platforms oldPlat2 = new Platforms(platformSize, new PVector(width-platformSize.x, smallBPPS.y - 260), platformColor, 
      "NONE", 0, 0);
  o_platforms3.add(oldPlat2);
  
  Platforms thisPlat4 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, smallBPPS.y - 390), platformColor, 
      "NONE", 0, 0);
  platforms3.add(thisPlat4);
  Platforms oldPlat4 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, smallBPPS.y - 390), platformColor, 
      "NONE", 0, 0);
  o_platforms3.add(oldPlat4);
  
  Platforms thisPlat5 = new Platforms(platformSize, new PVector(0, smallBPPS.y - 520), platformColor, 
      "NONE", 0, 0);
  platforms3.add(thisPlat5);
  Platforms oldPlat5 = new Platforms(platformSize, new PVector(0, smallBPPS.y - 520), platformColor, 
      "NONE", 0, 0);
  o_platforms3.add(oldPlat5);
  
  Platforms thisPlat6 = new Platforms(platformSize, new PVector(width-platformSize.x, smallBPPS.y - 650), platformColor, 
      "NONE", 0, 0);
  platforms3.add(thisPlat6);
  Platforms oldPlat6 = new Platforms(platformSize, new PVector(width-platformSize.x, smallBPPS.y - 650), platformColor, 
      "NONE", 0, 0);
  o_platforms3.add(oldPlat6);
  
  Platforms thisPlat7 = new Platforms(platformSize, new PVector(0, smallBPPS.y - 670), platformColor, 
      "NONE", 0, 0);
  platforms3.add(thisPlat7);
  Platforms oldPlat7 = new Platforms(platformSize, new PVector(0, smallBPPS.y - 670), platformColor, 
      "NONE", 0, 0);
  o_platforms3.add(oldPlat7);
  
  Platforms thisPlat8 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, smallBPPS.y - 800), platformColor, 
      "NONE", 0, 0);
  platforms3.add(thisPlat8);
  Platforms oldPlat8 = new Platforms(platformSize, new PVector(width/2-platformSize.x/2, smallBPPS.y - 800), platformColor, 
      "NONE", 0, 0);
  o_platforms3.add(oldPlat8);
}
