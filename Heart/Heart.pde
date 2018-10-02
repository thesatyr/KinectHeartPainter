/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/
 KinectPV2, Kinect for Windows v2 library for processing
 Skeleton depth tracking example
 */

import java.util.ArrayList;
import KinectPV2.KJoint;
import KinectPV2.*;
import ddf.minim.*;
int stateof;
PShape g, v;
KinectPV2 kinect;


void setup() {
  m = new Minim(this);
  a= m.loadFile("pop1.wav", 700);
  size(1024, 768, P3D);

  background (0);
  colorMode(HSB, 300);
  dubey [15][15]=20000;
  frameRate=300;

  kinect = new KinectPV2(this);

  //Enables depth and Body tracking (mask image)
  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);

  kinect.init();
  g = loadShape ("tyu.svg");
  v = loadShape ("yoy.svg");
}

boolean d=true;
boolean gameOver()
{

  //println("gmaeover ran");
  for (int i = 5; i < cols-5; i++) 
  {
    for (int j = 3; j < rows-10; j++) 
    {
      if (myArray[i][j]>255)
      { 
        d= false;
        //println("gmaeover ran false");
        //println(millis()-oldTime);
      } else
        d=true;
      //println("gmaeover ran true");
    }
  }
  return d;
}


boolean erased=true;
void draw1() {
  println("draw1 ran");
  println((millis()-oldTime));
  fill(100);
  ellipse(100, 100, 100, 100);
  yay();
  if ((millis()-oldTime)>40000)
  {

    for (int i = 0; i < cols; i++) 
    {
      for (int j = 0; j < rows; j++) 
      {


        myArray[i][j]=10;
        dubey[i][j]=10;
        println((millis()-oldTime));
        println("erasing myarray");
        erased =true;
        d=true;
      }
    }
  }
}
float s= 0.0;
float ab= 0.0;
void yay() {
  background(0);
  shape (v, 0, 0);
  //ab = ab + 0.04;
  // s= cos(ab)*2;
  //scale(s);

  //ellipse(r1,r2,80,80);
  //ellipse(r2,r3,80,80);
  //ellipse(r1,r3,80,80);
}


int oldTime=0;
void draw() {

  // background(0);

  //image(kinect.getDepthMaskImage(), 0, 0);

  for (int i = 0; i < cols; i++) 
  {
    for (int j = 0; j < rows; j++) 
    {
      if (myArray[i][j]==0)
      {
        myArray[i][j]=10;
      } else
        //myArray[i][j]= dubey[i][j]*1.012;
      myArray[i][j]= dubey[i][j]*1.2;
    }
  }
  clear();
  gameOver();
  if (d==false)
  { 
    if (erased == true)
    {
      oldTime=millis();
      erased=false;
    }
    draw1();
  } else {
    c.update();
    c.substract();
    c.add();

    // println (frameRate);

    //get the skeletons as an Arraylist of KSkeletons
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonDepthMap();

    //individual joints
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      //if the skeleton is being tracked compute the skleton joints
      if (skeleton.isTracked()) {
        KJoint[] joints = skeleton.getJoints();

        color col  = skeleton.getIndexColor();
        fill(col);
        stroke(col);

        //drawBody(joints);
        drawHandState(joints[KinectPV2.JointType_HandRight]);
        c.sujithr(joints[KinectPV2.JointType_HandRight]);

        drawHandState(joints[KinectPV2.JointType_HandLeft]);
        c.sujithl(joints[KinectPV2.JointType_HandLeft]);
      }
    }

    fill(255, 0, 0);
    text(frameRate, 50, 50);





    shape (g, 0, 0);
  }
}

cell c = new cell();
int cols = 50;
int rows = 40;
int k = 1;
float [][] myArray = new float[cols][rows];
float [][] dubey = new float[cols][rows];
Minim m;
AudioPlayer a;
int k1;


class cell 
{
  void update()
  {


    for (int i = 0; i < cols; i++) 
    {
      for (int j = 0; j < rows; j++) 
      {
        //ellipse((i+1)*30, (j+1)*30, myArray [i] [j]/3, myArray [i] [j]/3);
        rect((i+1)*30, (j+1)*30, myArray [i] [j]/3, myArray [i] [j]/3);
        //pushMatrix();
        //translate((i+1)*30, (j+1)*30, 1);
        //stroke(0);
        noStroke();
        fill (round(myArray[i][j]), round(myArray[i][j]), round(myArray[i][j]));
        //  rotateZ(myArray[i][j]); 
        //box( myArray [i] [j]/5);
        // popMatrix();
      }
    }
  }

  void substract()
  {
    for (int i = 0; i < cols; i++) 
    {
      for (int j = 0; j < rows; j++) 
      {
        dubey[i][j]= .92*myArray[i][j];
      }
    }
  }

  void add()
  { 
    for (int i = 1; i < (cols-2); i++) 
    {
      for (int j = 1; j < (rows-2); j++) 
      {

        for (int m = (i-1); m<=(i+1); m++)
        {

          for (int n = (j-1); n <= (j+1); n++)
          { 
            if (m==i && n==j)
            {
              break;
            } else
            {
              dubey [m][n] = dubey [m][n] + .0099* myArray [i][j];
            }
          }
        }
      }
    }
  }

  void sujithr(KJoint joint)
  {
    for (int i = 0; i < cols; i++) 
    {
      for (int j = 0; j < rows; j++) 
      {
        noStroke();
        int k = handState(joint.getState());                          
        if (  joint.getX()*2 > ((i+1)*30-(myArray[i][j]/4)) && joint.getX()*2 < ((i+1)*30+(myArray[i][j]/4)) &&  joint.getY()*2> ((j+1)*30-myArray[i][j]/4) && joint.getY()*2 < ((j+1)*30+(myArray[i][j]/4)) ) 
        { 
          if (  k== 1) 
          {
            dubey [i][j]=400;
          } else if ( k == 0)
            dubey [i][j]=400;
        }
      }
    }
  }
  void sujithl(KJoint joint)
  {
    for (int i = 0; i < cols; i++) 
    {
      for (int j = 0; j < rows; j++) 
      {
        noStroke();
        int k = handState(joint.getState());                          
        if (  joint.getX()*2 > ((i+1)*30-(myArray[i][j]/4)) && joint.getX()*2 < ((i+1)*30+(myArray[i][j]/4)) &&  joint.getY()*2> ((j+1)*30-myArray[i][j]/4) && joint.getY()*2 < ((j+1)*30+(myArray[i][j]/4)) ) 
        { 
          if (  k== 1) 
          {
            dubey [i][j]=400;
          } else if ( k == 0)
            dubey [i][j]=400;
          a.play();
          a.rewind();
        }
      }
    }
  }
}
