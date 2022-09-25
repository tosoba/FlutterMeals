import 'dart:async';

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
  final _randomMealSubject = PublishSubject<Meal>();
  final _loadingSubject = BehaviorSubject.seeded(false);
  final _foundMealsSubject = PublishSubject<List<Meal>>();
  final _selectedIngredientSubject = PublishSubject<Ingredient>();
  final _selectedCategorySubject = PublishSubject<Category>();

  Stream<List<Meal>> get latestMealsStream => _latestMealsSubject.stream;

  Stream<List<Category>> get categoriesStream => _categoriesSubject.stream;

  Stream<List<Ingredient>> get ingredientsStream => _ingredientsSubject.stream;

  Stream<Meal> get randomMealStream => _randomMealSubject.stream;

  Stream<bool> get loadingStream => _loadingSubject.stream;

  Stream<List<Meal>> get foundMealsStream => _foundMealsSubject.stream;

  Sink<Meal> get selectedMealSink => _randomMealSubject.sink;

  Sink<Ingredient> get selectedIngredientSink =>
      _selectedIngredientSubject.sink;

  Sink<Category> get selectedCategorySink => _selectedCategorySubject.sink;

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

    _selectedCategorySubject.listen((category) {
      _loadingSubject.add(true);
      MealDbApi.instance.findMealsByCategory(category).then((meals) {
        _loadingSubject.add(false);
        _foundMealsSubject.add(meals);
      });
    });

    _selectedIngredientSubject.listen((ingredient) {
      _loadingSubject.add(true);
      MealDbApi.instance.findMealsByIngredient(ingredient).then((meals) {
        _loadingSubject.add(false);
        _foundMealsSubject.add(meals);
      });
    });
  }

  loadRandomMeal() {
    _loadingSubject.add(true);
    MealDbApi.instance.getRandomMeal().then((meal) {
      _loadingSubject.add(false);
      _randomMealSubject.add(meal);
    });
  }

  @override
  dispose() {
    _latestMealsSubject.close();
    _categoriesSubject.close();
    _ingredientsSubject.close();
    _randomMealSubject.close();
    _loadingSubject.close();
    _foundMealsSubject.close();
    _selectedCategorySubject.close();
    _selectedIngredientSubject.close();
  }
}
