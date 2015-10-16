import java.util.HashSet;

// Detect collitions between Breakers and Asteroids.  Remove the
// Asteroids involved in collisions, and replace them with smalller
// Asteroids.  Remove Breakers involved in collisions.
void handleCollisions() {
     // Asteroids which collided this timestep
  HashSet<Asteroid> collisions = new HashSet();

  // Breakers which collided this timestep.
  HashSet<Breaker> usedBreakers = new HashSet();

  // Keep track of which objects collided.  Don't delete them inside
  // the loop, because that messes up the Iterator.
  for (Breaker b : breakers) {
    for (Asteroid a : asteroids) {
      if (colliding(a, b)) {
        collisions.add(a);
        usedBreakers.add(b);
      }
    }
  }

  // Split or remove the Asteroids which collided
  for (Asteroid a : collisions) {
    asteroids.remove(a);
       if (a.canSplit()) {
         children = a.children();
         asteroids.add(children.a);
         asteroids.add(children.b);
       }
  }
  
  // Remove the Breakers which collided
  for (Breaker b : usedBreakers) {
    breakers.remove(b);
  }
}

// The number of (random) elements to create.
int initialAsteroids = 10;
int initialBreakers = 30;
// returns the distance between two objects
float distance(PVector c,PVector v_){
  return(c.dist(v_));
}
//creates asteroid and breaker ArrayLists
ArrayList<Asteroid> asteroids = new ArrayList();
ArrayList<Breaker> breakers = new ArrayList();
//Takes the position of an Asteroid and Breaker and compares them.
boolean colliding(Asteroid a,Breaker b){
  if (distance(a.center,b.center)<=a.radius()+b.radius()){
    return true;
  }else{
    return false;
  }
}
//determines if asteroid and player are colliding (within a decent margin of error).
boolean colPlay(Asteroid a,Player w){
  if(distance(a.center,w.center)<=a.radius()+w.radius()){
    return true;
  }else{
    return false;
  }
}
// Store time (ms) of last update.
float t, last_t, dt;
Pair<Asteroid, Asteroid> children;
Player w;
Breaker b;
void setup() {
  // Make random Asteroids
  int i = 0;
  while(i < initialAsteroids) {
    asteroids.add(new Asteroid());
    i++;
  }

  // Randomly place Breakers
  i = 0;
  
  size(500,500);
  //creating player object 
  w = new Player();
}

void draw() {
  clear();
  // Render all the Asteroids
  for(Asteroid a : asteroids) {
    a.render();
  }
  // Render all the breakers
  Breaker k;
  for(Breaker b : breakers) {
    b.render();
  }

  // Update the positions of the Asteroids
  t = millis();
  dt = last_t - t;
  last_t = t;
  for(Asteroid a : asteroids) {
    a.update(dt);
  }
  // Direction for the player(which directly updates the breaker), shoots breakers, as well as a broken reset.
  if (keyPressed) {
    if (key == CODED) {
      if(keyCode==UP){
        w.move();
      }
      else if(keyCode==LEFT){
        w.setRotate(-.1);
      }
      else if(keyCode==RIGHT){
        w.setRotate(.1);
      }
      else if(keyCode==DOWN){
       k = new Breaker(w.loc());
       breakers.add(k);
       k.setRotate(w.angle());
       k.fly();
     }
    }
    if(key=='g'){
      setup();
    }
  }
  w.render();
  handleCollisions();
  //player relatively transparent(invunerable) if within 4 seconds of start
  if(t<4000){
    w.op(70);
  }
  // Once time of invunerability is over, if player collides with an asteroid output
  // of text "gameover" and sets player to opaque.
  if(t>4000){
    for(Asteroid a: asteroids){
      if(colPlay(a,w)==true){
        text("Game Over.",width/2,height/2);
        noLoop();
      }
    }
    w.op(255);
  }
}