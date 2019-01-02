import java.util.Stack;
import java.util.List;
import java.util.Comparator;


class GPointXCoorComparator implements Comparator<GPoint> {
 int compare( GPoint a, GPoint b) {
  GPoint a_pnt = a;
  GPoint b_pnt = b;
   
  if( a_pnt._px > b_pnt._px) {
   return 10;
  }
  else if( a_pnt._px < b_pnt._px) {
   return -10;
  }
  else {
   if( a_pnt._py > b_pnt._py) {
    return 1; 
   } else if( a_pnt._py < b_pnt._py ) {
    return -1; 
   } else {
    return 0;
   }
  }
 }
}



class ConvexHullSearchSample {
 List<GPoint> _plists;
 List<GPoint> _convexhull;
 int[] _results;

 public ConvexHullSearchSample() {}
 
 public boolean allocateGPoint(GPoint[] points) {
  if(points == null )    return false;  
  
  _plists = new ArrayList<GPoint>();
  for( GPoint obj : points ) {
   if(obj != null && obj._px != Float.NaN && obj._py != Float.NaN) {
    _plists.add(obj);
   }
   else {
    _plists = null;
    return false;
   }
  }
  return true;
 }
 
 public GPoint[] getPointList() {
  if( _plists == null ) {
   return null; 
  } else {
    GPoint[] arr = new GPoint[_plists.size()];
    
    for( int i = 0 ; i < _plists.size(); i++ ) {
     GPoint obj = _plists.get(i);
     if( obj == null ) {
      return null; 
     }
     else {
       arr[i] = obj;
     }
    }

    return arr;
  }
 }
 
 private boolean isTangentFromBoundary(GVector2d  upper_vec0, GVector2d lower_vec0, GVector2d tangency_vec) {
  // decide boundary vector by orthant,
  // then always boundary_vec[0] orthant <= boundary_vec[1] orthant
  GVector2d[] boundary_vec = sort2VectorByPhase(upper_vec0, lower_vec0);
  
  // x_val of tangency vector is always at range 0 < x < 1
  // y_val of tangency vector is assured uniquely at range -1 < y < 1 
  // compare x_val and y_val of tangency vector and boundary 2 vectors
  // 1'
  if( boundary_vec[0]._dx > 0 && boundary_vec[1]._dx > 0 ) {
   return true; 
  // 2'
  } else if( boundary_vec[0]._dx < 0 && boundary_vec[1]._dx >= 0 ) {
   if( boundary_vec[1]._dy >= 0 ) {
    println("err: x0 < 0, x1 > 0, y1 >= 0");    
    return false;
   } else if( boundary_vec[1]._dy < 0 && boundary_vec[0]._dy < 0 ) {
    if( tangency_vec._dy > boundary_vec[0]._dy ) {
     return true;
    } else {
     return false; 
    }     
   } else if( boundary_vec[1]._dy < 0 && boundary_vec[0]._dy > 0 ) {
    GVector2d rot_vec = boundary_vec[1].multiply(-1);
    
    // 2-3-a.
    if( boundary_vec[0]._dy >= rot_vec._dy) {    // judge max
     if( tangency_vec._dy < boundary_vec[0]._dy ) {
      return true;
     } else {
      return false; 
     } 
    // 2-3-b.
    } else {                                  // judge min
     if( tangency_vec._dy > boundary_vec[0]._dy ) {
      return true;
     } else {
      return false; 
     } 
    }
   } else {
    println("boundary err2");
    return false;
   }
  // 3'
  } else if( boundary_vec[0]._dx >= 0 && boundary_vec[1]._dx < 0) {
   
   if( boundary_vec[0]._dy < 0 ) {
    println("err: x0 > 0, x1 < 0, y0 < 0");    
    return false;
   } else if( boundary_vec[0]._dy >= 0 && boundary_vec[1]._dy >= 0 ) {
    if( tangency_vec._dy < boundary_vec[1]._dy ) {
     return true;
    } else {
     return false; 
    }     
   } else if( boundary_vec[0]._dy >= 0 && boundary_vec[1]._dy < 0 ) {
    GVector2d rot_vec = boundary_vec[0].multiply(-1);
    
    if( boundary_vec[1]._dy >= rot_vec._dy) {    // judge max
     if( tangency_vec._dy < boundary_vec[1]._dy ) {
      return true;
     } else {
      return false; 
     } 
    } else {                                  // judge min
     if( tangency_vec._dy > boundary_vec[1]._dy ) {
      return true;
     } else {
      return false; 
     } 
    }
   } else {
    println("boundary err2");
    return false;
   }  
  // 4'
  } else {
   double miny = Math.min( boundary_vec[0]._dy, boundary_vec[1]._dy);
   double maxy = Math.max( boundary_vec[0]._dy, boundary_vec[1]._dy);
   
   if( tangency_vec._dy > miny && tangency_vec._dy < maxy) {
    return false; 
   } else {
    return true; 
   }
  }
 }
 
