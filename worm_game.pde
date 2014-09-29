int WIDTH = 400;
int HEIGHT = 400;
int speed;
int xspeed;
int yspeed;
int xpellet= (int) random(WIDTH/10)*10;
int ypellet= (int) random(HEIGHT/10)*10;
boolean paused= false;
int x[]=new int[100];  // x coordinates of trial
int y[]=new int[100];  // y coordinates of trail
int scorecount;
boolean gameover=false;
boolean restart=false;
int snakesize;
boolean begin= true;

void setup() {
  size(WIDTH, HEIGHT);
  x[0]=WIDTH/2;
  y[0]=HEIGHT/2;
  speed =10;
  xspeed = speed;
  yspeed = 0;
  frameRate(15);
  snakesize=1;
  scorecount=0;
}

void draw()
{
  background(0);
  smooth(0);
  PFont a =createFont("Arial", 20);
  PFont f = createFont("Arial", 48);
  textFont(f);




  if (x[snakesize-1] == xpellet && y[snakesize-1] == ypellet)
  {
    xpellet= (int) random(WIDTH/10)*10;
    ypellet= (int) random(HEIGHT/10)*10;
    scorecount+=5;
    snakesize++;
    x[snakesize-1]=x[snakesize-2];
    y[snakesize-1]=y[snakesize-2];
  }


  if (begin) {
    PFont b = createFont("Arial", 48);
    textFont(b);
    textAlign(CENTER);
    textSize(50);
    fill(random(255), random(255), random(255));
    text("Snake", width/2, height/5);
    fill(0, 0, 255);
    textSize(30);
    text("Instructions:", width/2, 125); 
    textSize(20);
    fill(255);
    text("-Press Enter To Start", width/2, 150);
    text("-To Pause Press P", width/2, 175);
    text("-Arrowkeys Move Snake", width/2, 200);
    textSize(30);
    fill(255, 0, 0);
    text("Game Over If:", width/2, 275);
    textSize(20);
    fill(255);
    text("-Walls Are Hit", width/2, 300);
    text("-The Tail Of The Snake Is Touched", width/2, 325);
    text("-Backwards Movement", width/2, 350);
  } 

  else if (gameover) {

    stroke(0, 0, 255);
    fill(125);
    rect(0, 375, width, 25);
    textFont(f);
    fill(255, 0, 0);
    text("Game Over", 80, 200);
    textAlign(LEFT);
    textSize(20);
    fill(0, 0, 255);
    text("Score:"+scorecount, 10, 395);
    stroke(0, 0, 255);
    fill(200);
    rect(300, 380, 90, 15);
    fill(0);
    textSize(14);
    text("Start Over", 313, 393);
  }
  else if (paused) {
    textAlign(CENTER);
    textSize(25);
    text("Paused Press P to Unpause", width/2, 200);
  }
  else 
  {
    stroke(0, 0, 255);
    fill(125);
    rect(0, 375, width, 25);
    //pellet
    noStroke();
    fill(0, 0, 255);
    ellipse(xpellet, ypellet, 10, 10);

    textFont(a);
    textAlign(LEFT);
    text("Score:"+scorecount, 10, 395);




    //worm
    //fill(255,0,0);
    //ellipse(xloc,yloc,10,10);

    //movement of snake
    x[snakesize-1]+=xspeed;
    y[snakesize-1]+=yspeed;

    //constrain the pellet within gamescreen
    ypellet= constrain(ypellet, 0, 370);

    for (int i=0; i<snakesize; i++) {

      if (i>0) {
        x[i-1]=x[i];
        y[i-1]=y[i];
      }
      noStroke();

      fill(255, 0, 0);    
      ellipse(x[i], y[i], 10, 10);



      for (int j=0; j<snakesize-2; j++) {
        if (x[snakesize-1]==x[j] && y[snakesize-1]==y[j]) {
          gameover=!gameover;
        }
      }
    }

    //boundries
    if ((x[snakesize-1]>width) || (x[snakesize-1]<0))
    { 
      gameover=!gameover;
    }
    else if ((y[snakesize-1]>375) || (y[snakesize-1]<0))
    { 
      gameover=!gameover;
    }
  }
}

void keyPressed() {

  if (keyCode==UP) {
    xspeed=0;
    yspeed=-speed;
  }
  else if (keyCode==DOWN) {
    xspeed=0;
    yspeed=speed;
  }
  else if (keyCode==LEFT) {
    xspeed=-speed;
    yspeed=0;
  }
  else if (keyCode==RIGHT) {
    xspeed=speed;
    yspeed=0;
  }
  else if (key=='p') {
    paused=!paused;
  }
  else if ( keyCode==ENTER) {
    begin=!begin;
  }
}

void mousePressed() {
  if (mouseX<390 && mouseX>300 && mouseY<395 && mouseY>380 && mouseButton==LEFT && gameover==true) {
    restart();
  }
}

void restart() {
  background(0);
  begin=!begin;
  gameover=!gameover;
  size(WIDTH, HEIGHT);
  x[0]=WIDTH/2;
  y[0]=HEIGHT/2;
  speed =10;
  xspeed = speed;
  yspeed = 0;
  frameRate(15);
  snakesize=1;
  scorecount=0;
}

