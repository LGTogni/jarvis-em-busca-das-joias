class Timer{
  private long ultimoTempo;
  private int intervalo;
  
  public Timer(int intervalo){
    ultimoTempo = millis();
    this.intervalo = intervalo;
  }
  
  public boolean disparou(){
    long tempoAtual = millis();
    if(tempoAtual-ultimoTempo>=intervalo){
      //ultimoTempo=ultimoTempo+intervalo;
      ultimoTempo=tempoAtual;
      return true;
    }
    return false;
  }
  
  
}
