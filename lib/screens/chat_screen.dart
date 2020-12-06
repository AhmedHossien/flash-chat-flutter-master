import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = "Chat_Screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _textController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessagesCurrentUser() async {
  //   await for (var snapshot in _fireStore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
                //    getMessagesCurrentUser();
              }),
        ],
        title: Text(_auth.currentUser.email),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Storm(fireStore: _fireStore,),
            StreamBuilder<QuerySnapshot>(
                stream: _fireStore
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final messages = snapshot.data.docs;
                  List<Bubbles> messageBubbles = [];
                  for (var message in messages) {
                    final messageText = message.data()['Text'];
                    final messageSender = message.data()['Sender'];
                    final timeTamp = message.data()['timestamp'];

                    final currentUser = loggedInUser.email;

                    final messageBubble = Bubbles(
                      messageText: messageText,
                      messageSender: messageSender,
                      isMe: currentUser == messageSender,
                      timeTamp: timeTamp,
                    );
                    messageBubbles.add(messageBubble);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      children: messageBubbles,
                    ),
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _textController.clear();
                      //Implement send functionality.
                      if (messageText != null) {
                        _fireStore.collection('messages').add({
                          'Text': messageText,
                          'Sender': loggedInUser.email,
                          'timestamp': Timestamp.now(),
                        });
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
