Personagem jarvis; //Personagem numero 1
//Chefão
Tauros tauros;
//Joias
Joias joiaMente;
Joias joiaAlma;  

PImage imJog1, imJog2, imJog3, imJog4, imJog5, imJog6;
boolean[] teclas; //Vetor para guarda teclas;
ArrayList<Npc> npcs;
ArrayList<NpcAtirador> npcsAtiradores;
ArrayList<Meteoro> meteoros;
ArrayList<Cenario> cenario;
Timer npcTimer, cenarioTimer, meteoroTimer, startTimer, npcAtiradorTimer;
int estado, coinTotal, highScore, lvl, metaLvl, joiasTotais; 
boolean jogoEmAndamento, isBoss;

Botao botComecar, botVoltar, botSair, botReiniciar, botProximo; // Declarar o botões

//Variáveis para os botões.
int menuLar=200;
int menuAlt=50;
int dist=75;

//Verificar se a tecla foi pressionada
void keyPressed(){
  if(key<128 && key>=0)
    teclas[key]=true;
    if(key=='p' || key=='P' && estado==1) estado=3;
}

//Verificar se a tecla foi solta
void keyReleased(){
  if(key<128 && key>=0)
    teclas[key]=false;
}

void setup(){
  estado=0; // Vai começar o estado no menu
  coinTotal=0; //Moeda total que o jogador tem
  highScore=0; //Score recorde que o jogador tem
  lvl=1;//Level que o jogador está
  metaLvl=250;
  joiasTotais=0;
  teclas=new boolean[128]; // Inicializar o vetor com 128 posições
  botComecar=new Botao(width/2-100,height/2-25,200,50,"Começar"); // Inicializar o Botão começar
  botVoltar=new Botao(width/2-100,height/2-25,200,50,"Voltar"); // Inicializar o Botão voltar
  botReiniciar=new Botao(width/2-100,height/2-25,200,50,"Reiniciar"); // Inicializar o Botão reiniciar
  botProximo=new Botao(width/2-100,height/2-25,200,50,"Proximo"); // Inicializar o Botão proximo
  botSair=new Botao(width/2-100,height/2-25+75,200,50,"Sair"); // Inicializar o Botão sair
  size(400,600);
  isBoss=true;
  cenario = new ArrayList<Cenario>();
  npcs = new ArrayList<Npc>();
  npcsAtiradores = new ArrayList<NpcAtirador>();
  meteoros = new ArrayList<Meteoro>();
  jogoEmAndamento=false;
  imJog1 = loadImage("image/jarvis.png");
  jarvis = new Personagem(imJog1,width/2.5,height/4,'a','d',64,64);
  imJog2 = loadImage("image/inimigo1.png");  
  imJog3 = loadImage("image/meteoro.png");  
  imJog4 = loadImage("image/inimigo2.png");  
  imJog5 = loadImage("image/tauros.png"); 
  imJog6 = loadImage("image/joias.png"); 
}

//Função das fases do jogo
void faseDois(){ 
  if(jarvis.score>=metaLvl){
    if(isBoss) {
      tauros = new Tauros(imJog5,width/2.5,-250,'a','d',64,64,4,180,20);
      isBoss=false;      
      joiaMente = new Joias(imJog6,tauros.x,height/4,64,64,2);
    }else{
      tauros.movimente();
      tauros.desenhe();     
      if(tauros.life<=0){
        tauros.quadro=6;
        joiaMente.movimente();
        joiaMente.desenhe();     
        if(joiaMente.verificaColisao(jarvis)){
          if(tauros.y<=-64) {
            isBoss=true;
            jarvis.joia++;
            lvl=3;
            metaLvl=480;
            estado=2;
            joiasTotais+=jarvis.joia;
         }
        }
      }else if(tauros.y>=height/4){
        jarvis.atirar();
        tauros.atirar();
      }
        
      
    }
  }else{
  ArrayList<Npc> remover = new ArrayList<Npc>();
  if(npcTimer.disparou()){
    npcs.add(new Npc(imJog2,random(0, width-64),-64,'j','k',64,64));
  }
  
  ArrayList<NpcAtirador> removerNpcAtirador = new ArrayList<NpcAtirador>();
  if(npcAtiradorTimer.disparou()){
    npcsAtiradores.add(new NpcAtirador(imJog4,random(0, width-64),-64,'j','k',64,64,8));
  }
  
  ArrayList<Meteoro> removerMeteoro = new ArrayList<Meteoro>();
  if(meteoroTimer.disparou()){
    meteoros.add(new Meteoro(imJog3,random(0, width-64),-45,'j','k',45,45));
  }
  jarvis.atirar();
  jarvis.atualizaScore(5);
  
  for(Npc n: npcs){
    n.movimente();
    n.desenhe();
    n.showLife();
    if(jarvis.verificaColisao(n)){
      remover.add(n);
      jarvis.atualizaLife(20);
    }
    if(n.life<=0) {
      remover.add(n);
      jarvis.atualizaCoin(25);
    }
    if(n.y>height){
      jarvis.navesPerdidas++;
      remover.add(n);
      jarvis.verificaNavesPerdidas();
    }
  }
  for(NpcAtirador nAti: npcsAtiradores){
    nAti.movimente();
    nAti.desenhe();
    nAti.atirar();
    nAti.showLife();
    if(jarvis.verificaColisao(nAti)){
      removerNpcAtirador.add(nAti);
      jarvis.atualizaLife(28);
    }
    if(nAti.life<=0) {
      removerNpcAtirador.add(nAti);
      jarvis.atualizaCoin(35);
    }
  }
  
  for(Meteoro met: meteoros){
    met.movimente();
    met.desenhe();
    met.showLife();
    if(jarvis.verificaColisao(met)){
      removerMeteoro.add(met);
      jarvis.atualizaLife(50);
    }   
    if(met.life<=0) {
      removerMeteoro.add(met);
      jarvis.atualizaCoin(50);
    }
  }
  
  meteoros.removeAll(removerMeteoro);
  npcs.removeAll(remover);
  npcsAtiradores.removeAll(removerNpcAtirador);
  }
  jarvis.movimente();
    jarvis.desenhe(); 
  jarvis.showExtra();
}

