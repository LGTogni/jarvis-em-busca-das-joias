class NpcAtirador extends Personagem{
  float dy,barLife;
  int life, lar, alt, dano;
  PImage bulletImg;
  private ArrayList<Bullet> bullets;
  Timer t, tiroTimer;
  
  public NpcAtirador(PImage img, float posX, float posY, char tEsq, char tDir, int lar, int alt, int dano){
    super(img, posX, posY, tEsq, tDir, lar, alt); 
    decideMovimento();
    this.x=posX;
    this.y=posY;
    this.lar=lar;
    this.alt=alt;
    barLife=x+lar;
    this.dano=dano;
    life=15;
    t = new Timer(1750);
    bullets = new ArrayList<Bullet>();
    tiroTimer = new Timer(500);
    bulletImg=loadImage("image/laserRed.png");
  }
  
  private void decideMovimento(){
    float dir = random(2);
    if(dir<1) dy=4;
    else if(dir<2) dy=5; 
  }
  
  private void atirar(){
    ArrayList<Bullet> removerBulletNPC = new ArrayList<Bullet>();
    if(tiroTimer.disparou()){
      bullets.add(new Bullet(bulletImg,x+lar/2.5,y+50,15,15));
    }
    for(Bullet bAti : bullets){    
    bAti.desenhe();
    bAti.movimente(false);
    if(bAti.y>=height) removerBulletNPC.add(bAti);
    if(bAti.verificaColisao(jarvis)){
      removerBulletNPC.add(bAti);
      jarvis.atualizaLife(dano);
    }
   }
   bullets.removeAll(removerBulletNPC);
  }
  
  public void showLife(){    
    strokeWeight(1);
    stroke(0,255,0);
    line(x,y+alt+1,barLife,y+alt+1);
  }
  
  public void movimente() {
    if(t.disparou())
    decideMovimento();

    y=y+dy;
  }
}
