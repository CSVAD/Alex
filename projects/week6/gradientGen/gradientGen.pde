import controlP5.*;

ArrayList<Swatch> swatches;
Swatch selectedSwatch1;
Swatch selectedSwatch2;
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
  images = dir.list();
  size(1280, 960);
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
}
void mousePressed(){
  Swatch s = checkForSwatchHit(mouseX,mouseY);
  if(s != null){
     s.selected = true;
    selectedSwatch1 = s;
  }
  else {
    color c = get(mouseX, mouseY);
    swatches.add(new Swatch(mouseX, mouseY, 20.0, (int)red(c), (int)green(c), (int)blue(c)));
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
