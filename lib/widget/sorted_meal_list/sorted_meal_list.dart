import 'package:flutter/cupertino.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:flutter_meals/widget/card_list_view/card_item.dart';
import 'package:flutter_meals/widget/card_list_view/card_list_view.dart';

class SortedMealList extends StatelessWidget {
  final List<Meal> meals;
  final String sortString;
  final void Function(int) onItemTap;

  const SortedMealList(
      {Key key,
      @required this.meals,
      @required this.sortString,
      this.onItemTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListView(
      onItemTap: onItemTap,
      items: meals
          .map((meal) => CardListViewItemModel(
              name: meal.name, imageUrl: meal.thumbnailUrl))
          .toList()
            ..sort((a, b) {
              if (a.name.toLowerCase().startsWith(sortString.toLowerCase()) &&
                  !b.name.toLowerCase().startsWith(sortString.toLowerCase()))
                return -1;
              else if (!a.name
                      .toLowerCase()
                      .startsWith(sortString.toLowerCase()) &&
                  b.name.toLowerCase().startsWith(sortString.toLowerCase()))
                return 1;
              else
                return a.name.toLowerCase().compareTo(b.name.toLowerCase());
            }),
    );
  }
}
