

class GVector2d {
 public String _label;
 public double _dx;
 public double _dy;
 
 public GVector2d(String label) {
  this._label = label;
 }
 
 public GVector2d(GPoint point) {
  this._label = point._label;
  this._dx = point._px;
  this._dy = point._py;
 }
 
 public GVector2d(String label, double dx, double dy)  {
  if(label == null ) {
   this._label = "unknown";  
  }
  this._label = label;
  this._dx = dx;
  this._dy = dy;
 }
 
 public void normalized() {
  double len = this.getLength();
  this._dx = this._dx / len;
  this._dy = this._dy / len;   
 }

 public int getOrthant() {
  if( this._dx > 0 && this._dy >= 0) return 1;
  if( this._dx <= 0 && this._dy > 0) return 2;
  if( this._dx < 0 && this._dy <= 0) return 3;
  if( this._dx >= 0 && this._dy < 0) return 4;
  else return 0;
 }
 
 public GVector2d multiply(double k_coef) {
  GVector2d vec = new GVector2d(this._label + "(k_coef = " + k_coef + ")");
  vec._dx = k_coef * (this._dx);
  vec._dy = k_coef * (this._dy);
  return vec;
 }

 
 public double getLength() {
  return Math.sqrt(this._dx * this._dx + this._dy * this._dy); 
 }
 
 public GVector2d subtract(GVector2d obj, double k_coef)
 {
   String multiplylabel = "";
   if(k_coef != 1) {
     multiplylabel = "(k_coef = " + k_coef + ")";
   }
   
   GVector2d vec = new GVector2d(this._label + " sub " + obj._label + multiplylabel);
   if( this._label == null)    vec._label = "null(label)";
   if( obj._label == null)     vec._label += "null(obj)";
   
   vec._dx = k_coef * (this._dx - obj._dx);
   vec._dy = k_coef * (this._dy - obj._dy);
   return vec;
 }
}
