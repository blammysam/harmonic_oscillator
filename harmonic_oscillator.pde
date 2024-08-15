float x = 500;
float y = 200;
float mass = 1000;
float w = mass/50;
float h = mass/50;

float vel;
float acceleration;
float kineticEnergy;
float potentialEnergy;
float basex = 50;
float basey = 200;
float equilibrium = x;
float k = 1;
float startPosition = equilibrium;

float restoringForce;
float displacement;

int mouseClickedThisFrame = 0;
float scroll = 0;
void setup(){
  size(1000,400);
  rectMode(CENTER);  
}

void draw(){
  frameRate(60);
  if (scroll !=0){
    mass -= scroll*300;
    if(mass <= 0){
      mass = 100;
    }

    w = mass/50;
    h = mass/50;
    x = startPosition;
    vel = 0;
  }
  set_position();
  ///calculate energy
  //KE = 1/2mv^2
  kineticEnergy = mass*(vel*vel)/2;
  //PE = 1/2kx^2
  potentialEnergy = k*(displacement*displacement)/2;
  
  drawSystem();
  showInfo();
 
  
  
  mouseClickedThisFrame = 0;
  scroll = 0;
}
void set_position(){
  

  if(mouseClickedThisFrame == 1){
    startPosition = mouseX;
    x = mouseX;
    vel = 0;
  
  }
  if(mouseClickedThisFrame == 2){
    equilibrium = mouseX;
    x = startPosition;
    vel = 0;
  }
  displacement = x-equilibrium;
  //F = -kx
  restoringForce = -(k*displacement);
  //F = ma
  acceleration = restoringForce/mass;
  vel += acceleration;
  //minus vel because y ++ lowers block
  x += vel;
  

}
void drawSystem(){
  background(0);
  stroke(255);
  //spring
  line(x,y,basex,basey);
  //base
  rect(basex,basey,2,50);
  //block
  rect(x,y,w,h);
  
}
void showInfo(){
  
  //amplitude lines
  stroke(100);
  line(startPosition,0, startPosition, height);
  line(equilibrium + (equilibrium-startPosition),0,equilibrium + (equilibrium-startPosition),height);
  
  //equilibrium line
  stroke(255);
  line(equilibrium,0, equilibrium, height);
  
  float graphy = 100;
  line(50,graphy,50,graphy-potentialEnergy/1000);
  line(70,graphy,70,graphy-kineticEnergy/1000);
  text("PE",50,graphy+15);
  text("KE",70,graphy+15);
  
}
void mouseClicked(){
  if(mouseButton == LEFT){
    mouseClickedThisFrame = 1;
  }else if (mouseButton == RIGHT){
    mouseClickedThisFrame = 2;
  }
  
}
void mouseWheel(MouseEvent event){
  scroll = event.getCount();
}
