String[] info = new String[2];
int nome;
int total_bits;
ArrayList < Ban > asBalas = new ArrayList < Ban > ();
int menu = 1;

import ddf.minim.*;
Minim minim, minim2, minim3, minim4;
AudioPlayer somFundo, somColisaoBala, somColisaoVirus, somColisaoCatch;

int teste = 0;

void setup() {
  size(960, 720);

  // -- Carrega o som de fundo;
  minim = new Minim(this);
  somFundo = minim.loadFile("RHB.mp3");

  minim2 = new Minim(this);
  somColisaoBala = minim.loadFile("coin.mp3");

  minim3 = new Minim(this);
  somColisaoVirus = minim.loadFile("OUCH.WAV");

  minim4 = new Minim(this);
  somColisaoCatch = minim.loadFile("catch.mp3");

  setupBD();
  lerInfo();
  ranking();
  alvo();
  receber();
  iniciaVideo();
  iniciaJanelas();
  back = loadImage("back.png");
  imgBack = loadImage("imgBack.png");
  computer = loadImage("computer.png");
  procuraCor = color(255, 0, 0);
  smooth();
  prepareExitHandler();
}

void draw() {
  switch (menu) {
    case 0:
      vidas = 0;
      iniciaJanelas();
      loopVideo();
      verificaPos();
      break;
    case 1:
      somFundo.play();
      loopVideo();
      janelasGame();
      break;
    case 2:
      background(123);
      loopVideo();
      janelasBuy();
      verificaPosBuy();
      break;
  }
}

private void prepareExitHandler() {
  Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
    public void run() {
      for (int i = 0; i < inimigos.size(); i++) {

        setVirus(inimigos.get(i));
      }
      
      info[0] = String.valueOf(nome);
      total_bits += bits;
      info[1] = String.valueOf(total_bits);
      inserirValor();
      saveStrings("data2.lima", info);
    }
  }));
}

// -- espera pelo click na cor que se pretende que seja para seguir
void mousePressed() {
  int loc = mouseX + mouseY * 320;
  // println(mouseX + "   "  + mouseY);
  procuraCor = video.pixels[loc];
}