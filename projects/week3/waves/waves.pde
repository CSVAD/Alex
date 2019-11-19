import controlP5.*;
import processing.pdf.*;
ControlP5 cp5;

int size = 20;

float frequency = 0.1;
float amplitude = 1.0;
float phase = 0;
float angle = 0;
float elevation = 400;
float dist = -700;

Controller ringResSlider;
Controller freqSlider;
Controller amplitudeSlider;
Controller phaseSlider;
Controller angleSlider;
Controller elevSlider;
Controller distSlider;

void setup() {
  size(1024, 768, P3D);
  cp5 = new ControlP5(this);

  ringResSlider =  cp5.addSlider("size").setPosition(25, 25).setRange(10, 300);

  freqSlider = cp5.addSlider("frequency").setPosition(25, 25*2).setRange(0.01, .2);

  amplitudeSlider =  cp5.addSlider("amplitude").setPosition(25, 25*3).setRange(10, 500);

  phaseSlider = cp5.addSlider("phase").setPosition(25, 25*4).setRange(0,2*PI);
  
  angleSlider = cp5.addSlider("angle").setPosition(25, 25*5).setRange(0,2*PI);
  
  elevSlider = cp5.addSlider("elevation").setPosition(25, 25*6).setRange(-400,600);
  
  distSlider = cp5.addSlider("dist").setPosition(25, 25*7).setRange(-5000,0);
  
}

void draw() {
  background(0);
  lights();
  pushMatrix();
  translate(width / 2 + 100, height / 2 + elevation, dist);
  fill(255);
  stroke(0,0,255);
  strokeWeight(1);
  rotateY((float)(frameCount * Math.PI / 400));
  rotateZ(angle);
  
  Point3D[][] verticies = calculateVerticies();
  beginShape(QUAD_STRIP);
  for(int i = 1; i < verticies.length; i++)
  {
    Point3D[] pointListTop = verticies[i-1];
    Point3D[] pointListBottom = verticies[i];
    for(int j = 0; j < pointListTop.length; j++)
    {
      int t;
      if (j<pointListTop.length) {
        t = j;
      } else {
        t = 0;
      }
      Point3D bottom = pointListBottom[t];
      Point3D top = pointListTop[t];
      vertex(top.x, top.y, top.z);
      vertex(bottom.x, bottom.y, bottom.z);
    }
  }
  
  endShape(CLOSE);

  popMatrix();
}

Point3D[][] calculateVerticies() {
  float r = (1+sin(phase))*amplitude/2;
  Point3D[][] verticies = new Point3D[size][size];
  for(int i = 0; i < size; i++)
  {
    for(int j = 0; j < size; j++)
    {
      float theta = 2*PI*frequency*(i + j);
      float y = sin(theta)*r;
      verticies[i][j] = new Point3D(30*i - size*30/2, y, 30*j - size*30/2);
    }
  }
  return verticies;
}
