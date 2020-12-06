import 'package:flutter/material.dart';

class Fields extends StatelessWidget {
  Fields({this.onChanged, this.hintText, this.choose, this.inputType});

  final Function onChanged;
  final bool choose;
  final String hintText;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
      obscureText: choose,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
