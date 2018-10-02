import 'package:flutter_meals/api/meal_db_api.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:rxdart/rxdart.dart';

class LatestMealsBloc extends BlocBase {
  final _latestMealsSubject = BehaviorSubject<List<Meal>>();

  Observable<List<Meal>> get latestMealsStream => _latestMealsSubject.stream;

  LatestMealsBloc() {
    load();
  }

  load() {
    api.getLatestMeals().then((meals) => _latestMealsSubject.add(meals));
  }

  void dispose() {
    _latestMealsSubject.close();
  }
}
