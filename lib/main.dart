import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/home_navigation_bloc.dart';
import 'package:flutter_meals/page/home_page.dart';

main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterMeals',
      home: BlocProvider(bloc: HomeNavigationBloc(), child: HomePage()),
    );
  }
}

