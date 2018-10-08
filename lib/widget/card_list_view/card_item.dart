import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/widget/gradient/linear_gradient_overlay_box.dart';
import 'package:flutter_meals/widget/shimmer/shimmer_box.dart';

class CardListViewItemModel {
  final String imageUrl;
  final String name;

  CardListViewItemModel({this.name, this.imageUrl});
}

class CardListViewItem extends StatelessWidget {
  final CardListViewItemModel model;
  final Function(String) onTap;

  const CardListViewItem({Key key, @required this.model, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      fit: BoxFit.scaleDown,
      placeholder: ShimmerExpandBox(),
      fadeOutDuration: Duration(milliseconds: 500),
      imageUrl: model.imageUrl,
      errorWidget: Icon(Icons.error),
      fadeInDuration: Duration(milliseconds: 300),
    );

    final imageOverlayGradient = LinearGradientOverlayBox(
        beginOffset: FractionalOffset.bottomCenter,
        endOffset: FractionalOffset.center,
        colors: [
          Color(0xFF606060),
          Color(0x00606060),
        ]);

    final text = Positioned(
      bottom: 25.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            model.name,
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    final widget = Container(
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

    return onTap == null
        ? widget
        : GestureDetector(
            child: widget,
            onTap: () => onTap(model.name),
          );
  }
}
