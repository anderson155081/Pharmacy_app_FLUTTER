import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmacy/Services/database.dart';
import 'package:pharmacy/helper/constants.dart';
import 'package:pharmacy/helper/helperfunctions.dart';
import 'package:pharmacy/views/conversation.dart';
import 'package:pharmacy/views/search.dart';
import 'package:pharmacy/widgets/widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DataBaseMethod dataBaseMethod = new DataBaseMethod();
  Stream chatRoomsStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return ChatRoomsTile(
                  snapshot.data.documents[index].data["chatroomId"]
                      .toString().replaceAll("_", "")
                      .replaceAll(Constants.myName, ""),
                    snapshot.data.documents[index].data["chatroomId"]
                );
              }): Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    dataBaseMethod.getChatRooms(Constants.myName).then((value){
      setState(() {
        chatRoomsStream = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child:
          Icon(Icons.search),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchScreen())
            );
          },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {

      return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ConversationScreen(chatRoomId)));
        },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Container(
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Text("${userName.substring(0, 1).toUpperCase()}",
                      style: signInTextStyleBold(),),
                  ),
                  SizedBox(width: 20,),
                  Text(userName, style: signInTextStyleBold(),),
                ],
              ),
            ),
          ),
        );
  }
}