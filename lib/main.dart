import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/navigation_bloc.dart';
import 'package:flutter_meals/page/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterMeals',
      home: BlocProvider(bloc: NavigationBloc(), child: HomePage()),
    );
  }
}
