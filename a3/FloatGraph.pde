class FloatGraph{
  float[] floats;
  PVector pos;
  int h; int w;
  
  float[] constraints;
  
  boolean constrain = false;
  PGraphics g_buffer;
  boolean display = false;
  int size;
  
  FloatGraph(int x, int y, int w, int h, int size){
    floats = new float[size];
    this.size = size;
    
    for(int i = 0; i < size; i++){
      floats[i] = noise(map(i,0,size,0,map(sl.getValue(),0,1,0,200)));
    }
    pos = new PVector(x,y);
    this.w = w;
    this.h = h;
  }
  
  void addGraphicsBuffer(PGraphics pg){
    g_buffer = pg;
  }
  
  void reset(){
    for(int i = 0; i < size; i++){
      floats[i] = noise(map(i,0,size,0,map(sl.getValue(),0,1,0,200)));
    }
  }
  
  void constrainValues(){
    for(int i = 0; i < floats.length; i++){
      floats[i] = constrain(floats[i],constraints[i]-0.1,constraints[i]);
    }
  }
  
  void toggleDisplay(){
    display = !display;
  }
  
  void setConstraints(float[] constraints){
    this.constraints = constraints;
    constrain = true;
  }
  
  void displayGUI(){
    if(display){
    if(g_buffer !=null){
      g_buffer.rect(pos.x,pos.y,w,h);
     // println("true");
    }
    else{
      rect(pos.x,pos.y,w,h);
    }
    for(int i = 0; i < floats.length; i++){
      if(g_buffer !=null){
        g_buffer.ellipse(map(i,0,floats.length-1,pos.x,pos.x+w),map(floats[i],0,1,pos.y+h,pos.y),2,2);
      }
      else{
        ellipse(map(i,0,floats.length-1,pos.x,pos.x+w),map(floats[i],0,1,pos.y+h,pos.y),2,2);
      }
    }
    displayLine();
    }
  }
  
  void displayLine(){
    for(int i = 1; i < floats.length; i++){
      PVector p1 = new PVector(map(i-1,0,floats.length-1,pos.x,pos.x+w),map(floats[i-1],0,1,pos.y+h,pos.y));
      PVector p2 = new PVector(map(i,0,floats.length-1,pos.x,pos.x+w),map(floats[i],0,1,pos.y+h,pos.y));
      g_buffer.line(p1.x,p1.y,p2.x,p2.y);
    }
  }
  
  float[] getValues(){
    return floats;
  }
  
  boolean isMousedOver(){
    return (mouseX >= pos.x && mouseX <=pos.x+w) && (mouseY >= pos.y && mouseY <= pos.y +h);
  }
  
  void mousePressed(){
    if(isMousedOver() && display){
      int index = round(map(mouseX,pos.x,pos.x+w,0,floats.length-1));
      float value = map(mouseY,pos.y,pos.y+h,1,0);
      value = constrain(value,0,floats.length-1);
      floats[index] = value;
    }
    if(constrain){
    constrainValues();
    }
    
  }
   
}