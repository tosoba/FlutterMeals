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
  final _selectedMealSubject = PublishSubject<Meal>();
  final _randomMealLoadingSubject = BehaviorSubject<bool>(seedValue: false);

  Observable<List<Meal>> get latestMealsStream => _latestMealsSubject.stream;

  Observable<List<Category>> get categoriesStream => _categoriesSubject.stream;

  Observable<List<Ingredient>> get ingredientsStream =>
      _ingredientsSubject.stream;

  Observable<Meal> get selectedMealStream => _selectedMealSubject.stream;

  Observable<bool> get randomMealLoadingStream =>
      _randomMealLoadingSubject.stream;

  Sink<Meal> get selectedMealSink => _selectedMealSubject.sink;

  MainPagesBloc() {
    load();
  }

  load() {
    MealDbApi.instance
        .getLatestMeals()
        .then((meals) => _latestMealsSubject.add(meals));
    MealDbApi.instance
        .getCategories()
        .then((categories) => _categoriesSubject.add(categories));
    MealDbApi.instance
        .getIngredients()
        .then((ingredients) => _ingredientsSubject.add(ingredients));
  }

  loadRandomMeal() {
    _randomMealLoadingSubject.add(true);
    MealDbApi.instance.getRandomMeal().then((meal) {
      _randomMealLoadingSubject.add(false);
      _selectedMealSubject.add(meal);
    });
  }

  void dispose() {
    _latestMealsSubject.close();
    _categoriesSubject.close();
    _ingredientsSubject.close();
    _selectedMealSubject.close();
    _randomMealLoadingSubject.close();
  }
}
