import 'package:flutter/material.dart';
import 'package:pharmacy/Animation/FadeAnimation.dart';
import 'package:pharmacy/helper/authenticate.dart';
import 'package:pharmacy/views/signin.dart';
import 'package:pharmacy/widgets/widget.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController forgotPasswordUserEmailTextEditingController = new TextEditingController();
  bool isLoading = false;

  sendResetEmail(){
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Authenticate()));
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
            Container(
              height: 350,
              decoration: BoxDecoration(
               image: new DecorationImage(
                   image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: FadeAnimation(1,Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: AssetImage('assets/images/light-1.png'),
                        ),
                      )
                    ),),
                  ),
                  Positioned(
                    left: 150,
                    width: 80,
                    height: 120,
                    child: FadeAnimation(1.3,Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: AssetImage('assets/images/light-2.png'),
                        ),
                      )
                    ),),
                  ),

                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(1.5,Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: AssetImage('assets/images/clock.png'),
                      ),
                    )
                ),),
              ),
                  Positioned(
                    top: 200,
                    left: 130,
                    child: FadeAnimation(1.6,Center(
                      child: Text(
                        "忘記密碼",style: TextStyle(
                          color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold
                      ),),
                    ),),
                  ),
            ]
              ),
            ),
              SizedBox(height: 70,),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: formKey,
                        child: FadeAnimation(1.7,TextFormField(
                          validator: (val){
                            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val) ? null: "請輸入有效電子郵件";
                          },
                          controller: forgotPasswordUserEmailTextEditingController,
                          decoration: InputDecoration(
                            hintText: "輕輸入您的電子信箱",
                          ),
                        ),)
                      ),
                      SizedBox(height: 20,),

                      FadeAnimation(1.5,GestureDetector(
                        onTap: (){
                          sendResetEmail();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 200,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors:[
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ]
                                ),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("送出",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),),
                                SizedBox(width: 10,),
                                Icon(Icons.send)
                              ],
                            )
                        ),
                      ),),
                    SizedBox(height: 100,),
                    Container(
                      child: FadeAnimation(1.7,Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              "回到"
                          ),
                          GestureDetector(
                            onTap: (){
                              ;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text("登入", style: TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  color: Color.fromRGBO(143, 148, 251, 1)
                              ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ),
                    ),

                    ]
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

