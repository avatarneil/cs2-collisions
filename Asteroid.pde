class Asteroid {
     final int size;  // number of sides
     PVector center;  // position of center, in screen coordinates
     final PVector v;  // velocity, per second, in screen coordinates

  Asteroid(int s, PVector c, PVector v_) {
    size = s;
    center = c;
    v = v_;
  }
  
  // Create a new Asteroid with a random position & velocity.  The
  // position is uniformly distributed over the window area.  The
  // velocity is in a random direction, always with magnitude 100
  // pixels/second.
  Asteroid() {
    size = 8;
    center = new PVector(random(width), random(height));
    v = new PVector(100,0);
    v.rotate(random(TWO_PI));
  } 

  // Update the position of the Asteroid according to its velocity.
  // The argument dt is the elapsed time in milliseconds since the
  // last update.  Modifies the Asteroid.
  public void update(float dt) {
    PVector dv = v.copy();
    dv.mult(dt/1000);
    center.add(dv);
    center.x = (center.x + width) % width;
    center.y = (center.y + width) % height;
  }

  // Draw a polygon with the current style.  `polygon(x, y, r, n)`
  // draws a n-sided polygon with its circumcenter at (x,y), with a
  // distance r from the center to each vertex.
  private void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
  }
  //Calls polygon function, and fills in variables for position/size
  void render(){
    fill(67,255,219);
    polygon(center.x,center.y,this.radius(),size);
  }
  // Changes the size of the child by -1
  int childShape(){
   return size -1;
  }
  // Returns condition if size is within certain boundaries.
  boolean canSplit(){
    if (size > 4){
      return true;
    }
    else{
      return false;
    }
  }
  //Multiply pvectors and make v1 and v2.
  Pair childVelocities(){
    PVector v1 = PVector.mult(v,1.1);
    PVector v2 = PVector.mult(v,1.1);
    v1.rotate(-.523);
    v2.rotate(.523);
    Pair<PVector, PVector> p = new Pair(v1,v2);
    return p;
  }
  // Returns the radius based upon size.
  float radius(){
    if (size==4){
      return 10;
    }
    else if (size==5){
      return 12.7;
    }
    else if (size==6){
      return 16;
    }
    else if (size==7){
      return 20.2;
    }
    else if (size==8){
      return 25.4;
    }
    else{
      return -1;
    }
  }
  // Creates a Pair of new child asteroids with given arguments.
  Pair children(){
    Pair<PVector,PVector> g = childVelocities();
    Asteroid a= new Asteroid(this.childShape(),center,g.a);
    Asteroid b= new Asteroid(this.childShape(),center.copy(),g.b);
    Pair<Asteroid,Asteroid> j = new Pair(a,b);
    return j;
  }
}
