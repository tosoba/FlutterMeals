import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/const/text_style.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:flutter_meals/widget/separator/separator.dart';

class MealSummary extends StatelessWidget {
  final Meal meal;
  final bool horizontal;

  MealSummary(this.meal, {this.horizontal = true});

  MealSummary.vertical(this.meal) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    Widget _mealValue({String value, Widget widget}) {
      return Container(
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          widget,
          Container(width: 8.0),
          Text(meal.category, style: Style.smallTextStyle),
        ]),
      );
    }

    final mealCardContent = Container(
      margin: EdgeInsets.fromLTRB(
          horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 16.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 4.0),
          Text(meal.name, style: Style.titleTextStyle),
          Container(height: 10.0),
          Text(meal.cuisine, style: Style.commonTextStyle),
          Separator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: horizontal ? 1 : 0,
                  child:
                      _mealValue(value: meal.cuisine, widget: Icon(Icons.map))),
              Container(
                width: 32.0,
              ),
              Expanded(
                  flex: horizontal ? 1 : 0,
                  child:
                      _mealValue(value: meal.cuisine, widget: Icon(Icons.map)))
            ],
          ),
        ],
      ),
    );

    final mealCard = Container(
      child: mealCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin:
          horizontal ? EdgeInsets.only(left: 46.0) : EdgeInsets.only(top: 72.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return Container(
        margin: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: mealCard);
  }
}
