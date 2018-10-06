import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/main_pages_bloc.dart';
import 'package:flutter_meals/model/ingredient.dart';
import 'package:flutter_meals/widget/card_list_view/card_item.dart';
import 'package:flutter_meals/widget/card_list_view/card_list_view.dart';
import 'package:flutter_meals/widget/search_bar/search_bar.dart';

class IngredientsPage extends StatefulWidget {
  @override
  IngredientsPageState createState() {
    return IngredientsPageState();
  }
}

class IngredientsPageState extends State<IngredientsPage> {
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
      SearchBar(
        controller: controller,
      ),
      StreamBuilder(
          stream: bloc.ingredientsStream,
          builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Expanded(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return Expanded(
              child: CardListView(
                items: snapshot.data
                    .map((ingredient) => CardListViewItemModel(
                        name: ingredient.name,
                        imageUrl: ingredient.thumbnailUrl))
                    .where((ingredient) => _filter.isNotEmpty
                        ? ingredient.name
                            .toLowerCase()
                            .contains(_filter.toLowerCase())
                        : true)
                    .toList(),
              ),
            );
          })
    ]);
  }
}
