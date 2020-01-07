//------------------------------------ Rectangle Collision
boolean AreTheseRectanglesColliding(PVector rect1pos, PVector rect1size, 
  PVector rect2pos, PVector rect2size) {
  rectMode(CORNER);
    
  if ((rect1pos.x <= rect2pos.x + rect2size.x)  //right bound
  && (rect1pos.x + rect1size.x >= rect2pos.x) //left bound
  && (rect1pos.y <= rect2pos.y + rect2size.y) //below bound
  && (rect1pos.y + rect1size.y >= rect2pos.y)) { //above bound
    return true;
  }
  else {
    return false;
  }
}

//------------------------------------ Implement basic PVector functionality in Processing.
PVector AddPVector(PVector a, PVector b)
{
  PVector result = new PVector(a.x + b.x, a.y + b.y);
  return result;
}

PVector ScalePVector(PVector a, float s) 
{
  PVector result = new PVector(a.x*s, a.y*s);
  return result;
}
