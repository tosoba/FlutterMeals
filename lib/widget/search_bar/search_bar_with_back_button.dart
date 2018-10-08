import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/widget/search_bar/search_bar.dart';

class SearchBarWithBackButton extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const SearchBarWithBackButton(
      {Key key, @required this.controller, this.autoFocus: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        children: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
          Expanded(
              child: SearchBar(autoFocus: autoFocus, controller: controller))
        ],
      ),
    );
  }
}
