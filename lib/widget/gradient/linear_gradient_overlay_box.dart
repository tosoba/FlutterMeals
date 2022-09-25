import 'package:flutter/cupertino.dart';

class LinearGradientOverlayBox extends StatelessWidget {
  final FractionalOffset beginOffset;
  final FractionalOffset endOffset;
  final List<Color> colors;

  LinearGradientOverlayBox({
    this.beginOffset: FractionalOffset.bottomCenter,
    this.endOffset: FractionalOffset.topCenter,
    @required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: beginOffset,
          end: endOffset,
          colors: colors,
        ),
      ),
    );
  }
}
