//Dylan Conley
//ObstacleAvoidance_PathPlanning
//3/31/15
int[][] nmap;
int start = -1;
int end = -1;

ArrayList openSet;  //will hold the walkable nodes
ArrayList closedSet; // will hold the unwalkable nodes
ArrayList nodes;
ArrayList path;  //will hold the current path being tested.

void setup()
{
   size(480,320);
   background(255);
   smooth();
   nmap = new int[height/16][width/16];
  //Constructors for arrays
  openSet = new ArrayList();
  closedSet = new ArrayList();
  nodes = new ArrayList(); 
  path = new ArrayList();
  generateMap();
}

void draw()
{
  Node t1,t2;
  //goes through the whole array of nodes
  for ( int i = 0; i < nodes.size(); i++ ) 
  {
    //Gets what type of node it is.
    t1 = (Node)nodes.get(i);
    
    //Green for the start node
    if (i==start) 
    {
      //fill(0,255,0);
     // rect(t1.x,t1.y,16,16);
     fill(0,0,255);
      ellipse(t1.x, t1.y, 10, 10);
    }
    //red for the end node
    else if (i==end) 
    {
      //fill(255,0,0);
      //rect(t1.x,t1.y,16,16);
      fill(0,0,255);
      ellipse(t1.x, t1.y, 10, 10);
    }
    else 
    {
      //draws the path in white
      if (path.contains(t1)) 
      {
       //fill(0,0,255);
       //ellipse(t1.x, t1.y, 5, 5);
       //fill(0,150,150);
       //rect(t1.x,t1.y,16,16);
      }
      //draws the empty square for the walkable nodes
      else 
      {
        fill(0);
        rect(t1.x,t1.y,16,16);
      }
    }
    //draws the grid graph of possible walkable nodes
    for ( int ii = 0; ii < t1.nbors.size(); ii++ ) {
      t2 = (Node)t1.nbors.get(ii);
      stroke(map( ((Float)t1.nCost.get(ii)) , 0.25, 2.0, 0, 255 ) );
      line(t1.x+8,t1.y+8,t2.x+8,t2.y+8);
    }
  }
}

void mousePressed() 
{
  //checks if spot clicked is a walkable spot
  if (nmap[int(floor(mouseY/16))][int(floor(mouseX/16))]!=-1) 
  {
    //checks if start spot is still needed
    if (start==-1) 
    {
      //sets the start spot
      start = nmap[int(floor(mouseY/16))][int(floor(mouseX/16))];
    }
    //if start isn't needed it checks if end spot is needed
    else if (end==-1) 
    {
      //sets the end spot
      end = nmap[int(floor(mouseY/16))][int(floor(mouseX/16))];
      //prints if path was found or not
      println( astar(start,end) );
      //resets the end if it is at start
      if (end==start) 
      {
        end = -1;
      }
    }
    //resets all the values to start a new walk
    else 
    {
      start = -1;
      end = -1;
      path.clear();
    }
  }
}