void faseUm(){ 
  if(jarvis.score>=metaLvl){
    if(isBoss) {
      tauros = new Tauros(imJog5,width/2.5,-250,'a','d',64,64,2,100,15);
      isBoss=false;      
      joiaAlma = new Joias(imJog6,tauros.x,height/4,64,64,1);
    }else{
      tauros.movimente();
      tauros.desenhe();     
      if(tauros.life<=0){
        tauros.quadro=4;
        joiaAlma.movimente();
        joiaAlma.desenhe();     
        if(joiaAlma.verificaColisao(jarvis)){
          if(tauros.y<=-64) {
            jarvis.joia++;
            lvl=2;
            metaLvl=350;
            estado=2;
            joiasTotais+=jarvis.joia;
         }
        }
      }else if(tauros.y>=height/4){
        jarvis.atirar();
        tauros.atirar();
      }
    }
  }else{
  ArrayList<Npc> remover = new ArrayList<Npc>();
  if(npcTimer.disparou()){
    npcs.add(new Npc(imJog2,random(0, width-64),-64,'j','k',64,64));
  }
  
  ArrayList<NpcAtirador> removerNpcAtirador = new ArrayList<NpcAtirador>();
  if(npcAtiradorTimer.disparou()){
    npcsAtiradores.add(new NpcAtirador(imJog4,random(0, width-64),-64,'j','k',64,64,5));
  }
  
  ArrayList<Meteoro> removerMeteoro = new ArrayList<Meteoro>();
  if(meteoroTimer.disparou()){
    meteoros.add(new Meteoro(imJog3,random(0, width-64),-45,'j','k',45,45));
  }
  jarvis.atirar();
  jarvis.atualizaScore(5);
  
  for(Npc n: npcs){
    n.movimente();
    n.desenhe();
    n.showLife();
    if(jarvis.verificaColisao(n)){
      remover.add(n);
      jarvis.atualizaLife(15);
    }//
    if(n.life<=0) {
      remover.add(n);
      jarvis.atualizaCoin(25);
    }
    if(n.y>height){
      jarvis.navesPerdidas++;
      remover.add(n);
      jarvis.verificaNavesPerdidas();
    }
  }
  for(NpcAtirador nAti: npcsAtiradores){
    nAti.movimente();
    nAti.desenhe();
    nAti.atirar();
    nAti.showLife();
    if(jarvis.verificaColisao(nAti)){
      removerNpcAtirador.add(nAti);
      jarvis.atualizaLife(25);
    }
    if(nAti.life<=0) {
      removerNpcAtirador.add(nAti);
      jarvis.atualizaCoin(35);
    }
  }
  
  for(Meteoro met: meteoros){
    met.movimente();
    met.desenhe();
    met.showLife();
    if(jarvis.verificaColisao(met)){
      removerMeteoro.add(met);
      jarvis.atualizaLife(50);
    }   
    if(met.life<=0) {
      removerMeteoro.add(met);
      jarvis.atualizaCoin(50);
    }
  }
  
  meteoros.removeAll(removerMeteoro);
  npcs.removeAll(remover);
  npcsAtiradores.removeAll(removerNpcAtirador);
  }
  jarvis.movimente();
    jarvis.desenhe(); 
  jarvis.showExtra();
}


//Função do Menu
void menu()
{
  background(0);
  
  textSize(75);
  fill(255,10,0);
  text("Jarvis", width/2, height/10);
  textSize(38);
  fill(255,255,0);
  text("em busca das Joias", width/2, height/4.5);
  
  textSize(32);
  fill(255); 
  text("Coin: " + coinTotal, width/2, height/1.3);
  text("Highscore: " + highScore, width/2, height/1.2);
  botComecar.desenhe();
  botSair.desenhe();
}

