import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addMessage(
      String chatRoomId, String messageId, Map messageInfo) async {
    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfo);
  }

  updateLastMessageSent(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // Chatroom already exists
      return true;
    } else {
      FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
