import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/main_pages_bloc.dart';
import 'package:flutter_meals/bloc/navigation_bloc.dart';
import 'package:flutter_meals/page/categories_page.dart';
import 'package:flutter_meals/page/ingredients_page.dart';
import 'package:flutter_meals/page/latest_meals_page.dart';

class HomePage extends StatelessWidget {
  final mainPagesBloc = MainPagesBloc();

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

    return StreamBuilder(
        stream: navigationBloc.homePageIndexStream,
        builder: (context, AsyncSnapshot<int> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('FlutterMeals'),
            ),
            body: _childPages[snapshot.hasData ? snapshot.data : 0],
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: Text("Random meal"),
              icon: Icon(Icons.restaurant_menu),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                navigationBloc.changePage(index);
              },
              currentIndex: snapshot.hasData ? snapshot.data : 0,
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
