import peasy.*;

PeasyCam cam;
float z = 100;
float x_rot = 1;

DynaBox db;
PGraphics ui_field;
FloatGraph float_graph;
Slider sl;
void setup() {
  size(800,800,P3D);
  randomSeed(q);
 ui_field = createGraphics(800,800,P2D);
 sl = new Slider(20,ui_field);

 float_graph = new FloatGraph(50,50,700,100,8000);
 float_graph.addGraphicsBuffer(ui_field);
 
 db = new DynaBox(0,0,0,800,800,800,random(-0.2,-0.2),random(-0.2,-0.2),random(-0.2,-0.2));
  cam = new PeasyCam(this,400,400,400,100);
   ui_field.beginDraw();
   ui_field.endDraw();
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(5000);
  db.display();
 
}
void draw() {
   background(0);
  
  stroke(250);
      
     cam.beginHUD();
   pushStyle();
   
   ui_field.beginDraw();
   ui_field.background(0);
   float_graph.displayGUI();
   sl.display();
   
  ui_field.endDraw();
   image(ui_field,0,0);
   popStyle();
   cam.endHUD();
   
      pointLight(200,250,250,400,400,400);
  pointLight(210,250,250,800,400,400);
  pointLight(190,250,250,0,400,400);
  db.drawBoxes();

  

}

int q = 0;
int im = 13;
void keyPressed(){
  
    if(key == 'h'){
    float_graph.toggleDisplay();
    sl.toggleDisplay();
  }
  else if(key == 's'){
    im++;
    save("im"+str(im)+".tiff");
  }
  else if(key != CODED){
    q++;
  randomSeed(q);
  db = new DynaBox(0,0,0,800,800,800,random(-0.2,-0.2),random(-0.2,-0.2),random(-0.2,-0.2));
  db.display();
  }
  

}

void mouseDragged(){
  sl.mousePressed();
}

void mouseReleased(){
  float_graph.reset();
}