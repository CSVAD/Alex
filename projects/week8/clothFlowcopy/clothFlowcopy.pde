//Adapted from this link to processing from python and optimized for axidraw
//https://discourse.processing.org/t/trying-to-create-wave-cloth-flow-pattern/11795/8

import processing.pdf.*;
import java.sql.Timestamp;

size(792,612);
ArrayList<PVector> points =  new ArrayList<PVector>();
int edge = 10;
int step = 7;
int res = (width - (edge*2)) / step;
int nLines = (height*2) / step;
float factor = .0014;
float off = 0;
float x2 = 0;

int x = 0;
for(int i = 0; i < (int)((height*2) - edge)/step; i++)
{
    x = edge + i * step;
    if(x > height)
    {
        x2 -= step;
        off += step;
    }
    else
    {
        x2 = x;
    }
    
    float n = 0;
    for(int y = edge; y < width - edge; y += step)
    {
        n = noise(x2 * factor, (x+y) * factor);
        if(i > 5 && i < nLines - 5)
        {
            points.add(new PVector(y, off + x2 * n));
        }
    }
        
}

Timestamp timestamp = new Timestamp(System.currentTimeMillis());

beginRecord(PDF, timestamp.toString() + "plot.pdf"); 
noFill();

int g = 0;
beginShape();
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
print(g);
endRecord();
