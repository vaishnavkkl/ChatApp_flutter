
import 'package:dotchat/model/helper.dart';
import 'package:dotchat/screens/chatrooom.dart';
import 'package:dotchat/screens/welcomeScreen.dart';
import 'package:flutter/material.dart';

import 'model/authenticate.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userisLoggedIn=false;
  @override
  void initState() {
 getLoggedInState();
    super.initState();
  }
  getLoggedInState()async{
    await HelperFunction.getloggedinsharedpreference().then((value){
      setState(() {
        userisLoggedIn=value;
      });

    });
  }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:Colors.blueGrey,//Color(0xff145C9E),
        scaffoldBackgroundColor:Colors.blueAccent,
        primarySwatch: Colors.blue,

      ),
      home: userisLoggedIn? ChatRoom():Authenticate(),
    );
  }
}
class Blank extends StatefulWidget {
  @override
  _BlankState createState() => _BlankState();
}

class _BlankState extends State<Blank> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
