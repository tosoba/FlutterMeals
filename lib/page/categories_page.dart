import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/latest_meals_bloc.dart';
import 'package:flutter_meals/model/category.dart';
import 'package:flutter_meals/widget/category/category_card.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MainPagesBloc>(context);

    return StreamBuilder(
      stream: bloc.categoriesStream,
      builder: (context, AsyncSnapshot<List<Category>> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Container(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return CategoryCard(snapshot.data[index]);
            },
          ),
        );
      },
    );
  }
}
