//Perlin noise example. Modified from:

// M_1_5_03_TOOL.pde
// Agent.pde, GUI.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de

class Agent {
 PVector p, pOld;
  float stepSize;
  float theta, phi;
  int red, green, blue;
  Agent() {
    //this.location = location;
    stepSize = random(10, 20);
    p = new PVector(0,0,0);
    theta = random(0, PI);
    phi = random(0, 2*PI);
    p.x += stepSize * sin(theta) * cos(phi);
    p.y += stepSize * sin(theta) * sin(phi);
    p.z += stepSize * cos(theta);
    pOld = new PVector(p.x,p.y, p.z);
    red = 200;
    green = 100;
    blue = 50;
    
  }

  void update(){
    theta = noise(p.x/noiseScale, p.y/noiseScale, p.z/noiseScale) * noiseStrength;
    phi = noise(p.x/noiseScale, p.y/noiseScale, p.z/noiseScale) * noiseStrength;
    p.x += stepSize * sin(theta) * cos(phi);
    p.y += stepSize * sin(theta) * sin(phi);
    p.z += stepSize * cos(theta);


    strokeWeight(strokeWidth);
    red = (red + (int) random(-5, 5))% 255;
    green = (green + (int) random(-5, 5)) % 255;
    blue = (blue + (int) random(-5, 5)) % 255;
    stroke(red, green, blue, agentsAlpha);
    line(pOld.x,pOld.y,pOld.z,p.x,p.y,p.z);

    pOld.set(p);
    //noiseZ += noiseZVelocity;
  }
  void reset()
  {
    p = new PVector(0,0,0);
    pOld = new PVector(p.x,p.y, p.z);
  }


  // void setNoiseZRange(float theNoiseZRange) {
  //   // small values will increase grouping of the agents
  //   noiseZ = random(theNoiseZRange);
  // }
}
