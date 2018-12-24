// Practice

float X;
float Y;
float Speed;
float YMove;

void setup()
{
 size(300,300);
 colorMode(RGB, 100);
 background(100);
 rectMode(CENTER);
 frameRate(30);
 X = 0;
 Y = 0;
 Speed = 3;
 YMove = 20;
}

void draw()
{
 background(100);
 X = X + Speed;
 if ( X >= width ) 
 {
   X = 0;
   Y += YMove;
 }
 fill(0);
 rect(X, Y, 10, 10);
}
  
}
