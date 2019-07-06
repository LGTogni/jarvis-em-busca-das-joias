class Bullet{
  private float x, y;
  private float vel;
  private PImage sprite;
  private int lar, alt; //largura e altura de um sprite
  
  public Bullet(PImage img, float posX, float posY, int lar, int alt){
    x=posX;
    y=posY;
    this.lar=lar;
    this.alt=alt;
    vel=5;
    sprite=img;
  } 
  
  public void desenhe(){
    image(sprite,x,y,lar,alt);
  }
  
  public void movimente(boolean isPlayer){
    if(isPlayer) y-=vel;
    else if (!isPlayer) y+=8;
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