 private GVector2d[] sort2VectorByPhase(GVector2d upper_vec0, GVector2d lower_vec0) {
  // get orthant
  int upper_orthant = upper_vec0.getOrthant();
  int lower_orthant = lower_vec0.getOrthant();
  
  // decide boundary vector by orthant,
  // then always boundary_vec[0] orthant <= boundary_vec[1] orthant
  GVector2d[] boundary_vec = new GVector2d[2];
  if( upper_orthant < lower_orthant ) {
   boundary_vec[0] = upper_vec0;
   boundary_vec[1] = lower_vec0;
  } else if( upper_orthant > lower_orthant ) {
   boundary_vec[0] = lower_vec0;
   boundary_vec[1] = upper_vec0; 
  } else {
   if( upper_orthant == 1 && lower_orthant == 1 || upper_orthant == 2 && lower_orthant == 2) {
    if( upper_vec0._dx <= lower_vec0._dx ) {
     boundary_vec[0] = upper_vec0;
     boundary_vec[1] = lower_vec0;      
    } else {
     boundary_vec[0] = lower_vec0;
     boundary_vec[1] = upper_vec0;  
    }
   } else if(upper_orthant == 3 && lower_orthant == 3 || upper_orthant == 4 && lower_orthant == 4) {
    if( upper_vec0._dx >= lower_vec0._dx ) {
     boundary_vec[0] = upper_vec0;
     boundary_vec[1] = lower_vec0;      
    } else {
     boundary_vec[0] = lower_vec0;
     boundary_vec[1] = upper_vec0;  
    }
   } 
  }
  
  return boundary_vec;
 }
 
