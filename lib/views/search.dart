import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Services/database.dart';
import 'package:pharmacy/helper/constants.dart';
import 'package:pharmacy/helper/helperfunctions.dart';
import 'package:pharmacy/views/conversation.dart';
import 'package:pharmacy/widgets/widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String _myName;

class _SearchScreenState extends State<SearchScreen> {

  DataBaseMethod dataBaseMethod = new DataBaseMethod();
  TextEditingController searchTextEditingController = new TextEditingController();
  QuerySnapshot searchSnapshot;
  initiateSearch(){
    dataBaseMethod
        .getUserByUserName(searchTextEditingController.text)
        .then((val){
          setState(() {
            searchSnapshot = val;
          });
        });
  }

  Widget searchList(){
    ////if searchSnapshot not equal null
    return searchSnapshot != null ? ListView.builder(
        itemCount: searchSnapshot.documents.length,
    shrinkWrap: true,
    itemBuilder: (context, index){
      return SearchTile(
        userName: searchSnapshot.documents[index].data["name"],
        userEmail: searchSnapshot.documents[index].data["email"],
      );
    }) : Container();
  }

  createChatRoomAndStartConversation(String userName){
    if(userName != Constants.myName){
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "user" : users,
        "chatroomId": chatRoomId,
      };

      DataBaseMethod().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomId
          )
      ));
    }else{
      print("you cannot sent message to yourself");
    }
  }

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(userName, style: signInTextStyle(),),
              Text(userEmail, style: signInTextStyle(),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(userName);
            },
            child: Container(
              child: Text("傳訊息", style: mediumTextStyle(),),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }
  getUserName()async{
    _myName = await HelperFunctions.getUserNameSharedPreference();
    print("{$_myName}");
  }

//////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchTextEditingController,
                        decoration: InputDecoration(
                          hintText: "搜尋姓名...",
                        ),
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.all(13),
                        child: Icon(Icons.search,color: Colors.white,)
                    ),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b){
  if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}