
final float PARAM_GRAVITY = 2000;


class CWall
{
 static final float PARAM_a = 20;
 static final float PARAM_b = 17;
 
  
 float x;
 float y;
 float w;
 float h;
 float t;
 float step;
  
 CWall(float _x, float _y, float _w, float _h, float _step)
 {
  x = _x;
  y = _y;
  w = _w;
  h = _h;
  step = _step;
  t = 0;
 }
 
 // y only
 void CalcNext()
 {
   y = y + PARAM_a * PARAM_b * step * cos(PARAM_b * t) ;
   t += step;
 }  
}

class CBall
{
 float x;
 float y;
 float vy0;
 float r;
 float t;
 float step;
 CBall(float _x, float _y, float _r, float _step)
 {
  x = _x;
  y = _y;
  r = _r;
  vy0 = 0;
  t = 0;
  step = _step;
 }
 
 boolean isCollision(CWall wall, float ynext)
 {   
   if(ynext - r <= (wall.y + wall.h / 2))
   {
    return true; 
   }
   else
   {
    return false; 
   }
 }
 
 void Bounce(CWall wall)
 {
  vy0 = -vy0 + 4 * CWall.PARAM_a * CWall.PARAM_b * cos(CWall.PARAM_b * wall.t) ;
 }
 
 void CalcNext(CWall wall)
 {  
  float ynext = y + (-PARAM_GRAVITY * t + vy0) * step;
  if( isCollision(wall, ynext) )
  {
   Bounce(wall); 
   t = 0;
  }
  else
  {
    y = y + (-PARAM_GRAVITY * t + vy0) * step;
    t += step;
  }
 }
}

CWall wallobj;
CBall ball1obj;
CBall ball2obj;
CBall ball3obj;
CBall ball4obj;
CBall ball5obj;
final int wndwid = 700;
final int wndhei = 700;
final float compenratio = 0.3;

float ConvAxisX( float x, float w, float wndw)
{
 return (x - w / 2);
}

float ConvAxisY( float y, float h, float wndh)
{
 return (wndh - compenratio*(y +h / 2));
  
}

void setup()
{
 size(700, 700);
 
 colorMode(RGB, 100);
 wallobj = new CWall(350, CWall.PARAM_a + (50 / 2), 700, 50, 0.008);
 ball1obj = new CBall(100, 300, 10, 0.008);
 ball2obj = new CBall(200, 600, 10, 0.008);
 ball3obj = new CBall(300, 900, 10, 0.008);
 ball4obj = new CBall(400, 1200, 10, 0.008);
 ball5obj = new CBall(500, 1500, 10, 0.008);
}

void draw()
{
  
 fill(255,255,255);
 background(255, 255, 255);
 
 
 fill(40,40,40);
 stroke(0,0,0);
 rect(ConvAxisX(wallobj.x,wallobj.w, this.width), ConvAxisY(wallobj.y, wallobj.h, this.height),wallobj.w, wallobj.h);

 fill(0,128,0);
 ellipse(ConvAxisX(ball1obj.x, ball1obj.r, this.width), ConvAxisY(ball1obj.y, ball1obj.r, this.height), ball1obj.r, ball1obj.r);

 fill(0,128,128);
 ellipse(ConvAxisX(ball2obj.x, ball2obj.r, this.width), ConvAxisY(ball2obj.y, ball2obj.r, this.height), ball2obj.r, ball2obj.r);

 fill(128,128,255);
 ellipse(ConvAxisX(ball3obj.x, ball3obj.r, this.width), ConvAxisY(ball3obj.y, ball3obj.r, this.height), ball3obj.r, ball3obj.r);

 fill(128,0,128);
 ellipse(ConvAxisX(ball4obj.x, ball4obj.r, this.width), ConvAxisY(ball4obj.y, ball4obj.r, this.height), ball4obj.r, ball4obj.r);
 
 fill(0,0,255);
 ellipse(ConvAxisX(ball5obj.x, ball5obj.r, this.width), ConvAxisY(ball5obj.y, ball5obj.r, this.height), ball5obj.r, ball5obj.r);



 stroke(255,0,0);
 text( (int)(0.5 +300 / (1000*compenratio)) + "m", ConvAxisX(0, 0, this.width),ConvAxisY(300, 0, this.height));
 line(ConvAxisX(0, 0, this.width), ConvAxisY(300, 0, this.height), ConvAxisX(700 , 0, this.width), ConvAxisY(300, 0, this.height));
 
  text( (int)(0.5 +600 / (1000*compenratio)) + "m", ConvAxisX(0, 0, this.width),ConvAxisY(600, 0, this.height));
 line(ConvAxisX(0, 0, this.width), ConvAxisY(600, 0, this.height), ConvAxisX(700 , 0, this.width), ConvAxisY(600, 0, this.height));

  text( (int)(0.5 +900 / (1000*compenratio)) + "m", ConvAxisX(0, 0, this.width),ConvAxisY(900, 0, this.height));
 line(ConvAxisX(0, 0, this.width), ConvAxisY(900, 0, this.height), ConvAxisX(700 , 0, this.width), ConvAxisY(900, 0, this.height));
 
  text( (int)(0.5 +1200 / (1000*compenratio)) + "m", ConvAxisX(0, 0, this.width),ConvAxisY(1200, 0, this.height));
 line(ConvAxisX(0, 0, this.width), ConvAxisY(1200, 0, this.height), ConvAxisX(700 , 0, this.width), ConvAxisY(1200, 0, this.height));
 
  text( (int)(0.5 +1500 / (1000*compenratio)) + "m", ConvAxisX(0, 0, this.width),ConvAxisY(1500, 0, this.height));
 line(ConvAxisX(0, 0, this.width), ConvAxisY(1500, 0, this.height), ConvAxisX(700, 0, this.width), ConvAxisY(1500, 0, this.height));
 
  text( (int)(0.5 +1800 / (1000*compenratio)) + "m", ConvAxisX(0, 0, this.width),ConvAxisY(1800, 0, this.height));
 line(ConvAxisX(0, 0, this.width), ConvAxisY(1800, 0, this.height), ConvAxisX(700 , 0, this.width), ConvAxisY(1800, 0, this.height));
 
  text( (int)(0.5 +2100 / (1000*compenratio)) + "m", ConvAxisX(0, 0, this.width),ConvAxisY(2100, 0, this.height));
 line(ConvAxisX(0, 0, this.width), ConvAxisY(2100, 0, this.height), ConvAxisX(700, 0, this.width), ConvAxisY(2100, 0, this.height));

 text( "Time=:" + wallobj.t + "[s]", 0, 50);
 
 wallobj.CalcNext();
 ball1obj.CalcNext(wallobj);
 ball2obj.CalcNext(wallobj);
 ball3obj.CalcNext(wallobj);
 ball4obj.CalcNext(wallobj);
 ball5obj.CalcNext(wallobj);
}
