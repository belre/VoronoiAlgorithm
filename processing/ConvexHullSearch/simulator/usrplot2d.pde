import java.util.Arrays;
import java.util.List;


class MyGPoint {
 public String _label;
 public boolean _isactive;
 public float _px;
 public float _py;
 
 public MyGPoint(String label) {
  this(label, 0, 0, false);
 }
 
 public MyGPoint(String label, float px, float py, boolean isactive) {
   this._label = label;
   this._isactive = isactive;
   this._px = px;
   this._py = py;
 }
}

class MyGLine {
 public String _label;
 public boolean _isactive;
 public float _bx;
 public float _by;
 public float _ex;
 public float _ey;
 
 public MyGLine(String label) {
  this(label, 0, 0, 0, 0, false);
 }
 
 public MyGLine(String label, float bx, float by, float ex, float ey, boolean isactive) {
  this._label = label;
  this._bx = bx;
  this._by = by;
  this._ex = ex;
  this._ey = ey;
  this._isactive = isactive;
 }
 
 public MyGLine(GPoint p1, GPoint p2, boolean isactive) {
  this._label = p1._label + " - " + p2._label ;
  this._bx = (float)p1._px;
  this._by = (float)p1._py;
  this._ex = (float)p2._px;
  this._ey = (float)p2._py;
  this._isactive = isactive;
 }
  
}


class MyGraphComposition {
 private List<MyGPoint> _points;
 private List<MyGLine> _lines;
  
 public MyGraphComposition() {  
  _points = new ArrayList<MyGPoint>();
  _lines = new ArrayList<MyGLine>();
 }  
 
 public boolean RegisterPoints(MyGPoint[] points, int minX, int minY, int maxX, int maxY) {
  List<MyGPoint> _tmppoints = new ArrayList<MyGPoint>();
  for( MyGPoint obj: points){
   if( obj._px > minX && obj._py > minY && obj._px < maxX && obj._py < maxY && obj._isactive) {
    _tmppoints.add(obj);
   } 
  }
  
  return _points.addAll(_tmppoints);
 }
 
 public boolean RegisterLines(MyGLine[] lines, int minX, int minY, int maxX, int maxY) {
  List<MyGLine> _tmplines = new ArrayList<MyGLine>();

  for( MyGLine obj: lines){
   if( obj._isactive ) {
    // range out is not implemented
    if( obj._bx > minX && obj._by > minY && obj._bx < maxX && obj._by < maxY &&
        obj._ex > minX && obj._ey > minY && obj._ex < maxX && obj._ey < maxY ) {
     _tmplines.add(obj);
    } 
   }
  }
   
  return _lines.addAll(_tmplines );
 }

 
 public MyGPoint[] GetPoints() {
  MyGPoint[] obj = new MyGPoint[_points.size()];
  obj = _points.toArray(obj);
  return obj; 
 }
 
 public MyGLine[] GetLines() {
  MyGLine[] obj = new MyGLine[_lines.size()];
  obj = _lines.toArray(obj);
  return obj;
 }
 
 public GPoint[] ConvertGPoint() {
  MyGPoint[] tobj = GetPoints();
  
  // Obtain active points
  List<GPoint> cobj = new ArrayList<GPoint>();
  for( MyGPoint tobj0 : tobj ) {
   if( tobj0._isactive ) {
    GPoint tmp = new GPoint(tobj0._label, tobj0._px, tobj0._py);
    cobj.add(tmp);
   }
  }
   
  // conversion
  GPoint[] cobjarr = new GPoint[cobj.size()];
  cobjarr = cobj.toArray(cobjarr);
  return cobjarr;
 }
 
 public boolean Clear() {
  _points.clear();
  _lines.clear();
   
  return true;
 }
}

class MyPlot2dArea
{
  public int minX = -300;
  public int minY = -2000;
  public int maxX = 300;
  public int maxY = 2000;
  
  MyGraphComposition _recentdata;
  
  public MyPlot2dArea()
  { 
  }
  
