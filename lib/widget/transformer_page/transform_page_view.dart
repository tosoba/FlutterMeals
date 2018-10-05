import 'package:flutter/material.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/bloc/main_pages_bloc.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:flutter_meals/widget/transformer_page//transform_page_item.dart';
import 'package:flutter_meals/widget/transformer_page/page_transformer.dart';
import 'package:flutter_meals/widget/transformer_page/transform_page_model.dart';

class TransformPageView extends StatelessWidget {
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
          return Scaffold(
            body: Center(
              child: SizedBox.fromSize(
                size: const Size.fromHeight(500.0),
                child: PageTransformer(
                  pageViewBuilder: (context, visibilityResolver) {
                    return PageView.builder(
                      controller: PageController(viewportFraction: 0.85),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data[index];
                        final pageVisibility =
                            visibilityResolver.resolvePageVisibility(index);
                        return TransformPageItem(
                          item: TransformPageModel(
                              title: item.name,
                              category: item.category,
                              imageUrl: item.thumbnailUrl),
                          pageVisibility: pageVisibility,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
