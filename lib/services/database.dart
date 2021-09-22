import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addMessage(
      String chatRoomId, String messageId, Map messageInfo) async {
    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc("chatRoomId")
        .collection("chats")
        .doc(messageId)
        .set(messageInfo);
  }

  updateLastMessageSent(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatRooms")
        .doc("chatRoomId")
        .update(lastMessageInfoMap);
  }
}
