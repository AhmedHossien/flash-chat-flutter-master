import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bubbles extends StatelessWidget {
  Bubbles({this.messageText, this.messageSender, this.isMe, this.timeTamp});

  final messageText;
  final messageSender;
  final bool isMe;
  final Timestamp timeTamp;

  String timeOut() {
    DateFormat dateFormat = DateFormat('yyyy.MM.dd , K.mm a');
    return dateFormat.format(timeTamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                messageSender,
                style: TextStyle(fontSize: 10, color: Colors.white70),
              ),
            ),
            Material(
                borderRadius: isMe
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30))
                    : BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30)),
                elevation: 5,
                color: isMe ? Colors.lightBlueAccent : Colors.white,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "$messageText",
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ))),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                timeOut(),
                style: TextStyle(fontSize: 10, color: Colors.white70),
              ),
            ),
          ],
        ));
  }
}
