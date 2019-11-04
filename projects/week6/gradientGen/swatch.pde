class Swatch{
 float rad;
 PVector position;
 int red;
 int gre;
 int blu;
 boolean selected;
// boolean locked = false;
 
 Swatch(int x,int y, float r, int h, int s, int b){
  position = new PVector(x,y);
   rad = r;
   red = h;
   gre = s;
   blu = b;
   selected = false;
 }
 
  boolean hitTest(int x,int y){
    if(pow(x - position.x,2) + pow(y - position.y,2) < pow(rad,2)){
      return true;
      
     }
    
    return false; 
  }
 
 void moveBy(PVector delta){
    position.add(delta); 
 }
 
 //void updateColor(PVector delta, int mouseWheel){
 //  hue += delta.y;
 //  sat += delta.x;
 //  bri += mouseWheel;

 //}
 void draw(){
   colorMode(RGB,255);
   if(selected){
     strokeWeight(2);
     stroke(255);
   }
   else{
     //noStroke();
     strokeWeight(1);
     stroke(0);
   }
   
   colorMode(RGB,255);
   fill(red,gre,blu);
   ellipseMode(CENTER);
   ellipse(position.x,position.y,rad,rad);
 }
 
}
