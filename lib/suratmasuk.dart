// import 'package:flutter/material.dart';
// import 'package:simas/UserModel.dart';
// import 'database.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_session_manager/flutter_session_manager.dart';
// var sessionManager = SessionManager();
//
// class Dashboard extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dashboard"),
//       ),
//       body: Center(
//         child: showFutureDBData(),
//
//
//
//       ),
//       floatingActionButton: FloatingActionButton(
//
//         onPressed: tambah,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
//
// showFutureDBData() {
//   return FutureBuilder<List<UserModel>>(
//     future: getmySQLData(),
//     builder: (BuildContext context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const CircularProgressIndicator();
//       } else if (snapshot.hasError) {
//         return Text(snapshot.error.toString());
//       }
//
//       return ListView.builder(
//
//         itemCount: snapshot.data!.length,
//         itemBuilder: (context, index) {
//           final user = snapshot.data![index];
//           return ListTile(
//               trailing: TextButton(
//                 onPressed: edit,
//                 child: const Icon(Icons.edit),
//               ),
//             leading: Text(user.IdUser),
//             title: Text(user.nik),
//             subtitle: Text(user.username),
//
//           );
//
//         },
//       );
//     },
//   );
// }
//
// Future<List<UserModel>> getmySQLData() async {
//   var db = Mysql();
//   String sql = 'select * from user;';
//   final List<UserModel> mylist = [];
//   await db.getConnection().then((conn) async {
//     await conn.query(sql).then((results) {
//       for (var res in results) {
//         final UserModel myuser = UserModel(
//             IdUser: res['IdUser'].toString(),
//             nik: res['nik'].toString(),
//             username: res['username'].toString(),
//             password: res['password'].toString());
//         mylist.add(myuser);
//
//       }
//
//     }).onError((error, stackTrace) {
//       print(error);
//       return null;
//
//     });
//     conn.close();
//   });
//   return mylist;
// }
//
// edit() async {
//
//
// }
// tambah(){
//
// }
// Future logOut(BuildContext context)async{
//   Fluttertoast.showToast(
//       msg: "Logout Successful",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.amber,
//       textColor: Colors.white,
//       fontSize: 16.0
//   );
//   Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(),),);
// }
//
