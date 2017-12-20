class Slider{
  PVector pos;
  PGraphics pg;
  boolean display = false;
  
  Slider(int x, PGraphics pg){
    pos = new PVector(x,0);
    this.pg = pg;
  }
  
  void display(){
    if(display){
    pg.rect(pos.x,pos.y,20,20);
    }
  }
  
  void toggleDisplay(){
    display = !display;
  }
  
  void mousePressed(){
    if(isMousedOver() && display){
    pos.set(pos.x,mouseY);
    }
  }
  
  float getValue(){
    return map(pos.y,0,height,0,1);
  }
  
  boolean isMousedOver(){
    return (mouseX >= pos.x && mouseX <= pos.x+20);
  }
  
}