void reset(){
  jarvis.life=100;
  jarvis.barLife=width;
  jarvis.colorLife=255;
  jarvis.coin=0;
  jarvis.score=0;
  jarvis.navesPerdidas=0;
  jarvis.joia=0;
  isBoss=true;
  ArrayList<Meteoro> removerMeteoro = new ArrayList<Meteoro>();
  for(Meteoro met : meteoros){
    removerMeteoro.add(met);
  }
  meteoros.removeAll(removerMeteoro);
  ArrayList<Npc> removerNpc = new ArrayList<Npc>();
  for(Npc n : npcs){
    removerNpc.add(n);
  }
  npcs.removeAll(removerNpc);
  ArrayList<NpcAtirador> removerNpcAtirador = new ArrayList<NpcAtirador>();
  for(NpcAtirador nAti : npcsAtiradores){
    removerNpcAtirador.add(nAti);
  }
  npcsAtiradores.removeAll(removerNpcAtirador);
}

void fundo()
{
  ArrayList<Cenario> removerEstrelas = new ArrayList<Cenario>();
  if(cenarioTimer.disparou()){
    cenario.add(new Cenario(random(0, width),0,width/100));
  }
    
  background(0);
  
  for(Cenario estrelas : cenario){    
    estrelas.desenhe();
    if(estrelas.y>=height) removerEstrelas.add(estrelas);
  } 
  
  cenario.removeAll(removerEstrelas);
}

void mousePressed(){
  if(estado==0){
    if(botSair.clicado()) botSair.destaque();
    if(botComecar.clicado()) botComecar.destaque();
  }
  if(estado==2){
    if(botSair.clicado()) botSair.destaque();
    if(botReiniciar.clicado()) botReiniciar.destaque();
    if(botProximo.clicado()) botProximo.destaque();
  }
  if(estado==3){
    if(botSair.clicado()) botSair.destaque();
    if(botVoltar.clicado()) botVoltar.destaque();
  }
}

void mouseReleased(){
  
    if(estado==0){
      if(botSair.clicado()) exit();
      if(botComecar.clicado()){
        startTimer = new Timer(3500);
        estado=1;
        cenarioTimer = new Timer(25);
      }
        
      botSair.removeDestaque();
      botComecar.removeDestaque();
    }
    if(estado==2){
      if(botSair.clicado()) {
        jogoEmAndamento=false;
        reset();
        estado=0;
        ArrayList<Cenario> removerEstrelas = new ArrayList<Cenario>();
        for(Cenario estrelas : cenario){
          removerEstrelas.add(estrelas);
        }
        cenario.removeAll(removerEstrelas);
      }
      if(botReiniciar.clicado()) {
        jogoEmAndamento=false;
        reset();
        estado=1;
      }
      if(botProximo.clicado()) {
        jogoEmAndamento=false;
        reset();
        estado=1;
      }
        
      botSair.removeDestaque();
      botReiniciar.removeDestaque();
      botProximo.removeDestaque();
    }
    if(estado==3){
      if(botSair.clicado()) {
        jogoEmAndamento=false;
        reset();
        estado=0;
        ArrayList<Cenario> removerEstrelas = new ArrayList<Cenario>();
        for(Cenario estrelas : cenario){
          removerEstrelas.add(estrelas);
        }
        cenario.removeAll(removerEstrelas);
      }
      if(botVoltar.clicado()) estado=1;
        
      botSair.removeDestaque();
      botVoltar.removeDestaque();
    }
}

void menuConclusao(){
  background(0);
  textSize(32);
  
  fill(255);
  text("Você morreu!", width/2, height/4);
  text("Você coletou " + jarvis.coin + " coins", width/2,height/3);
  text("Você fez " + jarvis.score + " pontos", width/2,height/2.4);
  botReiniciar.desenhe();
  botSair.desenhe();
}

void menuConclusaoVencedor(){
  background(0);
  textSize(32);
  
  fill(255);
  text("Você ganhou!", width/2, height/4);
  text("Você coletou " + jarvis.coin + " coins", width/2,height/3);
  text("Você fez " + jarvis.score + " pontos", width/2,height/2.4);
  botProximo.desenhe();
  botSair.desenhe();
}

void pausa(){
  background(0);
  textSize(32);
  
  fill(255);
  botVoltar.desenhe();
  botSair.desenhe();
}

void draw()
{  
  switch(estado){
   case 0:
     menu();
     break;
   case 1:
     fundo();
     if(startTimer.disparou() && !jogoEmAndamento){
       npcTimer = new Timer(2000);
       npcAtiradorTimer = new Timer(4000);
       meteoroTimer = new Timer(12000);
       jogoEmAndamento=true;
     }
     if(jogoEmAndamento) {
       if(lvl==1) faseUm();
       if(lvl==2) faseDois();
       if(lvl==3) faseUm();
       if(lvl==4) faseUm();
       if(lvl==5) faseUm();
       if(lvl==6) faseUm();
     }
     else{
       background(200,40,0);
       text("Carregando...", width/2, height/2);
     }
     break;
   case 2:
     if(jarvis.joia==0) menuConclusao();
     else {
       menuConclusaoVencedor();
     }
     break;
   case 3:
     pausa();
     break;
  }
}
