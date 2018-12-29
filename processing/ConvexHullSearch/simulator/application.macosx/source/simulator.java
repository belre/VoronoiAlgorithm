import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.*; 
import javax.swing.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class simulator extends PApplet {






// MenuBar
JLayeredPane pane = new JLayeredPane();
JMenuBar menubar = new JMenuBar();


public void setup()
{
 
 
 
 
 colorMode(RGB, 100);
  
 //System.setProperty("apple.laf.useScreenMenuBar", "true");
 
 Canvas canvas = (Canvas)surface.getNative();
 pane = (JLayeredPane) canvas.getParent().getParent();
 
 JMenu menu = new JMenu("menu");
 JMenuItem item = new JMenuItem("item");
 menu.add(item);
 menubar.add(menu);
 pane.add(menubar);

  

 
}

public void draw()
{
  
 Test obj = new Test();
 background(255,255,255);
 
 fill(obj.test(),255,255); 
 rect(0, 0, 20, 20); 
  
}


class Test
{
 public int test()
 {
  return 100; 
 }  
  
}
  public void settings() {  size(500,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "simulator" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
