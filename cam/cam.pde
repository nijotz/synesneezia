// import audio player
import ddf.minim.*;
Minim minim;


import processing.video.*;

Capture video;

PImage prevFrame;

//float[] jurts = {130.81,155.56,185};  
float[] jurts = {130.81,0,0};  
Zone[] zones = new Zone[jurts.length];


void setup() {
  int screen_width = 640;
  int screen_height = 480;
  size(screen_width, screen_height);
  minim = new Minim(this); //define or create what minim is before the zone is established
  //zone = new Zone(100,100,440,280);
  video = new Capture(this,width,height,30);
  video.start();
  prevFrame = createImage(video.width, video.height,RGB);
  stroke(0,0,255);
  
  for(int i = 0; i < jurts.length; i ++){
    int zone_width = screen_width / jurts.length;
    int zone_height = screen_height;
    int zone_x = zone_width * i;
    int zone_y = 0;
    println("x: " + zone_x);
    println("y: " + zone_y);
    println("w: " + zone_width);
    println("h: " + zone_height);
    println();
    zones[i] = new Zone(zone_x, zone_y, zone_width, zone_height, jurts[i]);  
}
  for(int i = 0; i<zones.length; i ++){
    zones[i].check();
  }
    
}

void draw(){
  if(video.available()){
    prevFrame.copy(video, 0, 0, video.width, video.height,0,0,video.width, video.height);
    prevFrame.updatePixels();
    video.read();  
  }
  
  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();
  int w = video.width;
  int h = video.height;
  for(int x = 0; x < video.width; x++){
    for(int y = 0; y < video.height; y++){
      int loc = y+x*video.height;
      pixels[loc] = video.pixels[loc];
      //pixels[w*h-loc-1] = video.pixels[loc];
      //pixels[abs(int(random(1,w))*int(random(1,h))-loc-1)] = video.pixels[loc];
    }
  }
  updatePixels();

  for(int i= 0; i<zones.length; i ++){
    zones[i].check();
  }


}  
