// panoplie_alphabet
// 
// https://github.com/aurelienmaufroid.fr/panoplie-font/


import processing.pdf.*;
import java.util.Calendar;
import processing.svg.*;
import controlP5.*;

ControlP5 controlP5;


boolean savePDF = false;

float tileCount = 20;
color circleColor = color(0);
int circleAlpha = 180;
int actRandomSeed = 0;

//Image import
PImage pattern, pattern2;

PShape patternShape, patternShape02, patternShape03; //specifical variable for svg file

//PGraphics object variables
PGraphics g;
PImage imgStart;
String txt = "a";
PFont f;
String[] s;

//Typeface variables
PFont Alphabet;
int n = 0, maxDistance;
int size = 200;

//Light value per pixel variables
float lumiere = 0;
//Total average light
float totallux = 0;

//Loup pointer effect variables
int distancePointer = 500;
int nShift, nbTab = 0;
float diameter;

float xGap = 50, yGap;

int nb = 1; // ! ATTENTION ! Bien modifier ce nombre sinon ça va écraser le fichier enregistré précédemment.

//Single storage file name variables
int sec = second();
int min = minute();
int hour = hour();
int randomName;

color[] c = {color(255, 0, 0), color(0, 255, 0)};

String patternName = "oeiltraits2", 
pattern2Name = "triangle01", 
shapeName = "traits01", 
shape02Name = "prison";

int maxsize = 80; //150*2

//Variable alphabet letters upercase
String[] uppercaseletters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "à", "é", "è", "ù", ".", ",", ";", ":", "!", "?", "-", "œ", "»", "«"};

//Variable tampon pour stocker le tracé pour l'exportation
PGraphics canvas;

int shapeload = 0;
String nameShape;

float scalecanvas = 1000;

//Variable controlP5
float valeurSlider1;


