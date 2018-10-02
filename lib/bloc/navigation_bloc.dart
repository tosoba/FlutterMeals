import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class NavigationBloc {
  final _homePageIndexSubject = BehaviorSubject<int>(seedValue: 0);

  Observable<int> get homePageStream => _homePageIndexSubject.stream;

  changePage(int index) {
    _homePageIndexSubject.add(index);
  }

  void dispose() {
    _homePageIndexSubject.close();
  }
}

class NavigationProvider extends InheritedWidget {
  final NavigationBloc bloc;

  NavigationProvider({Key key, Widget child})
      : bloc = NavigationBloc(),
        super(key: key, child: child);

  static NavigationBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(NavigationProvider)
            as NavigationProvider)
        .bloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
