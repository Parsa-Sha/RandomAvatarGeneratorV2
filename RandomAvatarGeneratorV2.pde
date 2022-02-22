// Random Avatar Generator V2
// Imports any number of images, and randomizes which appear based on file name. First version was flawed
// 02/21/2022
// https://github.com/Parsa-Sha/RandomAvatarGeneratorV2

import java.io.File;

File dir = new File(sketchPath()); // Creating directory of the current program to access the folder, then creating file array and file length 
File [] files = dir.listFiles();
int numberOfFiles = files.length;

int alphabetCount[] = new int[26]; // Number of files starting with every letter
boolean alphabetCountExists[] = new boolean[26]; // Checking if previous array elements are not null
int headCount = 0; // Number of times a photo has been saved
String currentFile; // These five are used for updating alphabetCount[]
char currentFileChar;
char pastFileChar;
int numberOfCurrentLetterFiles = 0;
int indexOfCurrentLetterArray = 0;

void setup() {
  size(600, 850);
  background(128);
  textSize(25);
  stroke(255);
  textAlign(CENTER);
  text("Press 'R' to generate random image, 'S' to save", width/2, height/2);
  
  dir = new File(sketchPath() + "\\input"); // Updating path, array, and length
  File files[] = dir.listFiles();
  numberOfFiles = files.length;
  
  numberOfCurrentLetterFiles = 0;
  pastFileChar = 'a';
  
  for(int i = 0; i < alphabetCountExists.length; i++) alphabetCountExists[i] = false; // Make sure all are currently false
  for (int i = 0; i < numberOfFiles; i++){  // For each file, check if the first letter is the same as the last
    currentFile = files[i].getName();
    currentFileChar = currentFile.charAt(0);
    if (pastFileChar != currentFileChar || i == numberOfFiles-1) { // Including failsafe for the last one because of some errors
      if(i == numberOfFiles-1) alphabetCount[indexOfCurrentLetterArray] = numberOfCurrentLetterFiles + 1; // More failsafe
      else alphabetCount[indexOfCurrentLetterArray] = numberOfCurrentLetterFiles;
      alphabetCountExists[indexOfCurrentLetterArray] = true; // Array of booleans for random pattern
      indexOfCurrentLetterArray++;
      numberOfCurrentLetterFiles = 1;
    } else {
      numberOfCurrentLetterFiles++; 
    }
    pastFileChar = currentFileChar; // Setting current letter to past letter
  }
}

void draw() {}

void keyPressed() { // Randomizing function, for each letter group, randomize a number and use the image of the file with that letter and number
  if(key=='r'||key=='R'){
    background(128);
    for(int i = 0; i < alphabetCount.length; i++) {    
      if (alphabetCountExists[i] == true){
        int randomSelector = floor(random(alphabetCount[i]));
        int currentCharCode = 97+i;
        char alphabetChar = char(currentCharCode);
        PImage aImage = loadImage("input\\" + alphabetChar + nf((randomSelector + 1), 3) + ".png");
        image(aImage, 0, 0);
      }
    }
  }
  
  if(key=='s'||key=='S') { // Saving function
    saveFrame("output\\composite" + nf(headCount, 6) + ".png");
    headCount++;
    rectMode(CENTER);
    fill(0);
    rect(width/2, height/2, 250, 100);
    fill(255);
    text("Image Saved.", width/2, height/2 + 10);
  }
}
