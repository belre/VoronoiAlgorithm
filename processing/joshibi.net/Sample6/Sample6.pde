int DX;
int DY;
int LX;
int LY;

void setup()
{
 size(300, 300);
 colorMode(RGB, 100);
 rectMode(CORNERS);
 
 // Division Number of tiles
 DX = 3;
 DY = 3;
 LX = width / DX;
 LY = height / DY;
}

void draw()
{
 background(0);
 int x0, y0, x1, y1;
 stroke(0);
 
 for( int i = 0; i < DX; i ++ )
 {
  x0 = i * LX;
  x1 = (i + 1) * LX;
  for ( int j = 0; j < DY; j ++ )
  {
   y0 = j * LY;
   y1 = (j + 1) * LY;
   drawRect(x0, y0, x1, y1);
  }
 }
}


void drawRect(int x0, int y0, int x1, int y1)
{
  if( mouseX >= x0 && mouseX < x1 && mouseY >= y0 && mouseY < y1)
   fill(50);
  else
   fill(100);
   rect(x0, y0, x1, y1);
  
}
