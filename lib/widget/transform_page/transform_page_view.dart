import 'package:flutter/material.dart';
import 'package:flutter_meals/widget/transform_page//transform_page_item.dart';
import 'package:flutter_meals/widget/transform_page/page_transformer.dart';
import 'package:flutter_meals/widget/transform_page/transform_page_model.dart';

class TransformPageView extends StatelessWidget {
  final List<TransformPageModel> items;

  const TransformPageView({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);
                  return TransformPageItem(
                    item: items[index],
                    pageVisibility: pageVisibility,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
