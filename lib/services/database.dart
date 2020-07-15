import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserbyUsername(String username) async {
    return await Firestore.instance
        .collection('usres')
        .where('name', isEqualTo: username)
        .getDocuments();
  }

  getUserbyEmail(String useremail) async {
    return await Firestore.instance
        .collection('usres')
        .where('email', isEqualTo: useremail)
        .getDocuments();
  }

  uploaduserinfo(userMap) {
    Firestore.instance.collection('usres').add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap);
  }

  getConversationMessages(String ChatRoomId,) async{
   return await Firestore.instance.collection("ChatRoom").document(ChatRoomId).collection(
        "chat").orderBy("time",descending: false).snapshots();
  }

  addConversationMessages(String ChatRoomId, messageMap) {
    Firestore.instance.collection("ChatRoom").document(ChatRoomId).collection(
        "chat").add(messageMap);
  }
  getchatRooms(String userName)async{
    return await Firestore.instance.collection("ChatRoom").where("users",arrayContains: userName).snapshots();

  }
}