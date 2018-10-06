import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/main_pages_bloc.dart';
import 'package:flutter_meals/bloc/navigation_bloc.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:flutter_meals/page/categories_page.dart';
import 'package:flutter_meals/page/ingredients_page.dart';
import 'package:flutter_meals/page/latest_meals_page.dart';
import 'package:flutter_meals/page/meal_detail_page.dart';
import 'package:flutter_meals/page/search_page.dart';
import 'package:flutter_meals/widget/loading/loading.dart';

class HomePage extends StatelessWidget {
  final mainPagesBloc = MainPagesBloc();

  void _goToMealDetails(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MealDetailPage(meal)),
    );
  }

  void _goToSearch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    final List<Widget> _childPages = [
      BlocProvider(child: LatestMealsPage(), bloc: mainPagesBloc),
      BlocProvider(child: CategoriesPage(), bloc: mainPagesBloc),
      BlocProvider(
        child: IngredientsPage(),
        bloc: mainPagesBloc,
      )
    ];

    mainPagesBloc.selectedMealStream.forEach((meal) {
      _goToMealDetails(context, meal);
    });

    return StreamBuilder(
        stream: navigationBloc.homePageIndexStream,
        builder: (context, AsyncSnapshot<int> pageIndexSnapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('FlutterMeals'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _goToSearch(context);
                  },
                ),
              ],
            ),
            body: StreamBuilder(
              stream: mainPagesBloc.randomMealLoadingStream,
              builder:
                  (context, AsyncSnapshot<bool> randomMealLoadingSnapshot) {
                return Stack(children: [
                  _childPages[
                      pageIndexSnapshot.hasData ? pageIndexSnapshot.data : 0],
                  (!randomMealLoadingSnapshot.hasData ||
                          randomMealLoadingSnapshot.data == null ||
                          randomMealLoadingSnapshot.data == false)
                      ? Container(
                          width: 0.0,
                          height: 0.0,
                        )
                      : Loading()
                ]);
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                mainPagesBloc.loadRandomMeal();
              },
              label: Text("Random meal"),
              icon: Icon(Icons.restaurant_menu),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                navigationBloc.changePage(index);
              },
              currentIndex:
                  pageIndexSnapshot.hasData ? pageIndexSnapshot.data : 0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.rss_feed),
                  title: Text('Latest'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  title: Text('Categories'),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), title: Text('Ingredients'))
              ],
            ),
          );
        });
  }
}
