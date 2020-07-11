import 'package:cloud_firestore/cloud_firestore.dart';


class DataBaseMethod{
  getUserByUserName(String username) async{
    return await Firestore.instance.collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }
  getUserByUserEmail(String userEmail) async{
    return await Firestore.instance.collection("users")
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }

  uploadUserInfo(userMap){
    Firestore.instance.collection("users")
        .add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }

  addConversationMessage(String chatRoomId, messageMap){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e){
          print(e.toString());
    });
  }

  getConversationMessage(String chatRoomId)async{
    return Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }


  getChatRooms(String userName)async{
    return  Firestore.instance
        .collection("ChatRoom")
        .where("user", arrayContains: userName)
        .snapshots();
  }

  getMedicineStatus(String userName)async{
    return Firestore.instance
        .collection("medicineStatus")
        .where("users", isEqualTo: userName)
        .snapshots();
  }

}