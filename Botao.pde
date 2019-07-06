class Botao{
  int x, y;
  String texto;
  int lar,alt;
  boolean pressionado;
  
  public Botao(int x, int y, int lar, int alt, String texto){
    this.x=x;
    this.y=y;
    this.lar=lar;
    this.alt=alt;
    this.texto=texto;
    pressionado=false;
  }
  
  boolean clicado(){
    return (mouseX>x&&mouseX<x+lar&&mouseY>y&&mouseY<y+alt);
  }
  
  void destaque(){
    pressionado=true;
  }
  
  void removeDestaque(){
    pressionado=false;
  }
  
  void desenhe(){
    if(pressionado)fill(255,255,100);
    else fill(255);
    rect(x,y,lar,alt);
    fill(120);
    textAlign(CENTER,CENTER);
    text(texto,x,y,lar,alt);
  }
}
