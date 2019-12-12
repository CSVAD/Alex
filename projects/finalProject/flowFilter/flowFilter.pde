import processing.pdf.*;
import gab.opencv.*;
import controlP5.*;

import java.sql.Timestamp;
OpenCV opencv;
PImage edges;

float amp = 10.0;
int lowerThres = 50;
int upperThres = 100;
int preBlur = 4;
int postBlur = 5;
String[] edgeOptions = {"Sobel", "Scharr", "Canny"};
int edgeOption = 0;
float contrast = 2.0;
int hstep = 5;
boolean showImage = false;

boolean save = false;

ControlP5 cp5;

void setup()
{
  size(792,612);
  PImage img  = loadImage("jj270.png");
  img.resize(792,612);
  opencv = new OpenCV(this, img);
  cp5 = new ControlP5(this);
  
  DropdownList edgeList = cp5.addDropdownList("edgeOption").setPosition(5, 15*7);
  edgeList.addItem("Sobel", 0);
  edgeList.addItem("Scharr", 1);
  edgeList.addItem("Canny", 2);
  Controller ampSlider = cp5.addSlider("amp").setPosition(5, 2).setRange(2.0, 20.0);
  Controller lowerThresSlider = cp5.addSlider("lowerThres").setPosition(5, 15*1).setRange(0, 200);
  Controller upperThresSlider = cp5.addSlider("upperThres").setPosition(5, 15*2).setRange(10, 200);
  Controller preBlurSlider = cp5.addSlider("preBlur").setPosition(5, 15*3).setRange(2, 9);
  Controller postBlurSlider = cp5.addSlider("postBlur").setPosition(5, 15*4).setRange(2, 9);
  Controller constrast = cp5.addSlider("contrast").setPosition(5, 15*5).setRange(1.0, 7.0);
  Controller hstep = cp5.addSlider("hstep").setPosition(5, 15*6).setRange(2, 15);
  Controller imageToggle = cp5.addToggle("showImage").setPosition(width - 50, 2).setSize(40, 25);
}
void draw() 
{
  opencv.gray();
  opencv.blur(preBlur);
  if(edgeOption == 0)
  {
    opencv.findSobelEdges(1, 0);
    opencv.contrast(contrast);
  }
  if(edgeOption == 1)
  {
    opencv.findScharrEdges(1);
    opencv.contrast(contrast);
  }
  if(edgeOption == 2)
  {
    upperThres = (upperThres <= lowerThres) ? lowerThres + 5 : upperThres;
    opencv.findCannyEdges(lowerThres, upperThres);
  }
  opencv.blur(postBlur);
  
  opencv.invert();
  edges = opencv.getSnapshot();
  
  if(showImage) image(edges, 0, 0);
  ArrayList<PVector> points =  new ArrayList<PVector>();
  
  int edge = 10;
  int step = 1;
  //int hstep = 5;
  //float amp = 10.0;
  int res = (width - (edge*2)) / step;
  
  for(int i = edge; i <= height - edge - 20; i+= hstep)
  {
    for(int j = edge; j <= width - edge; j+=step)
    {
      float gray = 0.2126 * red(edges.get(j,i)) + 0.7152 * green(edges.get(j,i)) + 0.0722 * blue(edges.get(j,i));
      //gray = green(edges.get(j,i));
      float offset = (gray / (255.0/amp));
      points.add(new PVector(j, i + offset));
    }
  }
  
  if(!showImage) background(0);
  if(save)
  {
    Timestamp timestamp = new Timestamp(System.currentTimeMillis());
    beginRecord(PDF, timestamp.toString() + "plot.pdf");
  }
  noFill();
  
  int g = 0;
  beginShape();
  if(showImage || save) stroke(0);
  else stroke(255);
  for(int i = 0; i < points.size(); i++)
  {
      if(i%(res+1) != res)
      {
          vertex(points.get(i).x,points.get(i).y);
      }
      else
      {
        endShape();
        if(i > points.size() - res)
        {
          continue;
        }
        beginShape();
        g++;
      }
      
  }
  if(save)
  {
    println(g);
    endRecord();
    save = false;
  }
}
//endRecord();
void keyPressed()
{
  if(key == 's') save = true;
}
