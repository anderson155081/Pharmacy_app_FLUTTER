import 'package:flutter/material.dart';
import 'package:pharmacy/Animation/FadeAnimation.dart';
import 'package:pharmacy/Services/auth.dart';
import 'package:pharmacy/Services/database.dart';
import 'package:pharmacy/helper/helperfunctions.dart';
import 'package:pharmacy/views/homePage.dart';
import 'package:pharmacy/widgets/widget.dart';


class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  AuthMethods authMethods = new AuthMethods();
  DataBaseMethod dataBaseMethod = new DataBaseMethod();

  bool isLoading = false;
  final formKey = GlobalKey <FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController userEmailTextEditingController = new TextEditingController();
  TextEditingController userPasswordTextEditingController = new TextEditingController();

  signingUp(){

    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      authMethods.signUpWithEmailAndPassword(userEmailTextEditingController.text,
          userPasswordTextEditingController.text).then((val){
        //print("$val");
         Map<String, String> userInfoMap = {
           "name": userNameTextEditingController.text,
           "email": userEmailTextEditingController.text,
         };
        HelperFunctions.saveUserEmailSharedPreference(userEmailTextEditingController.text);
        HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);

        dataBaseMethod.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
         builder: (context) => FirstPage()
        ));
          });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//      appBar: appBarMain(context),
      backgroundColor: Colors.white,
      body:isLoading ? Container (
        child: Center(child: CircularProgressIndicator()),
      ):Container(
        child: Container(
          child: SingleChildScrollView(
            child: Column(

              children:[
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
                      Form(
                        key: formKey,
                        child: FadeAnimation(1.7,Column(
                          children:[
                            TextFormField(
                              validator: (val){
                                return val.isEmpty || val.length >10 ? "請輸入使用者名稱": null;
                              },
                              controller: userNameTextEditingController,
                              decoration: InputDecoration(
                                hintText: "使用者名稱",
                                icon: Icon(Icons.person),
                              ),
                              style: signInTextStyle(),
                            ),
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
                                  hintText: "密碼(至少六位數)",
                                  icon: Icon(
                                      Icons.lock),
                                  suffixIcon: Icon(Icons.visibility)
                              ),
                              style: signInTextStyle(),
                            ),
                          ],
                        ),),
                      ),
                      SizedBox(height: 40),
                      GestureDetector(
                        onTap: (){
                          signingUp();
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.person_add, color: Colors.white,),
                                SizedBox(width: 10,),
                                Text("註冊", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),),
                              ],
                            )
                        ),),
                      ),
                      SizedBox(height: 50,),
                      FadeAnimation(1.7,Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("已經註冊 ？", style: signUpTextStyle()),
                          GestureDetector(
                            onTap:(){
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text("登入", style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                color: Color.fromRGBO(143, 148, 251, 1),
                              ),
                              ),
                            ),
                          ),
                        ],
                      ),)
                    ],
                  ),
                ),
//                Container(
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
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children:[
//                        Image(image: AssetImage("assets/images/google_logo.png"),height: 30,),
//                        SizedBox(width: 10,),
//                        Text("GOOGLE 註冊", style: signInTextStyleBold(),),
//                      ],
//                    ),
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
