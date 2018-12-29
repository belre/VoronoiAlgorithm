
class KeyState {
 Boolean _ispressed = false;
 Boolean _issustain = false;
 
 public KeyState(boolean issustain)
 {
  this._ispressed = false;
  this._issustain = issustain;
 }
}





// https://qiita.com/leqfre/items/fd67704045fe9a02dd1f
class UsrKeyMapper {
 HashMap<Integer, KeyState> _keycodemap;
 final int _KEYCODE_COMMAND = 157;

 public UsrKeyMapper()
 {}

 void initialize() {
  _keycodemap = new HashMap<Integer, KeyState>();
  _keycodemap.put(_KEYCODE_COMMAND, new KeyState(false));
  _keycodemap.put((int)'Z', new KeyState(false));
  _keycodemap.put((int)'z', new KeyState(false));
  _keycodemap.put((int)ENTER, new KeyState(true));
 }

 // puts new state after input
 void putState(int code, boolean state) {
   if( _keycodemap.containsKey(code)){
    KeyState obj = _keycodemap.get(code);
    
    boolean isnewpressed = obj._ispressed;
    
    // sustain mode
    if( state && obj._issustain )
    {
     isnewpressed = !obj._ispressed;
    }
    // normal press
    else if( !obj._issustain )
    {
     isnewpressed = state;
    }
     
    _keycodemap.get(code)._ispressed = isnewpressed;
   }
 }
 
 // get current keystate
 boolean getState(int code) {
   return _keycodemap.get(code)._ispressed;
 }
}
  
  
  
