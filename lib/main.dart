import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simas/database/Database.dart';
import 'Dashboard.dart';
import 'page/DaftarPage.dart';

import 'package:flutter_session_manager/flutter_session_manager.dart';
var sessionManager = SessionManager();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dynamic token= await sessionManager.get("token");
  runApp(MaterialApp(home: token == null ? Login() : Dashboard(),));
}


class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = '----- LOGIN SIMAS -----';

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
  TextEditingController passwordController = TextEditingController();

  var db = new Mysql();


  kembaliDaftar(){
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => Daftar(),),);
  }

  prosesLogin(){
    var nik=nikController.text;
    var password=passwordController.text;

    if(nik.isEmpty){
      Fluttertoast.showToast(
          msg: "Masukan NIK",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
    if(password.isEmpty){
      Fluttertoast.showToast(
          msg: "Masukan Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }


      db.getConnection().then((conn) {
        String sql = "select * from user where nik ='$nik' and password = md5('$password')";
        conn.query(sql).then((results) async {
          if(results.isEmpty){
            print('gagal login');
            Fluttertoast.showToast(
                msg: "NIK dan Password Salah",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          for(var row in results){
            print(row);

            await sessionManager.set("token", "$row[nik]");

            Fluttertoast.showToast(
                msg: "Login Berhasil",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dashboard(),),);
          }




        });
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
                  child: const Text('Login'),
                  onPressed: prosesLogin,
                )
            ),

            Row(
              children: <Widget>[
                const Text('Belum puya akun ?'),
                TextButton(
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: kembaliDaftar,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),

          ],
        ));
  }
}