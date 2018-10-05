import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/main_pages_bloc.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:flutter_meals/widget/transform_page//transform_page_view.dart';
import 'package:flutter_meals/widget/transform_page/transform_page_model.dart';

class LatestMealsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MainPagesBloc>(context);
    return StreamBuilder(
      stream: bloc.latestMealsStream,
      builder: (context, AsyncSnapshot<List<Meal>> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Container(
            child: TransformPageView(
          items: snapshot.data
              .map((meal) => TransformPageModel(
                  title: meal.name,
                  category: meal.category,
                  imageUrl: meal.thumbnailUrl))
              .toList(),
        ));
      },
    );
  }
}
