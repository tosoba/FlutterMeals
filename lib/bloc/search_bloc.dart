import 'package:flutter_meals/api/meal_db_api.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BlocBase {
  final _searchSubject = PublishSubject<String>();
  final _foundMealsSubject = PublishSubject<List<Meal>>();

  bool disposed = false;

  Observable<List<Meal>> get foundMealsStream => _foundMealsSubject.stream;

  Sink<String> get searchSink => _searchSubject.sink;

  SearchBloc() {
    _searchSubject.debounce(Duration(seconds: 1)).forEach((searchTerm) =>
        MealDbApi.instance.searchMeals(searchTerm).then((meals) {
          if (!disposed) _foundMealsSubject.add(meals);
        }));
  }

  @override
  dispose() {
    _searchSubject.close();
    _foundMealsSubject.close();
    disposed = true;
  }
}
