import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/child_page_bloc.dart';
import 'package:flutter_meals/bloc/search_bloc.dart';
import 'package:flutter_meals/const/text_style.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:flutter_meals/page/meal_detail_page.dart';
import 'package:flutter_meals/widget/loading/snapshot_loading_widget.dart';
import 'package:flutter_meals/widget/search_bar/search_bar_with_back_button.dart';
import 'package:flutter_meals/widget/sorted_meal_list/sorted_meal_list.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  String _lastSearch = "";
  final childBloc = ChildPageBloc();
  bool _didSubscribe = false;

  _goToMealDetails(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MealDetailPage(meal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    if (!_didSubscribe) {
      childBloc.foundMealStream
          .distinct((previous, next) => previous.id == next.id)
          .listen((meal) => _goToMealDetails(context, meal));
      _didSubscribe = true;
    }

    controller.addListener(() {
      if (controller.text != null && controller.text.isNotEmpty) {
        _lastSearch = controller.text;
        searchBloc.searchSink.add(_lastSearch);
      }
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
                child: Stack(
                  children: [
                    StreamBuilder(
                        stream: searchBloc.foundMealsStream,
                        builder: (context,
                            AsyncSnapshot<List<Meal>> foundMealsSnapshot) {
                          if (!foundMealsSnapshot.hasData ||
                              foundMealsSnapshot.data == null) {
                            return Center(
                              child: Text(
                                "Search for meals.",
                                style: Style.headerTextStyleBlack,
                              ),
                            );
                          } else if (foundMealsSnapshot.data.length == 0) {
                            return Center(
                              child: Text(
                                "No meals found.",
                                style: Style.headerTextStyleBlack,
                              ),
                            );
                          }
                          return SortedMealList(
                            onItemTap: (mealName) => childBloc.selectedMealSink
                                .add(foundMealsSnapshot.data.firstWhere(
                                    (meal) => meal.name == mealName)),
                            meals: foundMealsSnapshot.data,
                            sortString: _lastSearch,
                          );
                        }),
                    StreamBuilder(
                      stream: StreamGroup.merge(
                          [childBloc.loadingStream, searchBloc.loadingStream]),
                      builder: (context, AsyncSnapshot<bool> loadingSnapshot) {
                        return SnapshotLoadingWidget(
                          loadingSnapshot: loadingSnapshot,
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
