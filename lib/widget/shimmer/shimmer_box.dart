import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/widget/shimmer/shimmer.dart';

class ShimmerExpandBox extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;

  const ShimmerExpandBox(
      {Key key,
      this.baseColor: Colors.white,
      this.highlightColor: Colors.lightBlueAccent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Shimmer.fromColors(
      baseColor: Colors.lightBlue,
      highlightColor: Colors.white,
      child: Container(
        color: Colors.white,
      ),
    ));
  }
}
