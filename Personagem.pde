class Personagem{
protected float x,y; //posição do personagem na tela
private PImage sprites, bulletImg; //referência pra imagem do personagem
private float vel; //velocidade e vida do personagem
private int coin, life, colorLife, barLife, dano, score, navesPerdidas, joia; //Moedas, vida, cor da barra de vida, tamanho da barra da vida, dano, pontos e naves perdidas pelo personagem
private char tEsq, tDir; //teclas para controlar
private int lar, alt; //largura e altura de um sprite
private ArrayList<Bullet> bullets;
Timer tiroTimer, scoreTimer;

public Personagem(PImage img, float posX, float posY, char tEsq, char tDir, int lar, int alt){
  this.lar=lar;
  this.alt=alt;
  this.tEsq=tEsq;
  this.tDir=tDir;
  x=posX;
  y=posY+height/2;
  sprites = img;
  barLife=width;
  vel=6;
  joia=0;
  coin=0;
  dano=5;
  life=100;
  score=0;
  navesPerdidas=0;
  scoreTimer = new Timer(500);
  colorLife=255;
  bulletImg=loadImage("image/laserGreen.png");
  bullets = new ArrayList<Bullet>();
  tiroTimer = new Timer(250);
}

void verificaNavesPerdidas(){
  if(navesPerdidas>=3){
      life=0;
      coinTotal+=this.coin;
      if(highScore<=score) highScore=score;
      estado=2;
      barLife=0;
      colorLife=0;
    }
}

void atualizaLife(int damage)
{  
    life-=damage;
    if(life==100) 
    {
      barLife=width;
      colorLife=255;
    }
    else if(life<=0) 
    {
      coinTotal+=this.coin;
      if(highScore<=score) highScore=score;
      estado=2;
      barLife=0;
      colorLife=0;
    }
    else
    {
      barLife=(life*(width/100));
    }
}

void atualizaCoin(int coin)
{
  this.coin+=coin;
}

void atualizaScore(int score)
{
  if(scoreTimer.disparou()) this.score+=score;
}

void showExtra()
{
    //Fundo preto
    fill(0);
    strokeWeight(1.5);
    stroke(255);
    rect(0, height/1.1, width, height/10);
    if(isBoss){
    //Superior Esquerdo
    textSize(width/16);
    fill(255);
    text("Score: " + score,width/2,height/18);
    //Superior Direito
    if(navesPerdidas==0){
      image(imJog2,width/1.1,height/25,32,32);
      image(imJog2,width/1.2,height/25,32,32);
      image(imJog2,width/1.32,height/25,32,32);
    }else if(navesPerdidas==1){
      image(imJog2,width/1.1,height/25,32,32);
      image(imJog2,width/1.2,height/25,32,32);
    }
    else if(navesPerdidas==2){
      image(imJog2,width/1.1,height/25,32,32);
    }
    text("Score: " + score,width/2,height/18);
    }
    //Lado Esquerdo
    textSize(width/16);
    fill(255);
    text("Coin: " + coin, width/6, height/1.05);
    stroke(0,colorLife,0);
    strokeWeight(width/32);
    line(0, height-2, barLife, height-2);
    //Lado direito (joias)
    noStroke();
    
    if(joiasTotais>=1) fill(180,40,0);
    else fill(180,40,0,50);
    rect(width/1.8, height/1.07, width/25, width/25);
    if(joiasTotais>=2) fill(255,180,0);
    else fill(255,180,0,50);
    rect(width/1.58, height/1.07, width/25, width/25);
    if(joiasTotais>=3) fill(255,0,0);
    else fill(255,0,0,50);
    rect(width/1.42, height/1.07, width/25, width/25);
    if(joiasTotais>=4) fill(142,35,107);
    else fill(142,35,107,50);
    
    rect(width/1.3, height/1.07, width/25, width/25);
    if(joiasTotais==5) fill(255,180,0);
    else fill(255,180,0,50);
    fill(0,180,0,50);
    rect(width/1.2, height/1.07, width/25, width/25);
    if(joiasTotais==6) fill(0,0,255);
    else fill(0,0,255,50);
    rect(width/1.1, height/1.07, width/25, width/25);
  }

public void desenhe() {
  image(sprites,x,y,lar,alt);
}


public void movimente() {
  if(teclas[tEsq] && x>0){
    x=x-vel;
  }
  if(teclas[tDir] && x<width-lar){
    x=x+vel;
  }
}

private void atirar(){
  ArrayList<Bullet> removerBullet = new ArrayList<Bullet>();
  if(tiroTimer.disparou()){
    bullets.add(new Bullet(bulletImg,x+lar/2.5,y,15,15));
  }
  
  for(Bullet b : bullets){    
    b.desenhe();
    b.movimente(true);
    if(b.y<=0) removerBullet.add(b);
    for(Npc n: npcs){
      if(b.verificaColisao(n)){
        removerBullet.add(b);
        n.life-=dano;
        n.barLife-=22;
      } 
    } 
    for(NpcAtirador nAti: npcsAtiradores){
      if(b.verificaColisao(nAti)){
        removerBullet.add(b);
        nAti.life-=dano;
        nAti.barLife-=22;
      } 
    } 
    for(Meteoro met: meteoros){
      if(b.verificaColisao(met)){
        removerBullet.add(b);
        met.life-=dano;
        met.barLife-=11;
      } 
    }
    
    if(!isBoss){
      if(tauros.y<=height/4) removerBullet.add(b);
      if(b.verificaColisao(tauros)){
        removerBullet.add(b);
        tauros.life-=dano;
      }
    }
  } 
   
  bullets.removeAll(removerBullet);
}

//Funcoes podem ser melhor adaptadas usando parâmetros que definem a altura e largura
public float getCenterX(){
  return x+lar/2;
}

public float getCenterY(){
  return y+alt/2;
}

public float getRadius(){
  return lar/2; //podemos usar um atributo raio como parametro
}

public boolean verificaColisao(Personagem p){
  return ((getCenterX()-p.getCenterX())*(getCenterX()-p.getCenterX())+(getCenterY()-p.getCenterY())*(getCenterY()-p.getCenterY()))<((getRadius()+p.getRadius())*(getRadius()+p.getRadius()));
}

}
