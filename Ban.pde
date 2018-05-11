public class Ban {
  // -- posição
  PImage icon;
  float x, y, vel;
  float diam = 20;
  int tipo = 0;
  int id = 0;

  // -- velocidade
  float myvy;

  Ban(float px, float py, float vel, boolean in_bd) {
    // -- posição da bala
    if (in_bd) {
      icon = loadImage("Rootkit.png");
      tipo = 666;
      id = inimigos.get(0);
      inimigos.remove(0);
      diam = 128;
    } else {
      tipo = (int(random(0, bits + 2)));
      if (tipo >= 75 && tipo <= 95) {
        icon = loadImage("bug.png");
        tipo = 1;
      } else if (tipo >= 100 && tipo <= 125) {
        tipo = 2;
        icon = loadImage("Ransomware.png");
      } else if (tipo >= 150 && tipo <= 170) {
        tipo = 3;
        icon = loadImage("Virus.png");
      } else {
        icon = loadImage("bitcoin.png");
        tipo = 0;
      }
    }

    this.vel = vel;
    x = px;
    y = py;

  }

  void moveBala() {
    y += ((log(calc_bits) / log(4)));
    if (tipo != 666) {
      image(icon, x, y, 32, 32);
    } else {
      image(icon, x, y, 128, 128);
    }
    if (x > width || x < 0 || y > height || y < 0) {
      eliminaBala();
    }
  }
  
  void eliminaBala() {
    removeBala(this);
  }

  void removeBala(Ban obj) {
    asBalas.remove(obj);
    obj = null;
  }
  
}