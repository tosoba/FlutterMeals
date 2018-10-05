import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = TextStyle(fontFamily: 'Poppins');
  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 11.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w400);
  static final commonTextStyleBlack =
      commonTextStyle.copyWith(color: Colors.black45);
  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w600);
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w400);
  static final headerTextStyleBlack =
      headerTextStyle.copyWith(color: Colors.black45);
}
