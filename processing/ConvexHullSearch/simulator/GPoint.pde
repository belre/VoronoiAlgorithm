

class GPoint {
 public String _label;
 public double _px;
 public double _py;
 
 public GPoint(String label)
 {}
 
 public GPoint(String label, double px, double py) {
  this._label = label;
  this._px = px;
  this._py = py;
 }
 
 
 public double distanceSq (GPoint counterpart ) {
  double dx = this._px - counterpart._px;
  double dy = this._py - counterpart._py;
   
  return Math.sqrt(dx * dx + dy * dy); 
 }
}
