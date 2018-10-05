import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/model/category.dart';
import 'package:flutter_meals/widget/shimmer/shimmer.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    final shimmer = SizedBox.expand(
        child: Shimmer.fromColors(
            baseColor: Colors.lightBlue,
            highlightColor: Colors.white,
            child: SizedBox.expand()));

    final image = CachedNetworkImage(
      fit: BoxFit.scaleDown,
      placeholder: shimmer,
      fadeOutDuration: Duration(milliseconds: 500),
      imageUrl: category.thumbnailUrl,
      errorWidget: Icon(Icons.error),
      fadeInDuration: Duration(milliseconds: 300),
    );

    final imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.center,
          colors: [
            Color(0xFF606060),
            Color(0x00606060),
          ],
        ),
      ),
    );

    final text = Positioned(
      bottom: 25.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            category.name,
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    return Container(
      height: 200.0,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            fit: StackFit.expand,
            children: [image, imageOverlayGradient, text],
          ),
        ),
      ),
    );
  }
}
