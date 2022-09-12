import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'database.dart';
import 'dashboard.dart';
import 'Daftar.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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


  prosesDaftar(){
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => Daftar(),),);
  }

  prosesLogin() {
    var nik=nikController.text;
    var password=passwordController.text;


    db.getConnection().then((conn) {
      String sql = "select * from user where nik ='$nik' and password = '$password'";
      // print(sql);
      conn.query(sql).then((results) {

        for(var row in results){

          setState(() {

            print(row[1]);
            print(row[3]);
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
              context, MaterialPageRoute(builder: (context) => DashBoard(),),);


          });
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
                  onPressed: prosesDaftar,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),

          ],
        ));
  }
}