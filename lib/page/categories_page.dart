import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/main_pages_bloc.dart';
import 'package:flutter_meals/model/category.dart';
import 'package:flutter_meals/widget/card_list_view/card_item.dart';
import 'package:flutter_meals/widget/card_list_view/card_list_view.dart';
import 'package:flutter_meals/widget/search_bar/search_bar.dart';

class CategoriesPage extends StatefulWidget {
  @override
  CategoriesPageState createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  String _filter = "";
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {
        _filter = controller.text;
      });
    });

    final bloc = BlocProvider.of<MainPagesBloc>(context);

    return Column(children: <Widget>[
      SearchBar(controller: controller),
      StreamBuilder(
        stream: bloc.categoriesStream,
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Expanded(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return Expanded(
            child: CardListView(
              onItemTap: (mealName) => bloc.selectedCategorySink.add(
                snapshot.data.firstWhere((meal) => meal.name == mealName),
              ),
              items: snapshot.data
                  .map(
                    (category) => CardListViewItemModel(
                      name: category.name,
                      imageUrl: category.thumbnailUrl,
                    ),
                  )
                  .where(
                    (category) => _filter.isNotEmpty
                        ? category.name
                            .toLowerCase()
                            .contains(_filter.toLowerCase())
                        : true,
                  )
                  .toList(),
            ),
          );
        },
      )
    ]);
  }
}
