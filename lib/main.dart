import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:simas/main.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SIMAS'),),
        resizeToAvoidBottomInset:false,
        body: SafeArea(
          child:MyApp(),
        ),
      ),
    )
  );
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState()=> _MyAppState();

}

class _MyAppState extends State<MyApp>{
  bool signin=true;
  TextEditingController namectrl,emailctrl,passctrl;
  bool processing=false;

  @override
  void initState(){
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[Icon(Icons.account_circle,size: 200,color: Colors.blue,),
        boxUi(),
        ],
      )
    );
  }
  void registerUser() async{
    setState(() {
      processing =true;
    });

    var url ="http://127.0.0.1/simas/login.php";
    var data ={
      "email":emailctrl.text,
      "name":namectrl.text,
      "pass":passctrl.text,
    };

    var res = await http.post(Uri,body:data);

    if(jsonDecode(res.body)=="account already exists"){
      Fluttertoast(msg:"account exits, Please Login",toastLength:Toast.LENGTH_SHORT)
    }


  }
  Widget boxUi(){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
    );
  }
}