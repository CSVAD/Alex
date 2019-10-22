import controlP5.*;

Agent[] agents = new Agent[100];
int agentsCount = 10;
float noiseScale = 100, noiseStrength = 100;
float agentsAlpha = 90, strokeWidth = 5;

ControlP5 controlP5;
boolean showGUI = false;
Slider[] sliders;

void setup(){
  size(1024, 768, P3D);
  smooth();
  frameRate(60);
  for(int i=0; i<agents.length; i++) agents[i] = new Agent();
  background(0);
  //lights();
  rotateZ(PI);
  setupGUI();
}

void draw(){
  //background(0, 0.01);
  if(frameCount % 300 == 0)
  {
    background(0);
    for(int i=0; i<agentsCount; i++){
       agents[i].reset();
    }
  }
  pushMatrix();
  translate(width / 2 + 100, height / 2 - 700, -700);
  rotateX(PI/6);
  //rotateY(frameCount * PI/120);
  stroke(0, agentsAlpha);
  for(int i=0; i<agentsCount; i++){
     agents[i].update();
  }
  popMatrix();
  drawGUI();

}
