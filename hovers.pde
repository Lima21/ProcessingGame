void verificaPosBuy() {
  int cursorX = pos2X * 3;
  int cursorY = pos2Y * 2 + 240;


  if (cursorY > 240 && cursorY < 620) {
    if (cursorX > 0 && cursorX < 320) {
      pc1 = color(255, 0, 0);
      float volume = aAmplitude.analyze();
      float limite = 0.5;
      if (volume > limite && total_bits > 99) {
        sendVirus(1);
        total_bits -= 100;
        menu = 0;

      }

    } else {
      pc1 = 30;
    }

    if (cursorX > 320 && cursorX < 640) {
      pc2 = color(255, 0, 0);
      float volume = aAmplitude.analyze();
      float limite = 0.5;
      if (volume > limite && total_bits > 199) {
        sendVirus(2);
        total_bits -= 200;
        menu = 0;
      }
    } else {
      pc2 = 70;
    }

    if (cursorX > 640 && cursorX < 960) {
      pc3 = color(255, 0, 0);
      float volume = aAmplitude.analyze();
      float limite = 0.5;
      if (volume > limite && total_bits > 299) {
        sendVirus(3);
        total_bits -= 300;
        menu = 0;
      }
    } else {
      pc3 = 110;
    }

  } else {
    float limite = 0.5;
    float volume = aAmplitude.analyze();
    if (volume > limite) {
      menu = 0;
    }
  }
}























void verificaPos() {
  int cursorX = pos2X * 3;
  int cursorY = pos2Y * 2 + 240;
  if (cursorX > 230 && cursorX < 730) {

    if (cursorY > 300 && cursorY < 370) {
      cor1 = color(0, 0, 0);
      float volume = aAmplitude.analyze();
      float limite = 0.2;
      if (volume > limite) {
        text("1", 300, 300);
        menu = 1;
      }

    } else {
      cor1 = color(255, 255, 255);
    }

    if (cursorY > 400 && cursorY < 470) {
      cor2 = color(0, 0, 0);
      float volume = aAmplitude.analyze();
      float limite = 0.2;
      if (volume > limite) {
        menu = 2;
      }
    } else {
      cor2 = color(255, 255, 255);
    }

    if (cursorY > 500 && cursorY < 570) {
      cor3 = color(0, 0, 0);
      float volume = aAmplitude.analyze();
      float limite = 0.2;
      if (volume > limite) {
        text("3", 300, 300);
      }
    } else {
      cor3 = color(255, 255, 255);
    }

  } else {
    int cor1 = color(255, 255, 255);
    int cor2 = color(255, 255, 255);
    int cor3 = color(255, 255, 255);
  }
}