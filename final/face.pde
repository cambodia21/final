//the class
class face {
  //positions varialbes
  float xpos, ypos;
  //the sound variable to move the mouth
  float esize;
  face(float passedX, float passedY) {
    //lets me change the cordinates in first claa
    xpos=passedX;
    ypos=passedY;
  }//close of the constructer
  // i do 2 different displayes since im doing d2 differnet style of elipses
  void display(float esize2) {
    //this is a variabel for the sound i pass in on the brazilfinal
    esize=esize2;
    //mouth
    ellipse(xpos-55, ypos+20, 70, esize);
  }//close method
  //eyes
  void display2() {
    //i did two different ellispse this is the other style of one it does not move
    ellipse(xpos-55, ypos+20, 70, 70);
  }
}
