import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final Color color;

  const Separator({Key key, this.color: Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        height: 2.0,
        width: 50.0,
        color: color);
  }
}
