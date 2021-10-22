import 'package:flutter/material.dart';
class padd extends StatelessWidget {
  padd({this.txt, this.color, this.onpress});
  final String txt;
  final Color color;
  final Function onpress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 15.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            txt,
            style:TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
