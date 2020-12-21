PFont f;
import java.util.*; 
LinkedList<Letter> letters = new LinkedList<Letter>(); 
  float r = random(250);
  float g = random(250);
  float b = random(250);

void setup() {
  size(1000, 700);
}

void draw() {
  background(r, g, b);
  for (Letter letter : letters) {
    letter.show();
  }
}

/**
When the mouse is pressed, if over a letter, letter stops falling,
and gathers with its similar letters, and starts shimmering.

Locked means that you're clicking and dragging the letter.
**/
void mousePressed() {
  for (Letter letter : letters) {
    //if mouse on letter, turn letter white
    if (letter.letterOver == true) {
      letter.locked = true;
      letter.falling = false;
      letter.gatherSimilar();
    } else {
      letter.locked = false;
    }
    letter.xOffset = mouseX - letter.xPos;
    letter.yOffset = mouseY - letter.yPos;
  }
}

/**
Ensures that all letters in a letter's sameChar list cluster around
the lead letter.
**/
void mouseDragged() {
  for (Letter letter : letters) {
    
    if (letter.locked) {
      letter.xPos = mouseX - letter.xOffset;
      letter.yPos = mouseY - letter.yOffset;

      for (Letter sameChar : letter.sameChars) {
        sameChar.xPos = mouseX - sameChar.xOffset;
        sameChar.yPos = mouseY - sameChar.yOffset;
      }
    }
  }
}


/**
When a key is pressed with an ASCII code between 33 and 133, 
a Letter object is created, along with four other similar ones.
These 5 objects are grouped and referred to as 'similar', and added
to eachother's 'sameChars' list. All Letters that are similar will cluster
together when one of them is clicked on by the user. 
**/
void keyPressed() {
  
  //If a user clicks space bar, letters are cleared
  if (key == ' ') {
    letters.clear();
  }
  
  if (int(key) >= 33 && int(key) <= 133) {
    
    //temp array for assigning sameChars
    Letter[] temp = new Letter[5];
    
    //adding to temp
    for (int i = 0; i < 5; i++) {
      Letter let = new Letter(key);
      temp[i] = let;
    }
    
    //create sameChar lists
    for (Letter l : temp) {
      for (Letter t : temp) {
        if ((l != t)) {
          l.sameChars.add(t);
        }
      }
    }
    
    //add each to bigger list
    for (Letter let : temp) {
      letters.add(let);
    }
  }
}