  public MyGraphComposition LoadTableFile(String filepath)
  {
   MyGraphComposition obj = new MyGraphComposition(); 
   ArrayList<MyGPoint> pobj = new ArrayList<MyGPoint>();

   if(_recentdata != null ) {
     _recentdata.Clear();
   }

   // Get Lines
   String[] lines = loadStrings(filepath);
  
   // Parse Csv
   for( String line : lines ) {
    String[] elem = split(line, ",");
    float px = parseFloat(elem[1].toString());
    float py = parseFloat(elem[2].toString());
    MyGPoint tmp = new MyGPoint(elem[0], px, py, true);
    pobj.add(tmp);
   }
  
   // register
   MyGPoint[] pobj_array = new MyGPoint[pobj.size()];
   pobj_array = pobj.toArray(pobj_array);
   obj.RegisterPoints(pobj_array, minX, minY, maxX, maxY);
   
   _recentdata = obj;
   
   return obj;
  }
  
  public boolean ConvexHullSearch(){
   // Convert MyGPoints[] to GPoints[]
   GPoint[] points = _recentdata.ConvertGPoint();
   
   ConvexHullSearchSample algo = new ConvexHullSearchSample();
   int millisstart = millis();
   algo.allocateGPoint(points);   
   algo.execute();
   int millisend = millis();
   algo.printConvexHull();
   println("Proc time : " + (millisend - millisstart) + "[ms]");
   
   GPoint[] convex = algo.GetResultOfConvexHull();
   MyGLine[] lines = new MyGLine[convex.length];
   for(int i = 0; i < convex.length ; i ++ ) {
    int nextpnt = i+1;
    if( i == convex.length - 1) {
      nextpnt = 0;
    }

    lines[i] = new MyGLine( convex[i], convex[nextpnt], true);
   }
   
   _recentdata.RegisterLines(lines, minX, minY, maxX, maxY);

   return true; 
  }
  
  public MyGraphComposition GetComposition () {
   return _recentdata; 
  }
  
  public MyGraphComposition GetCompositionSample()
  {
    MyGraphComposition obj = new MyGraphComposition();

    MyGPoint[] pnts = new MyGPoint[]
     {
       new MyGPoint("1a", -250, -250, true),
       new MyGPoint("1b", -150, -250, true),
       new MyGPoint("1c", -50, -250, true),
       new MyGPoint("1d",  50, -250, true),
       new MyGPoint("1e",  150, -250, true),
       new MyGPoint("1f",  250, -250, true),
       new MyGPoint("2a", -250, -150, true),
       new MyGPoint("2b", -150, -150, false),
       new MyGPoint("2c", -50, -150, true),
       new MyGPoint("2d",  50, -150, true),
       new MyGPoint("2e",  150, -150, true),
       new MyGPoint("2f",  250, -150, true),
       new MyGPoint("3a", -250, -50, true),
       new MyGPoint("3b", -150, -50, true),
       new MyGPoint("3c", -50, -50, true),
       new MyGPoint("3d",  50, -50, true),
       new MyGPoint("3e",  150, -50, true),
       new MyGPoint("3f",  250, -50, true),
       new MyGPoint("4a", -250,  50, true),
       new MyGPoint("4b", -150,  50, true),
       new MyGPoint("4c", -50,  50, true),
       new MyGPoint("4d",  50,  50, true),
       new MyGPoint("4e",  150,  50, true),
       new MyGPoint("4f",  250,  50, true),
       new MyGPoint("5a", -250,  150, true),
       new MyGPoint("5b", -150,  150, true),
       new MyGPoint("5c", -50,  150, true),
       new MyGPoint("5d",  50,  150, true),
       new MyGPoint("5e",  150,  150, true),
       new MyGPoint("5f",  250,  150, true),
       new MyGPoint("6a", -250,  250, true),
       new MyGPoint("6b", -150,  250, true),
       new MyGPoint("6c", -50,  250, true),
       new MyGPoint("6d",  50,  250, true),
       new MyGPoint("6e",  150,  250, true),
       new MyGPoint("6f",  250,  250, true),
     };
    
    obj.RegisterPoints(pnts, minX, minY, maxX, maxY);
    
    return obj;
  }
}
