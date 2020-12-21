//Randomly selects a font
String[] fonts = {"Georgia", "Times-Roman", "Times-Bold", "Papyrus", "Helvetica", "Futura-Bold"};

class Letter {
  float r = random(250);
  float g = random(250);
  float b = random(250);
  float xPos = random(width);
  float yPos = random(-500, -50);
  float z = random(0, 20);
  float fontSize = int(random(90, 120));
  float ySpeed = random(1, 5);
  float xOffset = 0;
  float yOffset = 0;
  PFont font;
  boolean letterOver = false;
  boolean locked = false;
  char txt;
  LinkedList<Letter> sameChars = new LinkedList<Letter>(); 
  boolean falling = true;

  Letter(char txt) {
    //Initialize font
    float font_index = random(fonts.length);
    font = createFont(fonts[int(font_index)], fontSize);
    this.txt = txt;
  }

/**
The show() method has a different effect on Letter objects depending on whether 
or not the Letter object is falling. If a letter is falling, it will fall at a
random speed and from a random location, and feels the effects of gravity, 
representing a rainlike effect. Otherwise, if it is not falling, they glimmer
and jiggle. 
**/
  void show() {
    
    //Falling effect
    if (this.falling) {
      this.yPos = this.yPos + this.ySpeed;
      float gravity = map(this.z, 0, 20, 0, 0.2);
      this.ySpeed = this.ySpeed * 0.95 + gravity;
      if (this.yPos > height + 150) {
        this.yPos = random(-200, -100);
        this.ySpeed = map(this.z, 0, 20, 4, 10);
        this.xPos = random(width);
      }
    } else {
      xPos += random(-0.2, 0.2);
      yPos += random(-0.2, 0.2);
    }
    
    //Mouse is on a letter
    if (mouseX >= this.xPos-(this.fontSize/2) && mouseX <= this.xPos-(this.fontSize/2) + this.fontSize && 
      mouseY >= this.yPos-(this.fontSize/2 + 5) && mouseY <= this.yPos-(this.fontSize/2 + 5) + this.fontSize) {
      this.letterOver = true;
      
      fill(255); //Turn letter white if mouse is on letter
    } else {
      this.letterOver = false;
    }
    
    //Draw the letter on the screen in the randomly generated font
    text(this.txt, xPos, yPos);
    textFont(this.font);
    fill(r, g, b);
  }  

  void gatherSimilar() {
    
    //for reach Letter obj in the sameChars list
    for (Letter sameChar : this.sameChars) {
      
      //Make the Letter stop falling
      sameChar.falling = false;
      
      //Calculates the difference between every similar Letter object. 
      //Similar objects go over to the lead Letter object in focus
      float xDiff = this.xPos - sameChar.xPos;
      float yDiff = this.yPos - sameChar.yPos;
      float xIncr = xDiff / 1000;
      float yIncr = yDiff / 1000;
      for (int i = 0; i < 1000; i++) {
        sameChar.xPos += xIncr;
        sameChar.yPos += yIncr;
      }
    }
  }
}
