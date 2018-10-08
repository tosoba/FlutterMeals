import 'package:flutter/cupertino.dart';
import 'package:flutter_meals/widget/card_list_view/card_item.dart';

class CardListView extends StatelessWidget {
  final List<CardListViewItemModel> items;
  final void Function(String) onItemTap;

  CardListView({@required this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CardListViewItem(
            model: items[index],
            onTap: onItemTap,
          );
        },
      ),
    );
  }
}
