

float R;
float L;
float Px, Py;
float Ox, Oy;
float Mx, My;
float Cx1, Cy1;
float Cx2, Cy2;
float Nx, Ny;
float Tx, Ty;
float Sx, Sy;
float Qx, Qy;
float Ux, Uy;
boolean cross_fg;

class Vector2 {
 float x;
 float y;
  Vector2(float _x, float _y)
  {
    x = _x;
    y = _y;
  }
  void orthorize()
  {
    float d = x * x + y * y;
    float s = sqrt(d);
    if(s > 0)
    {
      x = x / s;
      y = y / s;
    }
    else//?
    {
      x = 1;
      y = 0;
    }
  }
};

void setup()
{
  size(500, 500);
  colorMode(HSB);
  noFill();
  stroke(0);
  
  Ox = 200;
  Oy = 200;
  R = 100;
  L = 100;
  Px = 300;
  Py = 400;
  
  cross_fg = false;
}

void draw()
{
  background(255);
  ellipse(Ox, Oy, 2 * R, 2 * R);
  ellipse(Px, Py, 3, 3);
  Mx = mouseX;
  My = mouseY;
  ellipse(Mx, My, 3, 3);
  calCross();
  if(cross_fg == true)
  {
    ellipse(Cx1, Cy1, 2, 2);
    ellipse(Cx2, Cy2, 4, 4);
    stroke(0);
    line(Px, Py, Mx, My);
    calReflect();
    ellipse(Qx, Qy, 4, 4);
    line(Cx1, Cy1, Qx, Qy);
    stroke(100);
    ellipse(Ux, Uy, 4, 4);
    line(Cx1, Cy1, Ux, Uy);
  }
   else
   {
    stroke(100);
    line(Px, Py, Mx, My);
   }
}

void calReflect()
{
  Nx = Cx1 - Ox;
  Ny = Cy1 - Oy;
  Vector2 Nv = new Vector2(Nx, Ny);
  Nv.orthorize();
  Ux = Cx1 + Nv.x * L;
  Uy = Cy1 + Nv.y * L;
  Sx = Px - Cx1;
  Sy = Py - Cy1;
  Vector2 Sv = new Vector2(Sx, Sy);
  Sv.orthorize();
  float sn = Sv.x * Nv.x + Sv.y * Nv.y;
  Tx = -Sv.x + 2 * sn * Nv.x;
  Ty = -Sv.y + 2 * sn * Nv.y;
  Vector2 Tv = new Vector2(Tx, Ty);
  Tv.orthorize();
  Qx = Cx1 + Tv.x * L;
  Qy = Cy1 + Tv.y * L; 
}

void calCross()
{
  if(Mx == Px)
  {
    Cx1 = Mx;
    Cx2 = Mx;
    float d = R * R - (Mx - Ox) * (Mx - Ox);
    if(d >= 0)
    {
      float s = sqrt(d);
      float v0 = s + Oy;
      float v1 = -s + Oy;
      float s0 = calDistance(Px, Py, Mx, v0);
      float s1 = calDistance(Px, Py, Mx, v1);
      if(s0 < s1)
      {
        Cy1 = s0;
        Cy2 = s1;
      }
      else
      {
        Cy1 = s1;
        Cy2 = s0;
      }
      cross_fg = true;
    }
    else
      cross_fg = false;
  }
  else
  {
    float A, B;
    if(Px == 0)
    {
      B = My;
      A = (My - Py) / Mx;
    }
    else
    {
      B = (My - Mx * Py / Px) / (1 - Mx / Px);
      A = (Py - B) / Px;
    }
    float C = 1 + A * A;
    float D = 2 * (A * B - Ox - A * Oy);
    float E = Ox * Ox - 2 * B * Oy + Oy * Oy + B * B - R * R;
    float d = D * D - 4 * C * E;
    if(d >= 0.0)
    {
      float s = sqrt(d);
      float x0 = (-D + s) / (2 * C);
      float x1 = (-D - s) / (2 * C);
      float y0 = A * x0 + B;
      float y1 = A * x1 + B;
      float s0 = calDistance(Px, Py, x0, y0);
      float s1 = calDistance(Px, Py, x1, y1);
      if(s0 < s1)
      {
        Cx1 = x0;
        Cy1 = y0;
        Cx2 = x1;
        Cy2 = y1;
      }
      else
      {
        Cx1 = x1;
        Cy1 = y1;
        Cx2 = x0;
        Cy2 = y0;
      }
      cross_fg = true;
    }
    else
      cross_fg = false;
  }
}

float calDistance(float x0, float y0, float x1, float y1)
{
  float d = (x0 - x1) * (x0 - x1) + (y0 - y1) * (y0 - y1);
  float s = sqrt(d);
  return s;
}  
