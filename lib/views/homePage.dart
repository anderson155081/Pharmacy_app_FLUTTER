import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Animation/FadeAnimation.dart';
import 'package:pharmacy/Services/auth.dart';
import 'package:pharmacy/helper/authenticate.dart';
import 'package:pharmacy/helper/constants.dart';
import 'package:pharmacy/helper/helperfunctions.dart';
import 'package:pharmacy/views/sendmessagetopharmacy.dart';
import 'package:pharmacy/widgets/widget.dart';


class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  AuthMethods authMethods = new AuthMethods();
//  @override
//  void initState() {
//    getUserInfo();
//    super.initState();
//  }
//
//  getUserInfo() async{
//    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Container(
            child: Row(
              children: <Widget>[
                SizedBox(width: 115,),
                Image.asset("assets/images/title.png", height: 60,),
              ],
            )
        ),
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authenticate()
              ));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.exit_to_app,color: Colors.white,)),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: <Widget>[
            FadeAnimation(1.3,Container(
              height: 300,
              child: Image(image: AssetImage('assets/images/doctor.png'),),
            ),),
            Container(
              padding: EdgeInsets.only(left: 40,top: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Button(),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    child: ImageButton(),
                  )
                ],
              ),
            ),
            FadeAnimation(1.5,Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Image(
                height: 100,
                image: AssetImage("assets/images/undraw_medical_care_movn.png"),
              ),
            ),
            ),
          ]
        )
        ),
      );
  }
}



