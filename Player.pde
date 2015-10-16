class Player {
  float rotDegree; // Degree by which to rotate.
  PVector center; // Center location of Player.
  PVector v; // Velocity of Player.
  int op; // Variable to determine opacity of player.
  Player(){
    center = new PVector(width/2,height/2);
    v = new PVector(0,0);
  }
  // Sets opacity.
  void op(int opac){
    op=opac;
  }
  // Sets rotation to given rotation degree.
  void setRotate(float rot){
   rotDegree=rot+rotDegree;
  }
  // Updates velocity to move in the direction of the rotation degree.
  void move(){
      v.x = v.x + cos(rotDegree)/5;
      v.y = v.y + sin(rotDegree)/5;
  }
  // Returns radius.
  float radius(){
    return 10;
  }
  // Returns the current rotDegree (for use within breaker).
  float angle(){
    return rotDegree;
  }
  // Renders Player
  void render(){
    fill(255,0,0,op);
    center.add(v);
    pushMatrix();
    translate(center.x,center.y);
    rotate(rotDegree);
    triangle(-10,0,25,-10,-10,-20);
    popMatrix();
  }
  // Returns current center (for use within breaker and for collision).
  PVector loc(){
    return center.copy();
  }
}