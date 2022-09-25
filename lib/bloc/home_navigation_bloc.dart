import 'dart:async';

import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeNavigationBloc implements BlocBase {
  final _homePageIndexSubject = BehaviorSubject.seeded(0);

  Stream<int> get homePageIndexStream => _homePageIndexSubject.stream;

  changePage(int index) {
    _homePageIndexSubject.add(index);
  }

  dispose() {
    _homePageIndexSubject.close();
  }
}
