import 'package:meta/meta.dart';

class TransformPageModel {
  TransformPageModel({
    @required this.title,
    @required this.category,
    @required this.imageUrl,
  });

  final String title;
  final String category;
  final String imageUrl;
}
