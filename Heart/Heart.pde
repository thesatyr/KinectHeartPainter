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
   background(0);
   
   shape (v, 0, 0);
   colorMode(RGB);
   fill((millis()-oldTime/150), 34, 47);
   rect(160, 700, (millis()-oldTime)/53, 20);
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
  //background(0);
 // shape (v, 0, 0);
  
  ///ab = ab + 0.04;
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
      myArray[i][j]= dubey[i][j]*1.21;
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

//draw the body
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  //Single joints
  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

//draw a single joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw a bone from two joints
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw a ellipse depending on the hand state
void drawHandState(KJoint joint) {
  noStroke();
  int k = handState(joint.getState());
  pushMatrix();
  translate(joint.getX()*2, joint.getY()*2, joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */

//Depending on the hand state change the color
int handState(int handState) {
  int r1=4;
  switch(handState) {

  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    r1=1;
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    r1= 0;
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    r1= 3;
    break;
  case KinectPV2.HandState_NotTracked:
    fill(100, 100, 100);
    r1= 4;
    break;
  }
  return r1;
}
