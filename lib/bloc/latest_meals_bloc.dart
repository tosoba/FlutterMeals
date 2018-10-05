import 'package:flutter_meals/api/meal_db_api.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/model/category.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:rxdart/rxdart.dart';

class MainPagesBloc extends BlocBase {
  final _latestMealsSubject = BehaviorSubject<List<Meal>>();
  final _categoriesSubject = BehaviorSubject<List<Category>>();

  Observable<List<Meal>> get latestMealsStream => _latestMealsSubject.stream;

  Observable<List<Category>> get categoriesStream =>
      _categoriesSubject.stream;

  MainPagesBloc() {
    load();
  }

  load() {
    api.getLatestMeals().then((meals) => _latestMealsSubject.add(meals));
    api
        .getCategories()
        .then((categories) => _categoriesSubject.add(categories));
  }

  void dispose() {
    _latestMealsSubject.close();
    _categoriesSubject.close();
  }
}
