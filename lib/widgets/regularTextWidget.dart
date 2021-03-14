import 'package:flutter/material.dart';

class RegularTextWidget extends StatelessWidget {
  final String text;
  final Color clr;
  RegularTextWidget({this.text, this.clr});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 15, color: clr, fontWeight: FontWeight.bold),
    );
  }
}
