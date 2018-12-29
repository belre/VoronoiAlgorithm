import java.awt.*;
import javax.swing.*;



// MenuBar
JLayeredPane pane = new JLayeredPane();
JMenuBar menubar = new JMenuBar();


void setup()
{
 size(500,500);
 
 
 
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

void draw()
{
  
 Test obj = new Test();
 background(255,255,255);
 
 fill(obj.test(),255,255); 
 rect(0, 0, 20, 20); 
  
}
