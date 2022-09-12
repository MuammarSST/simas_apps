import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = 'sql6.freemysqlhosting.net',
      user = 'sql6518829',
      password = 'dGldCLBzis',
      db = 'sql6518829';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: db
    );
    return await MySqlConnection.connect(settings);
  }
}