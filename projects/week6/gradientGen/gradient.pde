class Gradient{
 Swatch s1;
 Swatch s2;
 
 Gradient(Swatch s1, Swatch s2){
  this.s1 = s1;
  this.s2 = s2;
 }
 
 void gradientRect(int x, int y, int w, int h, color c1, color c2) {
  beginShape();
  fill(c1);
  vertex(x,y);
  vertex(x,y+h);
  fill(c2);
  vertex(x+w,y+h);
  vertex(x+w,y);
  endShape();
}
 void draw(){
  colorMode(RGB,255);
  color c1 = color(s1.red, s1.gre, s1.blu);
  color c2 = color(s2.red, s2.gre, s2.blu);
  PVector p1 = s1.position;
  PVector p2 = s2.position;
  float dy = p1.y - p2.y;
  float dx = p1.x - p2.x;
  float vy = dy / sqrt(dy*dy + dx*dx);
  float vx = dx / sqrt(dy*dy + dx*dx);
  noStroke();
  beginShape();
  fill(c1);
  vertex(p1.x - 10 * vy, p1.y + 10 * vx);
  vertex(p1.x + 10 * vy, p1.y - 10 * vx);
  fill(c2);
  vertex(p2.x + 10 * vy, p2.y - 10 * vx);
  vertex(p2.x - 10 * vy, p2.y + 10 * vx);
  endShape();
 }
 
}
