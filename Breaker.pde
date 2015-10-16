class Breaker {
  PVector center; // Center location for the Breaker.
  PVector v; // Velocity of the Breaker.
  float rotDegree; // Degree by which to rotate.
  
  Breaker(PVector c) {
    center = c;
    v = new PVector(0,0);
    rotDegree=0; 
  }
  Breaker(){
    center = new PVector(0,0);
    v = new PVector(0,0);
  }
  // Sets new center PVector
  void setCent(PVector j){
    center = j;
  }
  // Sets new rotation degree
  void setRotate(float rot){
    rotDegree=rot;
  }
  // Updates velocity to move in the direction of the rotation degree as to correspond with the direction of player object.
  void fly(){
      v.x = v.x + cos(rotDegree);
      v.y = v.y + sin(rotDegree);
  }
  // Returns radius of breaker
  float radius(){
    return 5;
  }
 // Renders breaker.
 void render(){
    stroke(0);
    center.add(v.copy());
    pushMatrix();
    noStroke();
    fill(155,0,255);
    translate(center.x,center.y);
    ellipse(0,0, 5, 5);
    popMatrix();
 }
}
 