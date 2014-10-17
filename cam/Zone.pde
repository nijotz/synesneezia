class Zone {  
  AudioOutput player;
  //AudioPlayer player;
  int x, y,width,height; 
  float threshold = 12;
  float note;
  Zone (int x, int y, int w, int h, float note) {  
    // use the getLineOut method of the Minim object to get an AudioOutput object
    player = minim.getLineOut();
    
    // set the tempo of the sequencer
    // this makes the first argument of playNote 
    // specify the start time in quarter notes
    // and the duration becomes relative to the length of a quarter note
    // by default the tempo is 60 BPM (beats per minute).
    // at 60 BPM both start time and duration can be interpreted as seconds.
    // to retrieve the current tempo, use getTempo().
    player.setTempo( 80 );
    
    // pause the sequencer so our note play back will be rock solid
    // if you don't do this, then tiny bits of error can occur since 
    // the sequencer is running in parallel with you note queueing.
    //player.pauseNotes();
    
      
    //player = minim.loadFile("camPDE.mp3");// 
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.note = note;
  }
  
  void show(){
    noFill();
    rect(x,y,width,height);
  }
  
  // look at change of pixel data in the zone
  void check(){
    float total = 0; 
    float average = 0;
    
    // Begin loop to walk through every pixel
    for (int x = this.x; x < this.width; x ++ ) {
      for (int y = this.y; y < this.height; y ++ ) {
       
        int loc = x + (y * video.width);        // Step 1, what is the 1D pixel location
        color current = video.pixels[loc];      // Step 2, what is the current color
        color previous = prevFrame.pixels[loc]; // Step 3, what is the previous color
       
        // Step 4, compare colors (previous vs. current)
        float r1 = red(current); float g1 = green(current); float b1 = blue(current);
        float r2 = red(previous); float g2 = green(previous); float b2 = blue(previous);
        float diff = dist(r1,g1,b1,r2,g2,b2);
        
        total = total + diff;
      }
    }
   
    average = total / (this.width * this.height);
    
    if (average > this.threshold) {
        // If motion, display show block 
        this.show();
        this.play();   
    }
  } // end check()
  
  void play(){
    this.player.playNote(this.note);
  }
} // end Zone
