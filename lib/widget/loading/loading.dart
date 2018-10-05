import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        color: Colors.white.withOpacity(.8),
        foregroundDecoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 2.0)),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
