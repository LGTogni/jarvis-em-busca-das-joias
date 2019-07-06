class Joias {
  protected float x, y; //posição do personagem na tela
  private int quadro; //numero do quadro sendo exibido
  private PImage sprites; //referência pra imagem do personagem
  private int lar, alt; //largura e altura de um sprite

  public Joias(PImage img, float posX, float posY, int lar, int alt, int quadro) {
    this.lar=lar;
    this.alt=alt;
    x=posX;
    y=posY;
    sprites=img;
    this.quadro=quadro;
  }


  public void desenhe() {
    int px=0;
    int py=(quadro/2)*lar;
    image(sprites.get(px, py, lar, alt), x, y);
  }
  
  public void movimente() {     
    if(y>=jarvis.y) y=jarvis.y;
    else y+=5;
  }

  //Funcoes podem ser melhor adaptadas usando parâmetros que definem a altura e largura
  public float getCenterX() {
    return x+lar/2;
  }

  public float getCenterY() {
    return y+alt/2;
  }

  public float getRadius() {
    return lar/2; //podemos usar um atributo raio como parametro
  }

  public boolean verificaColisao(Personagem p) {
    return ((getCenterX()-p.getCenterX())*(getCenterX()-p.getCenterX())+(getCenterY()-p.getCenterY())*(getCenterY()-p.getCenterY()))<((getRadius()+p.getRadius())*(getRadius()+p.getRadius()));
  }
}
