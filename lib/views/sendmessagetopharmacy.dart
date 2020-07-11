import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Services/database.dart';
import 'package:pharmacy/helper/constants.dart';
import 'package:pharmacy/helper/helperfunctions.dart';
import 'package:pharmacy/widgets/widget.dart';

class SendMessageToPharmacy extends StatefulWidget {
  @override
  _SendMessageToPharmacyState createState() => _SendMessageToPharmacyState();
}

class _SendMessageToPharmacyState extends State<SendMessageToPharmacy> {
  String chatRoomid;

  @override
  void initState() {
    getUserInfo();
    creatChatRooma();
    dataBaseMethod.getConversationMessage(chatRoomid).then((value){
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    print(Constants.myName);
  }

  creatChatRooma() {
     String userName = "藥局";
    final String chatRoomId =getChat(userName, Constants.myName);
    List<String> users = [userName, Constants.myName];
    Map<String, dynamic> chatRoomMap = {
      "user": users,
      "chatroomId": chatRoomId,
    };
    setState(() {
      chatRoomid = chatRoomId;
      DataBaseMethod().createChatRoom(chatRoomId, chatRoomMap);
    });

  }
    TextEditingController messageController = new TextEditingController();
    DataBaseMethod dataBaseMethod = new DataBaseMethod();

    Stream <QuerySnapshot> chatMessageStream;

    Widget chatMessageList(){
      return StreamBuilder(
        stream : chatMessageStream,
        builder: (context, snapshot){

          return snapshot.hasData ? ListView.builder(
              padding: EdgeInsets.only(top: 1),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return MessageTile(snapshot.data.documents[index].data["message"],
                  snapshot.data.documents[index].data["sendBy"] == Constants.myName,
                );
              }) : Container();
        },
      );
    }
    sendMessage(){
      if(messageController.text.isNotEmpty){
        Map<String, dynamic> messageMap = {
          "message" : messageController.text,
          "sendBy" : Constants.myName,
          "time" : DateTime.now().toUtc(),
        };
        dataBaseMethod.addConversationMessage(chatRoomid, messageMap);
        messageController.text= "";
      }
    }

    _buildMessageComposer(){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 70,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration.collapsed(
                    hintText: "傳訊息..."
                ),
              ),),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: 25,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                sendMessage();
              },
            )
          ],
        ),
      );
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        appBar:appBarMain(context),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),),
                  ),
                  child: chatMessageList(),
                ),
              ),
              _buildMessageComposer()
            ],
          ),
        ),
      );
    }
}


class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: isSendByMe ? 0 : 24,
          right: isSendByMe ? 24 : 0),
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isSendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: isSendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: isSendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)]
                  : [
                const Color(0xFFF44336),
                const Color(0xFFE53935),
              ],
            )
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}

getChat(String a,String b){
  return "$b\_$a";
}