import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autoFocus;

  const SearchBar(
      {Key key,
      @required this.controller,
      this.hintText: 'Search',
      this.autoFocus: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  autofocus: autoFocus,
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    controller.clear();
                  },
                ),
              ),
            )));
  }
}
