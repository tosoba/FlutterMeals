import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/widget/gradient/linear_gradient_overlay_box.dart';
import 'package:flutter_meals/widget/shimmer/shimmer_box.dart';
import 'package:flutter_meals/widget/transform_page/page_transformer.dart';
import 'package:flutter_meals/widget/transform_page/transform_page_model.dart';
import 'package:meta/meta.dart';

class TransformPageItem extends StatelessWidget {
  TransformPageItem({
    @required this.item,
    @required this.pageVisibility,
    this.onTap,
  });

  final TransformPageModel item;
  final PageVisibility pageVisibility;

  final GestureTapCallback onTap;

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;
    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(xTranslation, 0.0, 0.0),
        child: child,
      ),
    );
  }

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: Text(
        item.category,
        style: textTheme.caption.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          item.title,
          style: textTheme.headline2
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [categoryText, titleText],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      fit: BoxFit.cover,
      alignment: FractionalOffset(
        0.5 + (pageVisibility.pagePosition / 3),
        0.5,
      ),
      placeholder: (context, url) => ShimmerExpandBox(),
      fadeOutDuration: Duration(milliseconds: 500),
      imageUrl: item.imageUrl,
      errorWidget: (context, url, error) => Icon(Icons.error),
      fadeInDuration: Duration(milliseconds: 300),
    );

    final imageOverlayGradient = LinearGradientOverlayBox(
      colors: [Color(0xFF000000), Color(0x00000000)],
    );

    final widget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            image,
            imageOverlayGradient,
            _buildTextContainer(context),
          ],
        ),
      ),
    );

    return onTap == null
        ? widget
        : GestureDetector(child: widget, onTap: onTap);
  }
}
