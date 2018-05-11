int rect_width = 500;
int rect_height = 70;
int cor1 = color(255, 255, 255);
int cor2 = color(255, 255, 255);
int cor3 = color(255, 255, 255);
int pc1 = 30;
int pc2 = 70;
int pc3 = 110;

void iniciaJanelas() {
  background(178);
  textSize(25);
  noStroke();
  int rect_margin = (width - rect_width) / 2;
  fill(cor1);
  rect(rect_margin, 300, rect_width, rect_height, 10);
  fill(255, 0, 0);
  text("Iniciar Jogo", 410, 350);
  fill(cor2);
  rect(rect_margin, 400, rect_width, rect_height, 10);
  fill(255, 0, 0);
  text("Loja", 410, 450);
  fill(cor3);
  rect(rect_margin, 500, rect_width, rect_height, 10);
  fill(255, 0, 0);
  text("Sair Jogo", 410, 540);
  fill(255);
  text("Ranking: ", 320, 30);
  for (int i = 0; i < bdpontos.size(); i++) {
    text(bduser.get(i) + " - " + bdpontos.get(i), 320, 60 + (30 * i));
  }
}

void janelasGame() {
  fill(255);
  text("Bitcoins: " + bits, 320, 40);
  text("Ban: " + asBalas.size(), 320, 70);
  text("Bug: " + bug_time, 320, 100);
  text("Blcok: " + block_time, 320, 130);
  text("Virus: " + virus_time, 320, 160);
  text("Vidas: " + (5 - vidas), 320, 190);
}


void janelasBuy() {
  noStroke();
  text("Total Bits: " + total_bits, 320, 170);
  fill(pc1);
  rect(10, 240, 320, 380);
  fill(pc2);
  rect(320, 240, 640, 380);
  fill(pc3);
  rect(640, 240, 960, 380);
  fill(255);

  text("1 Hack", 100, 400);
  text("100 Bitcoins", 75, 430);

  text("3 Hack", 425, 400);
  text("200 Bitcoins", 400, 430);

  text("6 Hack", 750, 400);
  text("300 Bitcoins", 725, 430);
}