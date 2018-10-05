import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/main_pages_bloc.dart';
import 'package:flutter_meals/model/category.dart';
import 'package:flutter_meals/widget/card_list_view/card_item.dart';
import 'package:flutter_meals/widget/card_list_view/card_list_view.dart';

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
        return CardListView(
          items: snapshot.data
              .map((category) => CardListViewItemModel(
                  name: category.name, imageUrl: category.thumbnailUrl))
              .toList(),
        );
      },
    );
  }
}
