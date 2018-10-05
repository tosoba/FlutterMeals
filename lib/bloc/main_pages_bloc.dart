import 'package:flutter_meals/api/meal_db_api.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/model/category.dart';
import 'package:flutter_meals/model/ingredient.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:rxdart/rxdart.dart';

class MainPagesBloc extends BlocBase {
  final _latestMealsSubject = BehaviorSubject<List<Meal>>();
  final _categoriesSubject = BehaviorSubject<List<Category>>();
  final _ingredientsSubject = BehaviorSubject<List<Ingredient>>();

  Observable<List<Meal>> get latestMealsStream => _latestMealsSubject.stream;

  Observable<List<Category>> get categoriesStream => _categoriesSubject.stream;

  Observable<List<Ingredient>> get ingredientsStream =>
      _ingredientsSubject.stream;

  MainPagesBloc() {
    load();
  }

  load() {
    api.getLatestMeals().then((meals) => _latestMealsSubject.add(meals));
    api
        .getCategories()
        .then((categories) => _categoriesSubject.add(categories));
    api
        .getIngredients()
        .then((ingredients) => _ingredientsSubject.add(ingredients));
  }

  void dispose() {
    _latestMealsSubject.close();
    _categoriesSubject.close();
    _ingredientsSubject.close();
  }
}
