import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/navigation_bloc.dart';
import 'package:flutter_meals/page/place_holder_page.dart';

class HomePage extends StatelessWidget {
  final List<Widget> _childPages = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = NavigationProvider.of(context);
    return StreamBuilder(
        stream: bloc.homePageStream,
        builder: (context, AsyncSnapshot<int> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('FlutterMeals'),
            ),
            body: _childPages[snapshot.data],
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: Text("Random meal"),
              icon: Icon(Icons.restaurant_menu),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                bloc.changePage(index);
              },
              currentIndex: snapshot.data,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  title: Text('Latest'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  title: Text('Categories'),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.place), title: Text('Cuisines'))
              ],
            ),
          );
        });
  }
}
