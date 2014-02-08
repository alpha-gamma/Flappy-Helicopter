import 'dart:html';
import 'dart:async';
import 'dart:math' show Random;


CanvasElement context = querySelector("#canvas");
CanvasRenderingContext2D ctx = context.context2D;

ImageElement image = new ImageElement(src: "dummy.png");

Timer timer;

Timer walltimer;

const int SPEED = 80; // in milliseconds

int x=10;
int y=10;

int wallHeight=20;
int wallWidth=5;

List wallX = [];
List wallY = [10.30];

void main() {
drawImage();
initTimer();
for(int i=0;i<100;i++) {
  wallX.add(300+i*80);
  wallY.add(new Random().nextInt(120));
}
context.onMouseDown.listen(changeHeli);
wallmove();
}

void changeHeli(Event e)
{
  ctx.clearRect(x,y-3,60,30);
  if(y>20)
    y-=20;
  else
    y=0;
  ctx.drawImageScaled(image,x,y,50,20);
}
 
void drawImage(){
 
var x = context.width /10;
var y = context.height /10;
 
image.onLoad.listen(onData, onError: onError, onDone: onDone, cancelOnError: true);
 
}
 
onData(Event e) {
print("success: ");
ctx.drawImageScaled(image,10,10,50,20);
}
 
onError(Event e) {
print("error: $e");
}
 
onDone() {
print("done");
}

void initTimer()
{
  void moveheli(Timer timer)
  {
    ctx.clearRect(x,y-3,60,30);
    y+=3;
    if(y>130){
      y=150;
     //window.alert("Over");
     timer.cancel();
     walltimer.cancel();
     gameOver();
    }
    ctx.drawImageScaled(image,x,y,50,20);
    
  }
  timer = new Timer.periodic(const Duration(milliseconds: SPEED),moveheli);
}

void wallmove()
{
  void move(Timer t)
  {
    for(int i=0;i<100;i++)
    { ctx.clearRect(wallX[i]-5, wallY[i]-1, wallWidth+6, wallHeight+2);
      wallX[i]-=2;
      ctx.fillRect(wallX[i], wallY[i], wallWidth, wallHeight);
      if(wallX[i]<60 && wallX[i]>10 && (wallY[i]+20>=y &&wallY[i]<=y+20)) {
        //window.alert('Over');
        walltimer.cancel();
        timer.cancel();
        gameOver();
      }
    }
  }
  
  walltimer=new Timer.periodic(const Duration(milliseconds: 50),move);
}

void gameOver() {
  ctx.clearRect(0, 0, 400, 150);
  ctx.fillText("Game Over", 100, 70, 300);
}