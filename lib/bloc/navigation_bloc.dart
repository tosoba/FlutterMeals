import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class NavigationBloc implements BlocBase {
  final _homePageIndexSubject = BehaviorSubject<int>(seedValue: 0);

  Observable<int> get homePageStream => _homePageIndexSubject.stream;

  changePage(int index) {
    _homePageIndexSubject.add(index);
  }

  void dispose() {
    _homePageIndexSubject.close();
  }
}
