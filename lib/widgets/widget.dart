import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Animation/FadeAnimation.dart';
import 'package:pharmacy/Services/database.dart';
import 'package:pharmacy/helper/constants.dart';
import 'package:pharmacy/helper/helperfunctions.dart';
import 'package:pharmacy/views/chatroom.dart';
import 'package:pharmacy/views/searchmedicine.dart';
import 'package:pharmacy/views/sendmessagetopharmacy.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Container(
        child: Row(
          children: <Widget>[
            SizedBox(width: 60,),
            Image.asset("assets/images/title.png", height: 60,),
          ],
        )),
    backgroundColor: Color.fromRGBO(143, 148, 251, 1),
    elevation: 0.0,
  );
}




TextStyle signInTextStyleBold(){
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black
  );
}
TextStyle mediumTextStyle(){
  return TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

TextStyle signInTextStyle(){
  return TextStyle(
    fontSize: 18,
  );
}

TextStyle signUpTextStyle(){
  return TextStyle(
    fontSize: 14,
  );
}
class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {

  goToChatRoom(){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => SendMessageToPharmacy()));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 160,
      child: FadeAnimation(1.5,RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed:(){
          goToChatRoom();
        },
        color: Color.fromRGBO(143, 148, 251, 1),
        textColor: Colors.black,
        child: Column(
          children: <Widget>[
            SizedBox(height: 5,),
            Icon(Icons.question_answer, size: 120,color: Colors.white,),
            Text('詢問藥師',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17
            ),),
          ],
        ),
      ),),
    );
  }
}
class ImageButton extends StatefulWidget {
  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {

  goToSearch(){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => SearchMedicine(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        height: 160,
        child: FadeAnimation(1.5,RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed:() {
            goToSearch();
          },
          color: Color.fromRGBO(143, 148, 251, 1),
          textColor: Colors.black,
          child: Column(
            children: <Widget>[
              SizedBox(height: 5,),
              Image.asset('assets/images/capsules.png',height: 120,),
              Text('查詢處方簽狀態',style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ),),
    );
  }
}


/////////////////////searchMedicine//////////////////////////



class Wait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 120,),
        Image(image: AssetImage("assets/images/wait.png"),height: 250,),
        SizedBox(height: 20,),
        Text("正在為您準備中，請耐心等候",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
        ),),
      ],
    );
  }
}


class  FinishPacking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 100,),
        Image(image: AssetImage("assets/images/finish.png"),),
        Text("您的處方籤已準備完成，請您前來領取",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),
      ],
    );
  }
}


