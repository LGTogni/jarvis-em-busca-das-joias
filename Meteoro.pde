class Meteoro extends Personagem{
  float dy, barLife;
  int life, lar, alt;
  Timer t;
  
  public Meteoro(PImage img, float posX, float posY, char tEsq, char tDir, int lar, int alt){
    super(img, posX, posY, tEsq, tDir, lar, alt);
    decideMovimento();
    x=posX;
    y=posY;
    this.lar=lar;
    this.alt=alt;
    barLife=x+lar;
    life=20;
    t = new Timer(1750);
  }
  
  private void decideMovimento(){
    float dir = random(2);
    if(dir<1) dy=5;
    else if(dir<2) dy=6; 
  }
  
  public void showLife(){    
    strokeWeight(1);
    stroke(0,255,0);
    line(x,y+alt+1,barLife,y+alt+1);
  }
  
  public void atirar(){
  }
  
  public void movimente() {
    if(t.disparou())
    decideMovimento();

    y=y+dy;
  }
}
