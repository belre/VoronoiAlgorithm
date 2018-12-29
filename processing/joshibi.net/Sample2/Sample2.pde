float X;
float Y;
float R;
int Count;

int st_col1, st_col2, st_col3;


void setup()
{
 size(300, 300);
 colorMode(RGB, 100);
 frameRate(30);
 Count = 0;
 X = 150;
 Y = 150;
 R = 50;
}

int MAX_COUNTER = 50;

void draw()
{
 background(0);
 int col1, col2, col3;
 
 if ( Count >= MAX_COUNTER / 2)       // if the intensity exceeds maximum, become dark
 {
  col1 = st_col1 - st_col1 * Count / MAX_COUNTER;
  col2 = st_col2 - st_col2 * Count / MAX_COUNTER;
  col3 = st_col3 - st_col3 * Count / MAX_COUNTER;
 }
 else
 {
  col1 = st_col1 * Count / MAX_COUNTER;
  col2 = st_col2 * Count / MAX_COUNTER;
  col3 = st_col3 * Count / MAX_COUNTER;
 }
 
 noFill();
 
 strokeWeight(4);
 stroke(col1, col2, col3);
 ellipse(X,Y,R,R);
 
 if ( Count >= MAX_COUNTER ) 
 {
  Count = 0;
  X = random(width);
  Y = random(height);
  R = random(width)/2;

   int rand = (int)random(3);
  st_col1 = 0;
  st_col2 = 0;
  st_col3 = 0;
  
  if(rand == 0)
   st_col1 = 200;
  else if (rand == 1)
   st_col2 = 200;
  else if (rand == 2)
   st_col3 = 200;

 }
 Count++;
 
  
}
