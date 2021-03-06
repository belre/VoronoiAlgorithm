

//import java.awt.*;
//import javax.swing.*;



// MenuBar
//JLayeredPane pane = new JLayeredPane();
//JMenuBar menubar = new JMenuBar();


// KeyMapper
UsrKeyMapper __mykeymapper = new UsrKeyMapper();

// PlotArea
MyPlot2dArea plotobj = new MyPlot2dArea();
MyGPoint[] pointsobj = null;
MyGLine[] linesobj = null;
boolean isplabel = false;
boolean iscordpoints = false;

String _disptext = "";

void setup()
{
 size(620,720);
 colorMode(RGB, 255);
 

 __mykeymapper.initialize();
 pointsobj = plotobj.LoadTableFile("data/test.txt").GetPoints(); 
 
 
 pointsobj = plotobj.GetComposition().GetPoints();
 linesobj = plotobj.GetComposition().GetLines();
 
 frameRate(1);      
}

void draw() {
 fill(0, 0, 0);
 background( 50, 180, 250);

 fill(255,255,255);
 
 // graph area
 rect(8, 2, 600, 600);
 
 fill(0,0,0);
 // axis
 int cenx = 8 + 600 / 2;
 int ceny = 2 + 600 / 2;
 line(cenx, ceny, cenx + 300, ceny);
 line(cenx, ceny, cenx - 300, ceny);
 line(cenx, ceny, cenx, ceny + 300);
 line(cenx, ceny, cenx, ceny - 300);
 textSize(14);
 text("+X", cenx + 280, ceny);
 text("-X", cenx - 300, ceny);
 text("+Y", cenx + 0, ceny - 290);
 text("-Y", cenx + 0, ceny + 300); 

 
 // graph plot
 textSize(9);
 for( MyGPoint pnt: pointsobj){
  ellipse( cenx + pnt._px, ceny - pnt._py, 5.0, 5.0);

  if( isplabel ) {
   text( pnt._label, cenx + pnt._px + 5, ceny - pnt._py );
  }
  if( iscordpoints) {
   text( "(" + pnt._px + " ," + pnt._py + ")", cenx + pnt._px - 30, ceny - pnt._py + 14 ); 
  }
 }
 
 for (MyGLine ln: linesobj ) {
  line( cenx + ln._bx, ceny - ln._by, cenx + ln._ex, ceny - ln._ey);
 }

 // status
 fill(255,255,190);
 rect(8, 604, 600, 90);


 if ( __mykeymapper.getState(ENTER) ) {
  textSize(14);
  fill(0,0,0);
  rect(8, 698, 600, 20);
  fill( 255, 100, 160);
  text( "> " + _disptext, 15, 713);
 }
}


boolean isAvailableForDebugKey(int keycode)
{
 return (keycode >= 'a' && keycode <= 'z' || keycode >= 'A' && keycode <= 'Z' || keycode == '/' || keycode == ' ' || keycode == '.' || keycode == '_' || (keycode >= '0' && keycode <= '9')); 
}

void keyPressed()
{
 if ( __mykeymapper.getState(ENTER) )
 {
   _disptext = isAvailableForDebugKey(keyCode) ? (_disptext + key) : _disptext;
   frameRate(60);
 }
 else
 {
  _disptext = "";
  frameRate(10);
 }

 __mykeymapper.putState(keyCode, true);
}

void keyReleased() 
{
 __mykeymapper.putState(keyCode, false);

 if (keyCode == BACKSPACE && _disptext.length() != 0) {
  _disptext = _disptext.substring(0, _disptext.length()-1);
 }
 
 if( keyCode == DELETE ) {
  _disptext = ""; 
 }
 if( keyCode == ENTER) {
  String[] obj = split(_disptext, " ");
  
  // write procedures after debug typing
  if(obj.length >= 2) {
    if(obj[0].equals("plabel")) {
     if( obj[1].equals("on")) {
      isplabel = true;
     }
     else if(obj[1].equals("off")) {
      isplabel = false;
     }
    }
    if(obj[0].equals("clabel")) {
     if( obj[1].equals("on")) {
      iscordpoints = true;
     }
     else if(obj[1].equals("off")) {
      iscordpoints = false;
     }
    }
    if(obj[0].equals("readcsv")){
     pointsobj = plotobj.LoadTableFile(obj[1]).GetPoints(); 
     linesobj = plotobj.GetComposition().GetLines();
    }
    if(obj[0].equals("randomdata")) {
     PrintWriter rfile;
     rfile = createWriter("random.txt");
     for( int i = 0; i < int(obj[1]);i ++ ) {
      rfile.println( i + "," + random(-280, 280) + "," + random(-280, 280) + ",");   
      rfile.flush();
     }
     rfile.close();
    }
    
  }
  
  if(obj.length >= 1){
    if(obj[0].equals("exit")) {
     exit(); 
    }
    if(obj[0].equals("convexhullsearch")) {
     plotobj.ConvexHullSearch();    
     linesobj = plotobj.GetComposition().GetLines();
    }
  }
 }
}