 private boolean isValidBoundary(GVector2d  upper_vec0, GVector2d lower_vec0, GVector2d tangency_vec) {
  GVector2d[] boundary_vec = sort2VectorByPhase(upper_vec0, lower_vec0);
 
  
  // x_val of tangency vector is always at range 0 < x < 1
  // y_val of tangency vector is assured uniquely at range -1 < y < 1 
  // compare x_val and y_val of tangency vector and boundary 2 vectors
  // 1
  if( boundary_vec[0]._dx <= 0 && boundary_vec[1]._dx <= 0 ) {
   return true; 
  // 2
  } else if( boundary_vec[0]._dx <= 0 && boundary_vec[1]._dx > 0) { 
   if( boundary_vec[1]._dy >= 0 ) {
    println("err: x0 < 0, x1 > 0, y1 >= 0");    
    return false;
   } else if( boundary_vec[1]._dy < 0 && boundary_vec[0]._dy < 0 ) {
    if( tangency_vec._dy > boundary_vec[1]._dy ) {
     return true;
    } else {
     return false; 
    }     
   } else if( boundary_vec[1]._dy < 0 && boundary_vec[0]._dy > 0 ) {
    GVector2d rot_vec = boundary_vec[0].multiply(-1);
    
    // 2-3-a.
    if( boundary_vec[1]._dy >= rot_vec._dy) {    // judge max
     if( tangency_vec._dy < boundary_vec[1]._dy ) {
      return true;
     } else {
      return false; 
     } 
    // 2-3-b.
    } else {                                  // judge min
     if( tangency_vec._dy > boundary_vec[1]._dy ) {
      return true;
     } else {
      return false; 
     } 
    }
   } else {
    println("boundary err2");
    return false;
   }  
  // 3
  } else if( boundary_vec[1]._dx <= 0 && boundary_vec[0]._dx > 0) {
   if( boundary_vec[0]._dy < 0 ) {
    println("err: x0 > 0, x1 < 0, y1 < 0");    
    return false; 
   } else if( boundary_vec[0]._dy >= 0 && boundary_vec[1]._dy >= 0 ) {
    if( tangency_vec._dy < boundary_vec[0]._dy ) {
     return true;
    } else {
     return false; 
    }
   } else if( boundary_vec[0]._dy >= 0 && boundary_vec[1]._dy < 0 ) {
    GVector2d rot_vec = boundary_vec[1].multiply(-1);
    // 3-2-a.
    if( boundary_vec[0]._dy >= rot_vec._dy) {    // judge max
     //printVector2d(rot_vec);
     if( tangency_vec._dy < boundary_vec[0]._dy ) {
      return true;
     } else {
      return false; 
     } 
    // 3-2-b.
    } else {                                  // judge min
     if( tangency_vec._dy > boundary_vec[0]._dy ) {
      return true;
     } else {
      return false; 
     } 
    }
   } else {
    println("boundary err3");
    return false;
   }
  // 4.
  } else {
   double miny = Math.min( boundary_vec[0]._dy, boundary_vec[1]._dy);
   double maxy = Math.max( boundary_vec[0]._dy, boundary_vec[1]._dy);
   
   if( tangency_vec._dy > miny && tangency_vec._dy < maxy) {
    return false; 
   } else {
    return true; 
   }
  }
 }

 public GPoint[] GetResultOfConvexHull() {
  if( this._convexhull == null )      return null;
  
  GPoint[] convexhull = new GPoint[this._convexhull.size()];
  for( int i = 0 ; i < this._convexhull.size(); i ++ ) {
   convexhull[i] = this._convexhull.get(i); 
  }
   
  return convexhull; 
 }
 
