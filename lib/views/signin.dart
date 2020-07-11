import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Animation/FadeAnimation.dart';
import 'package:pharmacy/Services/auth.dart';
import 'package:pharmacy/Services/database.dart';
import 'package:pharmacy/helper/helperfunctions.dart';
import 'package:pharmacy/views/homePage.dart';
import 'package:pharmacy/views/resetPassword.dart';
import 'package:pharmacy/widgets/widget.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DataBaseMethod dataBaseMethod = new DataBaseMethod();
  TextEditingController userEmailTextEditingController = new TextEditingController();
  TextEditingController userPasswordTextEditingController = new TextEditingController();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;


  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await authMethods
          .signInWithEmailAndPassword(
          userEmailTextEditingController.text, userPasswordTextEditingController.text)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfoSnapshot =
          await DataBaseMethod().getUserByUserEmail(userEmailTextEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["name"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["email"]);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => FirstPage()));
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//      appBar: appBarMain(context),
      backgroundColor: Colors.white,
      body:Container(
        child: SingleChildScrollView(
//          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(

            children:<Widget>[
              Container(
                height: 350,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill
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
                      child: FadeAnimation(1.6,Center(
                        child: Text(
                          "士昌藥局",style: TextStyle(
                          color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold
                        ),),
                      ),),
                    ),
                  ],
                ),
              ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Form(
                        key: formKey,
                        child: FadeAnimation(1.7,Column(
                          children: [
                            TextFormField(
                              validator: (val){
                                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val) ? null: "請輸入有效電子郵件";
                              },
                              controller: userEmailTextEditingController,
                              decoration: InputDecoration(
                                hintText: "電子郵件",
                                icon: Icon(Icons.person),
                              ),
                              style: signInTextStyle(),
                            ),
                            TextFormField(
                              validator: (val){
                                return val.isEmpty || val.length < 6 ?"請輸入大於六位數的密碼":null;
                              },
                              controller: userPasswordTextEditingController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "密碼",
                                  icon: Icon(
                                      Icons.lock),
                                  suffixIcon: Icon(Icons.visibility)
                              ),
                              style: signInTextStyle(),
                            ),
                          ],
                        ),),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ResetPassword()
                          ));
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: FadeAnimation(1.7,Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text("忘記密碼?", style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(143, 148, 251, 1),
                            ),
                            ),
                          ),),
                        ),
                      ),

                      SizedBox(height: 20,),

                      GestureDetector(
                        onTap: (){
                          signIn();
                        },
                        child: FadeAnimation(2,Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
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
                                Text("登入", style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),),
                              ],
                            )
                        ),),
                      ),
                      SizedBox(height: 30,),
                      FadeAnimation(1.7,Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("還未註冊嗎 ？", style: signUpTextStyle()),
                          GestureDetector(
                            onTap: (){
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text("註冊", style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                color: Color.fromRGBO(143, 148, 251, 1)
                              ),
                              ),
                            ),
                          ),
                        ],
                      ),)

                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


//Container(
//                  alignment: Alignment.center,
//                  width: MediaQuery.of(context).size.width,
//                  padding: EdgeInsets.symmetric(vertical: 15),
//                  decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                          colors:[
//                            const Color(0xFFFFE082),
//                            const Color(0xFFFF6F00),
//                            const Color(0xFFF45111),
//                            const Color(0xFFF65100),
//                          ]
//                      ),
//                      borderRadius: BorderRadius.circular(30)
//                  ),
//                  child:
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Image(image: AssetImage("assets/images/google_logo.png"),height: 30,),
//                      SizedBox(width: 10,),
//                      Text("GOOGLE 登入", style: signInTextStyleBold(),),
//                    ],
//                  ),
//              ),