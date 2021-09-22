import 'package:LibraryOrientationApp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class AskQuestion extends StatefulWidget {
  AskQuestion({Key key}) : super(key: key);

  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  String _studentName = '';
  String _studentEmail = '';
  String _admin = 'admin';

  String studentName;
  String studentEmail;
  String chatRoomId;
  String messageId = "";
  TextEditingController messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getChatDetails();
  }

  getChatRoomIdByUsernames(String user, String admin) {
    if (user.substring(0, 1).codeUnitAt(0) >
        admin.substring(0, 1).codeUnitAt(0)) {
      return "$admin\_$user";
    } else {
      return "$user\_$admin";
    }
  }

  _getChatDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _studentName = prefs.getString("studentName");
      _studentEmail = prefs.getString("studentEmail");
      chatRoomId = getChatRoomIdByUsernames(_studentEmail, _admin);
    });
  }

  _buildMessage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: messageTextController,
              decoration:
                  InputDecoration.collapsed(hintText: 'Type your question'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.blue,
            onPressed: () {
              // _sendMessage();
            },
          )
        ],
      ),
    );
  }

  _sendMessage(bool sendClicked) {
    if (messageTextController.text == "") {
      SweetAlert.show(
        context,
        title: 'Error!',
        subtitle: 'Please type a question',
        style: SweetAlertStyle.error,
      );
    } else {
      String message = messageTextController.text;
      var lastMessageTimeStamp = DateTime.now();

      Map<String, dynamic> messageInfo = {
        "message": message,
        "sentBy": _studentEmail,
        "timestamp": lastMessageTimeStamp
      };
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }
      DatabaseMethods()
          .addMessage(chatRoomId, messageId, messageInfo)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageTimeStamp": lastMessageTimeStamp,
          "lastMessageSentBy": _studentEmail
        };
        DatabaseMethods().updateLastMessageSent(chatRoomId, lastMessageInfoMap);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    studentName = arguments['studentName'];
    studentEmail = arguments['studentEmail'];
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Library Admin',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 37,
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return;
                    },
                  ),
                ),
              ),
            ),
            _buildMessage(),
          ],
        ),
      ),
    );
  }
}