 public boolean execute() {
  // Input
  GPoint[] points = this.getPointList();
  
  // Output
  List<GPoint> convexhull = new ArrayList<GPoint>();
  
  // Sort by x-cooridinates value
  Arrays.sort( points, new GPointXCoorComparator());
  
  /**
  println("---sort---");
  for(GPoint pnt : points) {
   println( pnt._label + "," + pnt._px + "," + pnt._py );
  } **/

  /// --- Initialize : first 3 nodes are stored
  boolean endflag = false;
  int parallelcount = 0;
  for( int i = 2; i < points.length && !endflag; i ++ )  {
   GVector2d veca = new GVector2d(points[0]).subtract( new GVector2d(points[i-1]), 1);
   veca.normalized();
   GVector2d vecb = new GVector2d(points[0]).subtract( new GVector2d(points[i]), 1); 
   vecb.normalized();
  
   // init state is defined by sin value 
   double sinval = vecb._dy * veca._dx - vecb._dx * veca._dy;
   if( sinval == 0 ) {      // 2 vector is parallel or the same 
    parallelcount ++;
   } else if( sinval > 0)  {
    convexhull.add(points[0]);
    convexhull.add(points[i]); 
    convexhull.add(points[i-1]);
    endflag = true;
   }
   else
   {
    convexhull.add(points[0]);
    convexhull.add(points[i-1]); 
    convexhull.add(points[i]); 
    endflag = true;
   }   
  }

  
  printConvexHull(convexhull);

  // 4 or later nodes will be searched
  int recentindex = 2;
  if( convexhull.get(1)._px < convexhull.get(2)._px ) {
   recentindex = 2;
  } else {
   recentindex = 1; 
  }
  
  for( int i = 3 + parallelcount; i < points.length; i++) {
  // println("Target:" + points[i]._label + "," + points[i]._px + "," + points[i]._py);
   
   if(points[i]._px == points[i-1]._px && points[i]._py == points[i-1]._py ) {
    continue; 
   }
   
   // select neighbor node
   GVector2d newpoint_vec0 = new GVector2d(points[i]);
   GVector2d recent_vec0 = new GVector2d(getConvexHullNode(recentindex, convexhull));
   GVector2d upper1_vec0 = new GVector2d(getConvexHullNode(recentindex-1, convexhull));
   GVector2d lower1_vec0 = new GVector2d(getConvexHullNode(recentindex+1, convexhull));
   double[] dist1 = new double[] {
    points[i].distanceSq( getConvexHullNode(recentindex-1, convexhull)),
    points[i].distanceSq( getConvexHullNode(recentindex, convexhull) ),
    points[i].distanceSq( getConvexHullNode(recentindex+1, convexhull))
   };
   
   
   GVector2d upper1_tangency_vec = (newpoint_vec0).subtract(upper1_vec0, 1);
   upper1_tangency_vec.normalized();
   
   GVector2d upper1_diffvec = recent_vec0.subtract(upper1_vec0, 1);
   upper1_diffvec.normalized();
  
   GVector2d upper2_diffvec = upper1_vec0.subtract(new GVector2d(getConvexHullNode(recentindex-2, convexhull)), -1);
   upper2_diffvec.normalized();
  
   GVector2d lower1_tangency_vec = (newpoint_vec0).subtract(lower1_vec0, 1);
   lower1_tangency_vec.normalized();

   GVector2d lower1_diffvec = recent_vec0.subtract(lower1_vec0, 1);
   lower1_diffvec.normalized();
   
   GVector2d lower2_diffvec = lower1_vec0.subtract(new GVector2d(getConvexHullNode(recentindex+2,convexhull)), -1);
   lower2_diffvec.normalized();

  int neighbor1 = 0, neighbor2 = 0;
  boolean isvalid_upper1 = isValidBoundary(upper2_diffvec, upper1_diffvec, upper1_tangency_vec);
  boolean isvalid_lower1 = isValidBoundary(lower1_diffvec, lower2_diffvec, lower1_tangency_vec);

  if( isvalid_upper1 && isvalid_lower1 )  {
   if(dist1[0] < dist1[2]) {
    neighbor1 = getConvexHullIndex(recentindex-1, convexhull);
    neighbor2 = getConvexHullIndex(recentindex, convexhull);
   } else {
    neighbor1 = getConvexHullIndex(recentindex, convexhull);
    neighbor2 = getConvexHullIndex(recentindex+1, convexhull);
   }
  } else if( isvalid_upper1 ) {
   neighbor1 = getConvexHullIndex(recentindex-1, convexhull);
   neighbor2 = getConvexHullIndex(recentindex, convexhull);
  } else if( isvalid_lower1 ) {
   neighbor1 = getConvexHullIndex(recentindex, convexhull);
   neighbor2 = getConvexHullIndex(recentindex+1, convexhull);
  } else {
   // failed
   println("analyse error");
   printVector2d(upper2_diffvec);
   printVector2d(upper1_diffvec);
   printVector2d(upper1_tangency_vec);
   printVector2d(lower1_diffvec);
   printVector2d(lower2_diffvec);
   printVector2d(lower1_tangency_vec);
   return false;
  }
  //println( "neighbor:" + neighbor1 +"," +neighbor2);
   
   int nextstepnum = convexhull.size();
   int currentjj = neighbor1;
   boolean isstopsearch = false;
   while( nextstepnum > 2 && !isstopsearch) {
    if( !isTangent( points[i], new GPoint[] { 
      getConvexHullNode(currentjj-1, convexhull), 
      getConvexHullNode(currentjj, convexhull),
      getConvexHullNode(currentjj+1, convexhull)}, convexhull)) {
       currentjj --;
       nextstepnum --;
    } else {
     isstopsearch = true;
    }
   }
   int upper = currentjj;
   
   currentjj = neighbor2;
   isstopsearch = false;
   while( nextstepnum > 2 && !isstopsearch) {
    if( !isTangent( points[i], new GPoint[] { 
      getConvexHullNode(currentjj-1, convexhull), 
      getConvexHullNode(currentjj, convexhull),
      getConvexHullNode(currentjj+1, convexhull)}, convexhull)) {
       currentjj ++;
       nextstepnum --;
    } else {
     isstopsearch = true;
    }  
   }
   int lower = currentjj;


   if (upper+1 == lower || upper == convexhull.size()-1 && lower == 0) {
     // insert to upper
     convexhull.add(upper+1, points[i]);
     recentindex = upper+1;
     
     //println("P1 " + (upper+1));
   } else if( upper < lower ) {
     //printConvexHull(convexhull);
     
     int num = lower - (upper+1);
     for(int j = 0 ; j < num ; j ++ ) {
      convexhull.remove(upper+1);
     }

     //printConvexHull(convexhull);
     
     // insert to upper
     convexhull.add(upper+1, points[i]);     
     recentindex = upper+1;
     
     //println("P2 " + (upper+1));
   } else {
    // remove edge(right)
    if( upper != convexhull.size() - 1) {
     int num = convexhull.size() - (upper+1);
     for(int j = 0 ; j < num ; j ++ ) {
      convexhull.remove(upper+1);
     }
    }
    
    // remove edge(left)
    if( lower != 0) {
     for( int j = 0 ; j < lower ; j ++ ) {
      convexhull.remove(0); 
     }
    }
    
    // insert last
    convexhull.add(convexhull.size(), points[i]);
    recentindex = convexhull.size()-1;
   }  

   //printConvexHull(convexhull);
  }
  
  this._convexhull = convexhull;
  
  //rintConvexHull(convexhull);
  
  return true; 
 }
 
