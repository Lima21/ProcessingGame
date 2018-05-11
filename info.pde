void lerInfo() {
  String[] lines = loadStrings("data2.lima");
  if (lines != null) {
    println("there are " + lines.length + " lines");
    for (int i = 0; i < lines.length; i++) {
      nome = Integer.valueOf(lines[0]);
      println(lines[0]);
      total_bits = Integer.valueOf(lines[1]);
    }
  } else {
    criarInfo();
  }
}

void criarInfo() {
  nome = (int)(random(0, 10000000));
  println(nome);
  inserirUsers();
}