import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/search_bloc.dart';
import 'package:flutter_meals/const/text_style.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:flutter_meals/widget/card_list_view/card_item.dart';
import 'package:flutter_meals/widget/card_list_view/card_list_view.dart';
import 'package:flutter_meals/widget/search_bar/search_bar.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);

    controller.addListener(() {
      if (controller.text != null && controller.text.isNotEmpty)
        bloc.searchSink.add(controller.text);
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                    ),
                    Expanded(
                        child: SearchBar(
                      controller: controller,
                    )),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: bloc.foundMealsStream,
                    builder: (context, AsyncSnapshot<List<Meal>> snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data.length == 0) {
                        return Center(
                          child: Text(
                            "Search for meals",
                            style: Style.headerTextStyleBlack,
                          ),
                        );
                      }

                      return CardListView(
                        items: snapshot.data
                            .map((meal) => CardListViewItemModel(
                                name: meal.name, imageUrl: meal.thumbnailUrl))
                            .toList()
                              ..sort((a, b) {
                                final searchTerm = controller.text;
                                if (a.name
                                        .toLowerCase()
                                        .startsWith(searchTerm.toLowerCase()) &&
                                    !b.name
                                        .toLowerCase()
                                        .startsWith(searchTerm.toLowerCase()))
                                  return -1;
                                else if (!a.name
                                        .toLowerCase()
                                        .startsWith(searchTerm.toLowerCase()) &&
                                    b.name
                                        .toLowerCase()
                                        .startsWith(searchTerm.toLowerCase()))
                                  return 1;
                                else
                                  return a.name
                                      .toLowerCase()
                                      .compareTo(b.name.toLowerCase());
                              }),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
