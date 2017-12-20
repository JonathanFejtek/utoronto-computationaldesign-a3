class DynaBox{
  Agent agent1;
  Agent agent2;
  ArrayList<Agent> agents = new ArrayList<Agent>();
  ArrayList<LineSeg> line_segments = new ArrayList<LineSeg>();
  int wthresh;
  int hthresh;
  int dthresh;
  PVector pos;
  int w;
  int h;
  int d;
  float df;
  
  DynaBox(int x, int y, int z, int w, int h, int d, float sx, float sy, float sz){
    pos = new PVector(x,y,z);
    this.w = w;
    this.h = h;
    this.d = d;
    wthresh = w/9;
    hthresh = h/9;
    dthresh = d/9;
    df = random(0.00001,0.001);
    PVector r = new PVector(sx,sy,sz);
    agent1 = new Agent(random(w/2),random(h/2),random(z/2));
    agent2 = new Agent(agent1.pos.x+1000,agent1.pos.y,agent1.pos.z);
    agent1.addForce(r.x,r.y,r.z);
    agent2.addForce(r.x,r.y,r.z);
    
    agents.add(agent1);
    agents.add(agent2);
  }
  
  void display(){
    for(int i = 0; i < 40000; i++){
     // println(i);
      for(Agent a : agents){
      if(a.pos.x < this.pos.x+wthresh){
        a.addForce(df,0,0);
      }
  
      if(a.pos.x > (this.pos.x+this.w)-wthresh){
        a.addForce(-df,0,0);
      }
  
      if(a.pos.y < this.pos.y+hthresh){
        a.addForce(0,df,0);
      }
  
      if(a.pos.y > this.pos.y+this.h-hthresh){
        a.addForce(0,-df,0);
      }
      
      if(a.pos.z < this.pos.z+dthresh){
        a.addForce(0,0,df);
      }
  
      if(a.pos.z > this.pos.z+this.d-dthresh){
        a.addForce(0,0,-df);
      }
  
     a.display();
      

    }
    for(int k = 1; k < agents.size(); k++){
      Agent a1 = agents.get(k-1);
      Agent a2 = agents.get(k);
      line_segments.add(new LineSeg(a1.pos.get(),a2.pos.get()));
      pushStyle();
      colorMode(HSB,255);
      strokeWeight(0.1);
      stroke(map(k,0,agents.size(),250,180),100,100,map(k,0,agents.size(),80,0));
     line(a1.pos.x,a1.pos.y,a2.pos.x,a2.pos.y);
      popStyle();
    }

    
  }
  }
  
  void displayTrail(){
  agent1.displayTrail();
  agent2.displayTrail();
   int i = 0;
    for(LineSeg ls : line_segments){
      if(i%100==0){
      pushStyle();
      strokeWeight(1);
      colorMode(HSB,255);
      stroke(250,250,250);
      ls.display();
      popStyle();
      
    }
    i++;
    }
  }
  
  PVector getUV(float u, float v){
    return line_segments.get((int)map(u,0,1,0,line_segments.size()-1)).getPosAtParam(v);
  }
  
  void drawCurve(){
    for(float i = 0; i < 1; i+=1.0/50){
     // PVector pos1 = getUV(i-0.002,0);
     // PVector pos2 = getUV(i,0);
     // PVector pos3 = getUV(i-0.002,1);
     // PVector pos4 = getUV(i,1);
      for(float j = 0; j < 1; j+=1.0/300){
        PVector pos5 = getUV(i,j);
        pushStyle();
        fill(10,0,250);
        noStroke();
        pushMatrix();
        translate(pos5.x,pos5.y,pos5.z);
        box(map(i,0,1,0,40),map(i,0,1,0,40),map(i,0,1,0,40));
        popMatrix();
        popStyle();
      }
        
      
      pushStyle();
      strokeWeight(0.5);
      popStyle();
    }
  }
  
  
  void drawBoxes(){
    float[] vals = float_graph.getValues();
     for(float i = 0; i < 1; i+=1.0/4000){
      PVector pos1 = getUV(i,vals[(int)map(i,0,1,0,vals.length-1)]);
      PVector pos2 = getUV(i,map(vals[(int)map(i,0,1,0,vals.length-1)],0,1,1,0));
     // PVector pos3 = getUV(i,map(mouseX,0,width,0,1));
     float size = map(i,0,1,0,40);
     float hue = map(i,0,1,0,25);
      colorMode(HSB,255);
      pushStyle();
     noStroke();
      fill(hue,0,250);
      pushMatrix();
      translate(pos1.x,pos1.y,pos1.z);
      box(size,size,size);
      popMatrix();
      popStyle();
      
      pushStyle();
      fill(hue,0,250);
      noStroke();
      pushMatrix();
      translate(pos2.x,pos2.y,pos2.z);
      box(size,size,size);
      popMatrix();
      popStyle();
      
   
      
      
    }   
  } 
}