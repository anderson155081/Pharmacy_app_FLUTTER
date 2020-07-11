import 'package:flutter/material.dart';
import 'package:pharmacy/helper/authenticate.dart';
import 'package:pharmacy/helper/helperfunctions.dart';
import 'package:pharmacy/views/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn ;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color.fromRGBO(143, 148, 251, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null ? /**/ userIsLoggedIn ? FirstPage() :
      Authenticate() /**/ : Authenticate()
    );
  }
}