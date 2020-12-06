import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'chat_screen.dart';
import 'fields.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "Login_Screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool _saving = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Fields(
                choose: false,
                inputType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                hintText: 'Enter your email.',
              ),
              SizedBox(
                height: 8.0,
              ),
              Fields(
                choose: true,
                onChanged: (value) {
                  password = value;
                },
                hintText: 'Enter your password.',
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'Log In',
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    setState(() {
                      _saving = true;
                    });
                    print(email);
                    print(password);
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        _saving = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
