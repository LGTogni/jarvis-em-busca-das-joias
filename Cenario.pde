class Cenario
{
  float x, y, raio;
  int vel;
  
  Cenario(float posx, float posy, float raio)
  {
    x=posx;
    y=posy;
    this.raio=raio;
    vel=width/126;
  }
  
  void movimenta()
  { 
    y+=vel;
  }
  
  void desenhe()
  {   
    noStroke();
    fill(255);
    ellipse(x,y,raio,raio);
    movimenta();
  }
}
