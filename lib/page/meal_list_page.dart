import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/const/text_style.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:flutter_meals/page/meal_detail_page.dart';
import 'package:flutter_meals/widget/search_bar/search_bar_with_back_button.dart';
import 'package:flutter_meals/widget/sorted_meal_list/sorted_meal_list.dart';

class MealListPage extends StatefulWidget {
  final List<Meal> meals;

  MealListPage({Key key, @required this.meals}) : super(key: key);

  @override
  MealListPageState createState() {
    return new MealListPageState();
  }
}

class MealListPageState extends State<MealListPage> {
  final TextEditingController controller = TextEditingController();
  String _filter = "";

  _goToMealDetails(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MealDetailPage(meal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {
        _filter = controller.text;
      });
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SearchBarWithBackButton(
                controller: controller,
              ),
              Expanded(
                  child: (widget.meals == null || widget.meals.length == 0)
                      ? Center(
                          child: Text(
                            "No meals found.",
                            style: Style.headerTextStyleBlack,
                          ),
                        )
                      : SortedMealList(
                          onItemTap: (mealName) => _goToMealDetails(
                              context,
                              widget.meals
                                  .firstWhere((meal) => meal.name == mealName)),
                          meals: widget.meals
                              .where((meal) => _filter.isNotEmpty
                                  ? meal.name
                                      .toLowerCase()
                                      .contains(_filter.toLowerCase())
                                  : true)
                              .toList(),
                          sortString: controller.text,
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
