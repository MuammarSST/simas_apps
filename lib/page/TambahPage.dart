import 'package:simas/model/UserModel.dart';
import 'package:simas/database/Database.dart';

Future<void> _Update_Data(String id, String username, String password) async {
  final db = Mysql();
  final int IdUser = int.parse(id.toString());

  await db.getConnection().then(
        (conn) async {
      await conn.query(
          'Update users set username =? , password =?  where IdUser =?',
          [username, password, IdUser]);

      await conn.close();
    },
  );

}

