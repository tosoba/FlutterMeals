import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/home_navigation_bloc.dart';
import 'package:flutter_meals/bloc/main_pages_bloc.dart';
import 'package:flutter_meals/bloc/search_bloc.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:flutter_meals/page/categories_page.dart';
import 'package:flutter_meals/page/ingredients_page.dart';
import 'package:flutter_meals/page/latest_meals_page.dart';
import 'package:flutter_meals/page/meal_detail_page.dart';
import 'package:flutter_meals/page/meal_list_page.dart';
import 'package:flutter_meals/page/search_page.dart';
import 'package:flutter_meals/widget/loading/snapshot_loading_widget.dart';

class HomePage extends StatelessWidget {
  static final _mainPagesBloc = MainPagesBloc();

  final List<Widget> _childPages = [
    BlocProvider(child: LatestMealsPage(), bloc: _mainPagesBloc),
    BlocProvider(child: CategoriesPage(), bloc: _mainPagesBloc),
    BlocProvider(
      child: IngredientsPage(),
      bloc: _mainPagesBloc,
    )
  ];

  Widget _body(int pageIndex) {
    return Stack(
      children: List<Widget>.generate(_childPages.length, (int index) {
        return IgnorePointer(
          ignoring: index != pageIndex,
          child: Opacity(
            opacity: pageIndex == index ? 1.0 : 0.0,
            child: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return new MaterialPageRoute(
                  builder: (_) => _childPages[index],
                  settings: settings,
                );
              },
            ),
          ),
        );
      }),
    );
  }

  _goToMealDetails(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MealDetailPage(meal)),
    );
  }

  _goToSearch(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BlocProvider(child: SearchPage(), bloc: SearchBloc())));
  }

  _goToMealList(BuildContext context, List<Meal> meals) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MealListPage(meals: meals)));
  }

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<HomeNavigationBloc>(context);

    _mainPagesBloc.randomMealStream
        .listen((meal) => _goToMealDetails(context, meal));

    _mainPagesBloc.foundMealsStream
        .listen((meals) => _goToMealList(context, meals));

    return StreamBuilder(
        stream: navigationBloc.homePageIndexStream,
        initialData: 0,
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
              stream: _mainPagesBloc.loadingStream,
              builder: (context, AsyncSnapshot<bool> loadingSnapshot) {
                return Stack(children: [
                  _body(pageIndexSnapshot.hasData ? pageIndexSnapshot.data : 0),
                  SnapshotLoadingWidget(
                    loadingSnapshot: loadingSnapshot,
                  )
                ]);
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                _mainPagesBloc.loadRandomMeal();
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
