import controlP5.*;
ControlP5 cp5;

int resolution = 20;

float frequency = 0.1;
float amplitude = 1.0;
float vaseHeight = 500;
float phase = 0;

Controller ringResSlider;
Controller freqSlider;
Controller amplitudeSlider;
Controller heightSlider;
Controller phaseSlider;

void setup() {
  size(1024, 768, P3D);
  cp5 = new ControlP5(this);

  ringResSlider =  cp5.addSlider("resolution").setPosition(25, 25).setRange(3, 50);

  freqSlider = cp5.addSlider("frequency").setPosition(25, 25*2).setRange(0.1, 1);

  amplitudeSlider =  cp5.addSlider("amplitude").setPosition(25, 25*3).setRange(1.0, 6);

  phaseSlider = cp5.addSlider("phase").setPosition(25, 25*5).setRange(0,2*PI);
  
}

Point3D[][] calculateVerticies() {
  int rowMax = 20;
  int colMax = 20;
  Point3D[][] verticies = new Point3D[rowMax][colMax];
  for(int i = 0; i < rowMax; i++)
  {
    for(int j = 0; j < colMax; j++)
    {
      float y = 10;
      verticies[i][j] = new Point3D(10*i, y, 10*j);
    }
  }
  return verticies;
}