 private boolean isTangent(GPoint dest, GPoint[] neighbornodes, List<GPoint> convexhull)
 {
  GVector2d target_vec = new GVector2d(neighbornodes[1]);
  
  // upper and lower(boundary condition)
  GVector2d upper_vec = target_vec.subtract(new GVector2d(neighbornodes[0]), -1);
  upper_vec.normalized();
  //printVector2d(upper_vec);
  
  GVector2d lower_vec = target_vec.subtract(new GVector2d(neighbornodes[2]), -1);
  lower_vec.normalized();
  //printVector2d(lower_vec);
  
  GVector2d tangency_vec = target_vec.subtract(new GVector2d(dest), 1);
  tangency_vec.normalized();
  //printVector2d(tangency_vec);
   
  return isTangentFromBoundary(upper_vec, lower_vec, tangency_vec);
 }
 

 private int getConvexHullIndex(int index, List<GPoint> convexhull) {
  if( index < 0 )   index += convexhull.size();
   
  return (index) % convexhull.size();
 }

 private GPoint getConvexHullNode(int index, List<GPoint> convexhull) {
  GPoint node = convexhull.get(getConvexHullIndex(index,convexhull));
  return node;
 }
 
 private void printVector2d(GVector2d vec) {
  println("[Vector;" + vec._label + "] --- x:" + vec._dx + " , y:" + vec._dy);  
 }
 
 private void printConvexHull(List<GPoint> convexhull){ 
  println("--- Progress Report ---");
  for( GPoint pnt : convexhull ) {
   println( pnt._label + "," + pnt._px + "," + pnt._py );
  }
 }

 public void printConvexHull() {
  this.printConvexHull(this._convexhull); 
 }

}
 
