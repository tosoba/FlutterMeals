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
    Widget _mealDetailWidget({String value, Icon icon, Widget widget}) {
      return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[icon, Container(width: 8.0), widget],
        ),
      );
    }

    final mealCardContent = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        shape: BoxShape.rectangle,
      ),
      margin: EdgeInsets.fromLTRB(
        horizontal ? 76.0 : 16.0,
        horizontal ? 16.0 : 16.0,
        16.0,
        16.0,
      ),
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 4.0),
          Text(
            meal.name ?? "",
            style: Style.titleTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Container(height: 10.0),
          Text(meal.cuisine ?? "", style: Style.commonTextStyle),
          Separator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: horizontal ? 1 : 0,
                child: _mealDetailWidget(
                  value: meal.cuisine ?? "",
                  icon: Icon(Icons.book),
                  widget: InkWell(
                    child: Text(
                      'Source',
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {},
                  ),
                ),
              ),
              Container(width: 32.0),
              Expanded(
                flex: horizontal ? 1 : 0,
                child: _mealDetailWidget(
                  value: meal.cuisine ?? "",
                  icon: Icon(Icons.video_label),
                  widget: InkWell(
                    child: Text(
                      'Video',
                      style: TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {},
                  ),
                ),
              )
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
        color: Theme.of(context).primaryColor.withOpacity(.85),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: mealCard,
    );
  }
}
