import controlP5.*;

ArrayList<Swatch> swatches;
ArrayList<Gradient> gradients;
Swatch selectedSwatch1;
Swatch selectedSwatch2;
boolean move = false;
Swatch moveSwatch;
ControlP5 controlP5;
String image;
String[] images;
String imagefolder;

void setup() {
  File dir = new File(sketchPath() + "/images");
  imagefolder = sketchPath() + "/images/";
  if(!dir.exists())
  {
    println("Counld not find image folder ERROR.");
    exit();
  }
  swatches = new ArrayList<Swatch>();
  gradients = new ArrayList<Gradient>();
  images = dir.list();
  size(1280, 960, P2D);
  controlP5 = new ControlP5(this);
  DropdownList imgList = controlP5.addDropdownList("image").setPosition(25, 25);
  for(int i = 0; i < images.length; i++)
  {
    imgList.addItem(images[i], images[i]);
  }
  image = imagefolder + images[0];
  background(128);
}

void controlEvent(ControlEvent e)
{
  if(e.isController()){
    image = imagefolder + images[(int) e.getController().getValue()];
  }
}

void draw()
{
  background(128);
  PImage img = loadImage(image);
  imageMode(CENTER);
  image(img, width/2, height/2);
  for(int i=0;i<swatches.size();i++){
    swatches.get(i).draw();
  }
  for(int i=0;i<gradients.size();i++){
    gradients.get(i).draw();
  }
}
void mousePressed(){
  Swatch s = checkForSwatchHit(mouseX,mouseY);
  if(s != null){
      moveSwatch = s;
      //println(str(s.red) + '\t' + str(s.gre) + '\t' + str(s.blu));
   }
   else if(!move){
    color c = get(mouseX, mouseY);
    swatches.add(new Swatch(mouseX, mouseY, 20.0, (int)red(c), (int)green(c), (int)blue(c)));
  }
}
void mouseClicked(MouseEvent evt) {
  if (evt.getCount() == 2){
    Swatch s = checkForSwatchHit(mouseX,mouseY);
    if(s != null){
      if(s == selectedSwatch1)
      {
        selectedSwatch1.selected = false;
        selectedSwatch1 = null;
      }
      else if(selectedSwatch1 != null)
      {
        selectedSwatch1.selected = false;
        selectedSwatch2 = s;
        gradients.add(new Gradient(selectedSwatch1, selectedSwatch2));
        selectedSwatch1 = null;
        selectedSwatch2 = null;
      }
      else 
      {
       s.selected = true;
       selectedSwatch1 = s;
      }
     }
  }
}
void keyPressed(){
  if(key == 'z'){
    if(!swatches.isEmpty())
    {
     Swatch temp = swatches.remove(swatches.size() - 1);
     for(int i = 0; i < gradients.size(); i++)
     {
       if(gradients.get(i).s1 == temp || gradients.get(i).s2 == temp)
       {
         gradients.remove(i);
         i--;
       }
     }
    }
  }
  else if(key == 'm'){
    move = true;
  }
}
void keyReleased(){
  move = false;
}
void mouseReleased(){
  moveSwatch = null;
}
void mouseDragged(){
   PVector delta = new PVector(mouseX-pmouseX,mouseY-pmouseY);
   if(moveSwatch != null){
     if(move == true){
       moveSwatch.moveBy(delta);
     }
     return;
   }   
}
Swatch checkForSwatchHit(int x,int y){
   for(int i=swatches.size()-1;i>=0;i--){
   Swatch s = swatches.get(i);
   boolean hitTest = s.hitTest(x,y);
   
   if(hitTest == true){
       return s;
   }
  } 
  return null;
}
void deselectAllSwatches(){
   for(int i=0;i<swatches.size();i++){
      swatches.get(i).selected = false;
   }
   selectedSwatch1 = null;
}
