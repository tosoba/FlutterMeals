import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/latest_meals_bloc.dart';
import 'package:flutter_meals/model/meal.dart';

class LatestMealsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LatestMealsBloc>(context);
    return StreamBuilder(
      stream: bloc.latestMealsStream,
      builder: (context, AsyncSnapshot<List<Meal>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 350.0,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data[index].name);
              }),
        );
      },
    );
  }
}
