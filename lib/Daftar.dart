import 'package:flutter/material.dart';
import 'database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';

void main() => runApp(const Daftar());

class Daftar extends StatelessWidget {
  const Daftar({Key? key}) : super(key: key);

  static const String _title = '----- PENDAFTARAN SIMAS -----';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nikController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  kembaliLogin(){
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => MyApp(),),);
  }
  prosesDaftar(){
    var db = new Mysql();
    var nik=nikController.text;
    var username=usernameController.text;
    var password=passwordController.text;

    db.getConnection().then((conn) async {

      String sql = "INSERT INTO user (nik, username, password) VALUES ('$nik', '$username', '$password')";
      // print(sql);
      var result = await conn.query(sql);
      Fluttertoast.showToast(
          msg: "Daftar Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyApp(),),);

      conn.close();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'SIMAS',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sistem Informasi Manajemen Arsip  Surat',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nikController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NIK',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),

            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text('Daftar'),
                  onPressed: prosesDaftar,
                )
            ),

            Row(
              children: <Widget>[
                const Text('Sudah puya akun ?'),
                TextButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: kembaliLogin,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),

          ],
        )
    );

  }
}