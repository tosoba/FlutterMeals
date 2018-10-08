import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/search_bloc.dart';
import 'package:flutter_meals/const/text_style.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:flutter_meals/widget/search_bar/search_bar_with_back_button.dart';
import 'package:flutter_meals/widget/sorted_meal_list/sorted_meal_list.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);

    controller.addListener(() {
      if (controller.text != null && controller.text.isNotEmpty)
        bloc.searchSink.add(controller.text);
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
                child: StreamBuilder(
                    stream: bloc.foundMealsStream,
                    builder: (context, AsyncSnapshot<List<Meal>> snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data.length == 0) {
                        return Center(
                          child: Text(
                            "Search for meals.",
                            style: Style.headerTextStyleBlack,
                          ),
                        );
                      }
                      return SortedMealList(
                        meals: snapshot.data,
                        sortString: controller.text,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}