class Tauros extends Personagem{
  float dx,barLife;
  int life, lar, alt, dano;
  private int quadro; //numero do quadro sendo exibido
  PImage bulletImg, sprites;
  private ArrayList<Bullet> bullets;
  Timer t, tiroTimer;
  
  public Tauros(PImage img, float posX, float posY, char tEsq, char tDir, int lar, int alt, int quadro, int life, int dano){
    super(img, posX, posY, tEsq, tDir, lar, alt); 
    decideMovimento();
    sprites=img;
    this.x=posX;
    this.y=posY;
    this.lar=lar;
    this.alt=alt;
    this.dano=dano;
    barLife=x+lar;
    this.quadro=quadro;
    this.life=life;
    t = new Timer(1750);
    bullets = new ArrayList<Bullet>();
    tiroTimer = new Timer(1100);
    bulletImg=loadImage("image/taurosLaser.png");
  }
  
  public void desenhe() {
    int px=0;
    int py=(quadro/2)*lar;
    image(sprites.get(px,py,lar,alt),x,y,100,100);
  }
  
  private void decideMovimento(){
    float dir = random(2);
    if(dir<1) dx=2;
    else if(dir<2) dx=4; 
  }
  
  private void atirar(){
    ArrayList<Bullet> removerBulletNPC = new ArrayList<Bullet>();
    if(tiroTimer.disparou()){
      bullets.add(new Bullet(bulletImg,x+lar/1.8,y+80,32,32));
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
    if(y<=height/4 && life>0) {
      y+=2;
    }else if(y>height/4 && life>0){     
      if(x<=64) dx=+dx;
      else if(x>width-lar-dx) dx=-dx;
      x=x+dx;  
      
    }else if(life<=0){
      y-=2;
    }
  }
}
