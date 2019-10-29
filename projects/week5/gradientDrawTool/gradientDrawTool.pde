import drawing.library.*;
import processing.pdf.*;

DrawingManager drawingManager;
float theta = 0;
float rot = PI/400;
int loc = 0;
int updown = 1;
PImage img;
int alpha = 255;
int addr = 1;
void setup() {
  size(1056,816,P3D);
  background(255);
  frameRate(60);
  smooth();
  drawingManager = new DrawingManager(this);
  img = loadImage("grad.png");  // Load the image into the program  
 }
 
 void draw() {
  //if(mousePressed){
  //  drawingManager.pushMatrix();
  //  drawingManager.translate(mouseX,mouseY);
    
    
    
  //  drawingManager.rotate(theta);
  //  //scale down to 
  //  drawingManager.scale(0.5,0.5);
  //  //Draw the image. Setting the x and y values of the image call to
  //  //-img.width/2 and -img.height/2 will place the center of the image
  //  // where the mouse cursor is.
  //  drawingManager.image(img,-img.width/2,-img.height/2,img.width,img.height);
  //  //pop out of the transformation matrix.
  //  drawingManager.popMatrix();
  //}
}
 
 void keyPressed() {
  if(key == ' '){
    drawingManager.savePDF();
  }
   if(key == 'c'){
    drawingManager.clear();
  }
}
void mousePressed(){
 
}

void mouseDragged(){
   //drawingManager.stroke(0,0,0);
   drawingManager.noStroke();
   //int xDist = mouseX-pmouseX;
   //int yDist = mouseY-pmouseY;
   //float theta = atan2(xDist,yDist);
   if(loc >= 1279)
   {
     updown = -1;
   }
   if(loc <= 0)
   {
     updown = 1;
   }
   color c = img.get(0, loc);
   loc += updown;
   //if((int)random(120) == 7)
   //{
   //  rot *= -1;
   //}
   if(theta <= 0)
   {
     rot = PI/400;
   }
   if(theta >= TWO_PI)
   {
     rot = -PI/400;
   }
   if((int)random(120) == 7)
   {
     addr *= -1;
   }
   if(alpha <= 64)
   {
     addr = 1;
   }
   if(alpha >= 255)
   {
     addr = -1;
   }
   theta += rot;
   alpha += addr;
   drawingManager.fill((int)red(c), (int)green(c), (int)blue(c), alpha);
   drawingManager.pushMatrix();
   drawingManager.translate(mouseX,mouseY);
   drawingManager.rotate(theta);
   drawingManager.rect(-40, 4, 40,4);
   drawingManager.popMatrix();
}
