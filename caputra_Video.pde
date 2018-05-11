import processing.video.*;
color procuraCor;
PShape pinguim;
PImage computer;
PImage imgBack;
PImage back;
boolean salto = false;
boolean emsalto = false;
int cam_width = 320;
int cam_height = 240;
Capture video;
int bits = 0;
int calc_bits = 0;
long lastTime;
long lastTime_BD = 10000;
float value;

int pos2X = 0;
int pos2Y = 200;

int vidas = 0;


int tri_time = 0;
boolean bug = false;
int bug_time = 0;
boolean block = false;
int block_time = 0;
boolean virus = false;
int virus_time = 0;

import processing.sound.*;
AudioIn inputAudio;
Amplitude aAmplitude;

void loopVideo() {

  if (menu == 1) {

    image(imgBack, 0, 240);
  }
  // -- captura e mostra o vídeo
  if (video.available()) {
    video.read();
  }
  video.loadPixels();
  image(video, 0, 0);
  image(back, 0, 0);


  // -- começa com um valor elevado que não existe
  float valorInicialCor = 500;

  // - coordenadas da cor mais próxima do pixel em análise
  int corProximaX = 0;
  int corProximaY = 0;

  // -- percorre todos os pixéis da imagem
  for (int x = 0; x < 320; x++) {
    for (int y = 0; y < 240; y++) {

      int loc = x + y * 320;

      // -- qual a cor do pixel atual
      color corAtual = video.pixels[loc];

      float r1 = red(corAtual);
      float g1 = green(corAtual);
      float b1 = blue(corAtual);

      float r2 = red(procuraCor);
      float g2 = green(procuraCor);
      float b2 = blue(procuraCor);

      // -- compara a distância entre as cores (distância euclideana) para compará-las
      float distancia = dist(r1, g1, b1, r2, g2, b2);

      // -- se a cor atual é mais similar à cor a procurar, gravar a localização e a diferença atual
      if (distancia < valorInicialCor) {
        valorInicialCor = distancia;
        corProximaX = x;
        corProximaY = y;
      }
    }
  }



  if (valorInicialCor < 100) {
    // -- desenha um círculo no píxel atual
    fill(procuraCor);
    strokeWeight(4.0);
    stroke(0);
    ellipse(corProximaX, corProximaY, 16, 16);
  }

  if (menu != 1) {
    moveCursor(corProximaX, corProximaY);
  } else if (menu == 1) {
    movePlayer(corProximaX);

  }
}



void movePlayer(int corProximaX) {
  if (!bug) {
    corProximaX = 320 - corProximaX;
  }

  if (corProximaX > (pos2X + 5)) {
    if (block)
      pos2X = pos2X + 1;
    else
      pos2X = pos2X + 2;
  } else if (corProximaX < (pos2X - 5)) {
    if (block)
      pos2X = pos2X - 1;
    else
      pos2X = pos2X - 2;
  }

  float volume = aAmplitude.analyze();
  float limite = 0.2;
  float limiteMax = 0.5;
  if (volume > limite && volume < limiteMax && !salto) {
    salto = true;
    emsalto = true;
  }

  if (volume > limiteMax || vidas >= 5) {
    pos2X = 300;
    pos2Y = 300;
    total_bits += bits;
    bits = 0;
    somFundo.close();
    menu = 0;
    somFundo.rewind();
  }

  if (salto) {
    if (pos2Y > 600) {
      pos2Y = pos2Y - 5;
    } else if (pos2Y <= 600) {
      salto = false;
    }
  } else if (pos2Y < 650) {
    pos2Y = pos2Y + 5;
  }

  if (asBalas.size() > 0) {
    for (int i = 0; i < asBalas.size(); i++) {
      Ban abala = asBalas.get(i);
      abala.moveBala();
    }
  }

  if (millis() - lastTime > value) {
    calc_bits = bits + 500;
    value = 1 / (log(calc_bits) / log(2));
    value *= 3500;
    value -= (log(calc_bits));
    Ban b = new Ban(int(random(0, 960)), 240, 50, false);
    asBalas.add(b);
    lastTime = millis();

  }

  if (millis() - lastTime_BD > 10000) {
    if (inimigos.size() > 0) {
      Ban b = new Ban(int(random(0, 960)), 240, 50, true);
      asBalas.add(b);
    }

    lastTime_BD = millis();
  }

  if (millis() - tri_time >= 1000) {
    tri_time = millis();
    if (block) {
      block_time--;
    }

    if (bug) {
      bug_time--;
    }

    if (virus) {
      virus_time--;
      salto = true;
    }

    if (block_time <= 0) {
      block = false;
      block_time = 0;
    }

    if (bug_time <= 0) {
      bug = false;
      bug_time = 0;
    }

    if (virus_time <= 0) {
      virus = false;
      virus_time = 0;
    }

  }

  if (asBalas.size() > 0) {
    for (int k = 0; k < asBalas.size(); k++) {
      Ban abala = asBalas.get(k);
      if (circuloCirculo(pos2X * 3, pos2Y, 50, abala.x, abala.y, abala.diam)) {
        if (abala.tipo == 0) {
          somColisaoBala.play(0);
          bits += 10;
        } else if (abala.tipo == 1) {
          somColisaoVirus.play(0);
          bug = true;
          bug_time += 20;
          vidas++;
        } else if (abala.tipo == 2) {
          somColisaoVirus.play(0);
          block = true;
          block_time += 20;
          vidas++;
        } else if (abala.tipo == 3) {
          somColisaoVirus.play(0);
          virus = true;
          virus_time += 20;
          vidas++;
        } else if (abala.tipo == 666) {
          somColisaoCatch.play(0);
          atualizaBD(abala.id);
          vidas++;
        }
        abala.eliminaBala();
        break;
      }
    }
  }
  image(computer, pos2X * 3, pos2Y, 50, 50);
}


void moveCursor(int corProximaX, int corProximaY) {

  corProximaX = 320 - corProximaX;
  if (corProximaX > (pos2X + 5)) {
    pos2X = pos2X + 2;
  } else if (corProximaX < (pos2X - 5)) {
    pos2X = pos2X - 2;
  }

  if (corProximaY > (pos2Y + 5)) {
    pos2Y = pos2Y + 2;
  } else if (corProximaY < (pos2Y - 5)) {
    pos2Y = pos2Y - 2;
  }

  image(computer, pos2X * 3, (pos2Y * 2) + 240);
}


void iniciaVideo() {
  video = new Capture(this, cam_width, cam_height, 30);
  video.start();
  // -- começa a "ouvir" o microfone
  // -- cria um objeto de input de áudio e captura o primeiro canal de áudio
  inputAudio = new AudioIn(this, 0);

  // -- inicia o input de áudio
  inputAudio.start();

  // -- cria um objeto para analisar a amplitude do áudio
  aAmplitude = new Amplitude(this);

  // -- passa o imput para o "analyzer" de volume
  aAmplitude.input(inputAudio);

}