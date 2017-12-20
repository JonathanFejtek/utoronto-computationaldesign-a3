class Agent{
  PVector pos;
  PVector vel;
  PVector acc;
  ArrayList<PVector> trail = new ArrayList<PVector>();
  
  Agent(float x, float y, float z){
    pos = new PVector(x,y,z);
    acc = new PVector(0,0,0);
    vel = new PVector(0,0,0);
  }
  
  void display(){
    vel.add(acc);
    pos.add(vel);
    acc.setMag(0);
    trail.add(new PVector(pos.x,pos.y,pos.z));
  }
  
  void addForce(float x, float y, float z){
    this.acc.add(x,y,z);
  }
  
  void displayTrail(){
    int i = 0;
    for(PVector p : trail){
      pushStyle();
      stroke(250,50,0,50);
      point(p.x,p.y,p.z);
      popStyle();
    i++;
    }
  }
  
}