import 'package:flutter/cupertino.dart';
import 'package:flutter_meals/widget/loading/loading.dart';

class SnapshotLoadingWidget extends StatelessWidget {
  final AsyncSnapshot<bool> loadingSnapshot;

  const SnapshotLoadingWidget({Key key, @required this.loadingSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!loadingSnapshot.hasData ||
            loadingSnapshot.data == null ||
            loadingSnapshot.data == false)
        ? Container(
            width: 0.0,
            height: 0.0,
          )
        : Loading();
  }
}
