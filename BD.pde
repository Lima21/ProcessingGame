import de.bezier.data.sql.*;
MySQL dbconnection;
MySQL dbconnection2;
ArrayList < Integer > bdpontos = new ArrayList < Integer > ();
ArrayList < Integer > bduser = new ArrayList < Integer > ();
ArrayList < Integer > inimigos = new ArrayList < Integer > ();

void setupBD() {
    String user = "root";
    String pass = "";
    String dbHost = "localhost";
    String database = "processing";
    dbconnection = new MySQL(this, dbHost, database, user, pass);
    dbconnection2 = new MySQL(this, dbHost, database, user, pass);
}

void setVirus(int id) {
    if (dbconnection.connect()) {
        dbconnection.query("UPDATE hack set estado = 1 where id = " + id + ";");
    } else {
        println("FAIL");
    }
}

void sendVirus(int num) {
    int num2 = 0;
    if (dbconnection.connect()) {
        dbconnection.query("SELECT name FROM user order by pontos DESC");
        while (dbconnection.next()) {
            while (num > num2) {
                if (dbconnection.getInt("name") != nome) {
                    dbconnection2.query("INSERT INTO `hack` (`atirador`, `alvo`, `estado`) VALUES (' " + nome + " ', '" + dbconnection.getInt("name") + "', '1');");
                }
                num2++;
            }
        }
    } else {
        println("FAIL");
    }
}



void receber() {
    if (dbconnection.connect()) {
        dbconnection.query("SELECT bits, id FROM hack WHERE atirador =" + nome + " and estado = 3;");
        while (dbconnection.next()) {
            total_bits += dbconnection.getInt("bits");
            println(dbconnection.getInt("bits"));
            println("var receber");
            dbconnection.query("UPDATE hack set estado = 4 where id = " + dbconnection.getInt("id") + ";");
        }

    } else {
        println("FAIL");
    }
}


void atualizaBD(int id) {

    if (dbconnection.connect()) {
        dbconnection.query("UPDATE hack set estado = 3 where id = " + id + ";");
        float valor = total_bits * 0.1;
        int valor2 = (int) valor;
        total_bits -= valor2;
        dbconnection.query("UPDATE hack set bits =  " + valor2 + "   where id = " + id + ";");
    } else {
        println("FAIL");
    }
}

void alvo() {
    if (dbconnection.connect() && dbconnection2.connect()) {
        dbconnection.query("SELECT id FROM hack WHERE alvo =" + nome + " and estado = 1 order by id;");
        while (dbconnection.next()) {
            inimigos.add(dbconnection.getInt("id"));
            dbconnection2.query("UPDATE hack set estado = 2 where id = " + dbconnection.getInt("id") + ";");
            println("var haver inimigo");
        }

    } else {
        println("FAIL");
    }
}

void inserirUsers() {
    if (dbconnection.connect()) {
        dbconnection.query("INSERT INTO USER VALUES(" + nome + ",  0);");
    } else {
        println("FAIL");
    }
}


void inserirValor() {
    if (dbconnection.connect()) {
        dbconnection.query("UPDATE user set pontos = " + total_bits + " where name = " + nome + ";");

    } else {
        println("FAIL");
    }
}


void ranking() {
    if (dbconnection.connect()) {
        dbconnection.query("SELECT * FROM user order by pontos DESC");
        while (dbconnection.next()) {
            bdpontos.add(dbconnection.getInt("pontos"));
            bduser.add(dbconnection.getInt("name"));
        }

    } else {
        println("FAIL");
    }
}