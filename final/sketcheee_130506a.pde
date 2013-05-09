import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;

import controlP5.*;
ControlP5 controlP5;

Minim minim;
AudioPlayer song;
AudioPlayer[] rsong = new AudioPlayer[4];  

AudioPlayer in;
LowPassSP lowpass;
FFT fft;
AudioOutput out;
SquareWave sine;
SawWave sine2;
SineWave sine3;
WhiteNoise nsine;
float frequency,amp;

boolean S0, S1, S2, S3, S4;
int ycol=0;
int ycol2=74;
int ycol3=200;


face eye1=new face(200, 150);
face eye2=new face(400, 150);
//the mouth
face mouth1=new face(140, 350);
face mouth2=new face(240, 400);
face mouth3=new face(340, 400);
face mouth4=new face(440, 350);

float color1 = 35;
float color2 = 45;
float color3 = 65;
float color4 = 75;

 
 
 
void setup()
{
  S1=false;
  S2=false;
  S3=false;
  S4=false; 
  S0=false;
  size(800,600);
  minim = new Minim(this);
  
  rsong[0] = minim.loadFile("kw.mp3", 1024);
  rsong[1] = minim.loadFile("msd.mp3", 1024);
  rsong[2] = minim.loadFile("kill.mp3", 1024);
  rsong[3] = minim.loadFile("tl.mp3", 1024);
  
  song = rsong[(int)(random(rsong.length))];
  song.play();
  fft = new FFT(song.bufferSize(), song.sampleRate());
  fft.logAverages(22,3); 
  
  
   
}

void keyPressed() {
  if (key=='1') {
    //song.close();
    //song = minim.loadFile("kw.mp3");
     song.pause();
  
     song = rsong[(int)(random(rsong.length))];
     song.play();
     fft = new FFT(song.bufferSize(), song.sampleRate());
     fft.logAverages(22,3); 
    
    
    
  }
  else if (key=='2') {
    S1=false;
    S2=false;
    S3=false;
    S4=false;
    S0=true;
  }
  else if (key=='3') {
    S1=true;
    S2=false;
    S3=false;
    S4=false;
    S0=false;
  }
  else if (key=='4') {
    S2=true;
    S1=false;
    S3=false;
    S4=false;
    S0=false;
  }
  else if (key=='5') {
    S2=false;
    S1=false;
    S3=true;
    S4=false;
    S0=false;
  }
  else if (key=='6') {
    S2=false;
    S1=false;
    S3=false;
    S4=true;
    S0=false;
  }
}






void draw()
{
  background(0);
  frequency=(float)width/800.0*(float)mouseX+100.0;
  amp=(float)mouseY/(float)height;
  
  
  if (S0){
    strokeWeight(5);
    stroke(255,0,156);
    for (int i = 0; i < fft.avgSize(); i++){
      line((float)i*15+(float)(width-10)/32.0+5.0,3*height/4,(float)i*15+(float)(width-10)/32.0+5.0,3*(float)height/4 - fft.getAvg(i));
  }
  

  
  
  }

  
  
  
  else if (S1){
    strokeWeight(0);
    noStroke();
    fill(0, 5);
    rect(0,0,width,height);
    pushMatrix();
    translate(width/3, height/2);
    rotate(radians(frameCount % 360 * 2));
      for(int j = 0; j < 360; j++) {
        if(song.mix.get(j)*200 > 50) {
          stroke(color1,100,100);
          }
        else {
          stroke(color2,100,100);
          }
       
        line(cos(j)*50, sin(j)*50, cos(j)*abs(song.left.get(j))*200 + cos(j)*50, sin(j)*abs(song.right.get(j))*200 + sin(j)*50);
      }
      
    for(int k = 360; k > 0; k--) {
      if(song.mix.get(k)*200 > 25) {
        stroke(color3,100,100);
      }
      else {
        stroke(color4,100,100);
      }  
      line(cos(k)*50, sin(k)*50, cos(k)*abs(song.right.get(k))*200 + cos(k)*50, sin(k)*abs(song.left.get(k))*200 + sin(k)*50);  
    }
  popMatrix();
}
    
  
    
  
  
  
  
  
  else if (S2) {
    strokeWeight(0);
    colorMode(HSB);
    //color varialbe so I can change it in the sketch
    fill(150, ycol2, 172);
    //the size of circles of the mouth changes with song
    
    //the(256)*400; changes how far up and down it can go

    float esize = song.mix.get(256)*400;
    //the 2 eyes
    //this is the for class the location is decaler above
              
    eye1.display2(); 
    eye2.display2();
    //the mouth controlled by sound
    mouth1.display(esize); 
    mouth2.display(esize);
    mouth3.display(esize); 
    mouth4.display(esize);
  }

  




  else if (S3){
    strokeWeight(5);
    noStroke();
    fill(0, 0,0.5);
    rect(0, 0, width, height);
    pushMatrix();
    translate(width/3, height/2);
    rotate((frameCount % 360 * 1000));
   
    for (int j = 0; j < 360; j++) {
   //println(song.mix.get(j));
      if (song.mix.get(j) > 0.5) {
         println("iii");
         fill( 50, 20, 100);
    rect(-width, -height, width*4 , height*4);
    
      }
   
      if (song.mix.get(j)*200 > 29) {
        line(43, 0, 0, 30);
      }
      else {
        stroke(34, 100, 10, 35);
      }
   
      line(tan(j)*50, sin(j)*50, sin(j)*abs(song.left.get(j))*200 + sin(j)*50, sin(j)*abs(song.right.get(j))*120 + sin(j)*50);
    }
    for (int k = 360; k > 0; k--) {
   
   
      if (song.mix.get(k)*200 > 25) {
        stroke(35, 25, 100);
      }
      else {
        stroke(35, 255, 100);
      }
   
   
      line(sin(k)*50, sin(k)*50, cos(k)*abs(song.left.get(k))*200 + cos(k)*50, cos(k)*abs(song.right.get(k))*200 + sin(k)*50);
    }
   
    popMatrix(); 
    
    
  }
  
  
  
  
  
  if (S4){
      strokeWeight(0);
      stroke(35, 255, 100);
      
      for(int i = 0; i < song.left.size()-1; i++)
    {
     
      line(i, 370 + song.left.get(i)*50, i-1, 370 + song.left.get(i+1)*50);
      line(i, 270 + song.right.get(i)*50, i+1, 270 + song.right.get(i+1)*50);
    }
    
  }
  
  
  
        
      
        textSize(14);
        fill(255);
        line(2*width/5-5,height/8+5,3*width/5+50,height/8+5);
        text("Music Visualizations",2*width/5,height/8);
        text("Use these controls to change visualizations!",5*width/8,2*height/7);
        text("-1 Start or Switch Songs",5*width/8+5,2*height/7+20);
        text("-2 Bars",5*width/8+5,2*height/7+40);
        text("-3 The Sun",5*width/8+5,2*height/7+60);
        text("-4 The Smiley",5*width/8+5,2*height/7+80);
        text("-5 Cartoonish Ball",5*width/8+5,2*height/7+100);
        text("-6 The Waves",5*width/8+5,2*height/7+120);
  
        text("By Gustavo and Cambell",5*width/8+30,6*height/7+5);
       
         fft.forward(song.mix); 
        
    }
   
  
  
  
  
  
  
  void stop()
  {
  song.close();
  minim.stop();
  super.stop();
}