/////////////////////// SETUP //////////////////////////////////////////////////
void setup(){
  selectInput("Select a svg file to process:", "fileSelected");
  size(1000, 800); //2000, 2000
  surface.setResizable(true);
  //fullScreen();
  frameRate(30);
  
  pattern = loadImage(patternName + ".png");
  pattern2 = loadImage(pattern2Name + ".png");
  
  patternShape = loadShape(shapeName + ".svg");
  patternShape02 = loadShape(shape02Name + ".svg");

  
  imgStart = loadImage("ellipse1.png");
  
  patternShape03 = loadShape("contreforme_eye01.svg");
  
  //g = createGraphics(width, height);
  //canvas = createGraphics(width, height);
  f = createFont("Bagnard.otf", size); //Paramètre à modifier : gère la taille (le corps de caractère) de la typo
  
  ///////CREATE OBJECTS INTERFACE
  controlP5 = new ControlP5(this);
  
  controlP5.addGroup("p1", 10, 10, 200)
    .setBackgroundColor(color( #ebebeb ))
    .setColorBackground(#e52329).setColorForeground(#ff665e)
    .setBackgroundHeight(300);
  
  controlP5.addSlider("slidermaxwidth",0, 300, 80, 10,150,180,20)
    .setColorBackground(#FFFFFF).setColorForeground(#ff665e)
    .setColorActive(#e52329)
    .setGroup("p1")
    .setColorCaptionLabel(color(20,20,20))
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE)
    .setPaddingX(0).setText("taille max module");
    
  controlP5.addSlider("sliderxGap",10, 200, 50, 10,200,180,20)
    .setColorBackground(#FFFFFF).setColorForeground(#ff665e)
    .setColorActive(#e52329)
    .setGroup("p1")
    .setColorCaptionLabel(color(20,20,20))
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE)
    .setPaddingX(0).setText("xGap");
    
  controlP5.addSlider("sliderScalecanvas",100, 1000, 1000, 10,250,180,20)
    .setColorBackground(#FFFFFF).setColorForeground(#ff665e)
    .setColorActive(#e52329)
    .setGroup("p1")
    .setColorCaptionLabel(color(20,20,20))
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE)
    .setPaddingX(0).setText("corps");
    
  /*controlP5.addButton("button",0,10,150,20,20).setGroup("p1")
    .setColorCaptionLabel(color(20,20,20))
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE)
    .setPaddingX(0);*/
    
  controlP5.addButton("modules",0,10,20,180,60)
    .setColorBackground(#ff665e).setColorForeground(#e52329)
    .setGroup("p1")
    .setColorCaptionLabel(color(255))
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setPaddingX(0);
  
  //beginRecord(SVG, "screenshots/" + shape02Name + "/" + txt + "_" + hour+min+sec + "xGap="+xGap + "maxsize=" + maxsize + ".svg");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    //shapeload=0;
  } else {
    //println("User selected " + selection.getAbsolutePath());
    patternShape02 = loadShape(selection.getAbsolutePath());
    nameShape = selection.getName();
    //shapeload=1;
    
  }
}

/////////////////////// DRAW //////////////////////////////////////////////////
void draw() {
  g = createGraphics(displayWidth, displayHeight);
  //if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  if(shapeload == 1){
  //loop variable uppercase letters
  for(int i=0 ; i < uppercaseletters.length ; i++){
    println(i);
    txt = uppercaseletters[i];
    if (uppercaseletters[i] == "?"){
      canvas = createGraphics(width, height, SVG, "export/" + nameShape + hour + min + sec + "_" + "xGap="+xGap + "_maxsize=" + maxsize + "/output_interrogation.svg");
    }else if (uppercaseletters[i] == ":"){
      canvas = createGraphics(width, height, SVG, "export/" + nameShape + hour + min + sec + "_" + "xGap="+xGap + "_maxsize=" + maxsize + "/output_deuxpoints.svg");
    }else{
      canvas = createGraphics(width, height, SVG, "export/" + nameShape + hour + min + sec + "_" + "xGap="+xGap + "_maxsize=" + maxsize + "/output_" + uppercaseletters[i] + ".svg");
    }
  }
  }else{
    canvas = createGraphics(width, height);
  }
    
  
  
  background(255);
  //image(imgStart, 15, -55, 780, 1000);
  g.beginDraw();
  g.fill(0);
  g.background(255);
  g.textFont(f);
  g.textSize(scalecanvas);
  g.textAlign(CENTER, CENTER);
  txt = txt.toUpperCase();
  g.text(txt, width/2, height/3);
  //g.image(imgStart, 0,0, width, height);
  g.endDraw();
  
  //image(g, 0, 0, width/5, height/5);

  //translate(width/tileCount/2, height/tileCount/2);
  canvas.beginDraw();
  canvas.background(255);
  smooth();
  noFill();
  
  randomSeed(actRandomSeed);
  
  yGap = 33 * patternShape02.width/patternShape02.height;

  stroke(circleColor, circleAlpha);
  //strokeWeight(mouseY/60);
  
  

  for (int x=0; x<g.width; x+=xGap-5) {
    for (int y=0; y<g.height; y+=yGap) {
      float shiftX = random(-mouseX, mouseX)/20;
      float shiftY = random(-mouseX, mouseX)/20;
      
      //maxsize = 150*2;
      println("maxsize: "+maxsize);
      float rand = random(0,maxsize); //5, 150
      
       //Récupération des infos de couleur du pixel
        color couleurLocale = g.get(x,y);
        
        //Récupération des valeurs rouge, vert, bleu
        float r1 = red(couleurLocale); //valeur entre 0 et 255
        float v1 = green(couleurLocale); //valeur entre 0 et 255
        float b1 = blue(couleurLocale); //valeur entre 0 et 255
        
        //Calcul de la quantité de blanc sur ce pixel
        lumiere = r1 + v1 + b1; //résultat entre 0 et 765
      
      if(lumiere <= 150){ //150
        //ellipse(posX+shiftX, posY+shiftY, mouseY/15, mouseY/15);
        //ellipse(posX+shiftX, posY+shiftY, rand, rand);
        //image(pattern, x, y, 10, 10);
        //image(pattern, x, y, rand, rand);
        //image(pattern, x+shiftX, y+shiftY, rand, rand);
        //image(pattern2, posX+shiftX, posY+shiftY, rand, rand);
        canvas.noStroke();
        patternShape.disableStyle();
        patternShape02.disableStyle();
        patternShape03.disableStyle();
        //fill(0, 0, 255);
        canvas.fill(255);
        //canvas.shape(patternShape03, x+shiftX, y+shiftY, rand, rand);
        //fill(c[int(random(c.length))]);
        canvas.fill(0);
        //println(c);
        canvas.shape(patternShape02, x, y, rand, rand);
        //blendMode(MULTIPLY);
        //fill(0, 255, 0);
        fill(0);
        //shape(patternShape02, x+shiftX, y+shiftY, rand, rand);
        
      }else {
        fill(255);
      }
    }
  }
  
  
  /*if (savePDF) {
    savePDF = false;
    endRecord();
  }*/
  
  
  canvas.dispose();
  canvas.endDraw();
  //endRecord();
  //}//end loop uppercase letters
  
  if (shapeload == 0){
    image(canvas, 0, 0, width, height);
  }else{
    exit();
  }
  
  
  
  int rfile = int(random(200));
  //saveFrame("screenshots/" + patternName + "/" + txt + "_" + hour+min+sec + "xGap="+xGap + "maxsize=" + maxsize + ".png");
  //saveFrame("screenshots/" + pattern2Name + "/" + txt + "_" + hour+min+sec + "xGap="+xGap + "maxsize=" + maxsize + ".png");
  //saveFrame("screenshots/" + shapeName + "/" + txt + "_" + hour+min+sec + "xGap="+xGap + "maxsize=" + maxsize + ".png");
  //saveFrame("screenshots/" + shape02Name + "/" + txt + "_" + hour+min+sec + "xGap="+xGap + "maxsize=" + maxsize + ".png");

  //exit();
  //};
}

void slidermaxwidth(int valeur){
  println("une valeur reçu par slidermaxwidth: "+valeur);
  maxsize = valeur;
}

void sliderxGap(int valeur){
  println("une valeur reçu par sliderxGap: "+valeur);
  xGap = valeur;
}

void sliderScalecanvas(int valeur){
  println("une valeur reçu par sliderxGap: "+valeur);
  scalecanvas = valeur;
}

void button(){
  shapeload = 1;
}

void modules(){
  selectInput("Select a svg file to process:", "fileSelected");
}


  void keyPressed(){
  //saveFrame("sreenshots/imgtrame"+ nb +".jpg");
  //nb++;
  
  if (keyCode == BACKSPACE) {
    if (txt.length() > 0) {
      txt = txt.substring(0, txt.length()-1);
    }
  } else if (keyCode == DELETE) {
    txt = "";
  } else if (keyCode != ENTER && key != '-' && keyCode != ALT && keyCode != RIGHT && keyCode != LEFT) {
    fill(255);
    txt = txt + key;
  } else if (keyCode == ENTER){
    
  }
  
  if (key == '-') {
    //saveFrame("sreenshots/" + txt + "_" + nb +".png");
    int rfile = int(random(200));
    saveFrame("screenshots/" + txt + "_" + hour+min+sec+rfile +".png");
    nb++;
  }
  
  if(keyCode == ALT){
    nShift = 1;
    print("Alt activée ");
  }
  
  
  
  
}

void keyReleased(){
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
