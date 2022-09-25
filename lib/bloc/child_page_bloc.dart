import 'dart:async';

import 'package:flutter_meals/api/meal_db_api.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:rxdart/rxdart.dart';

class ChildPageBloc extends BlocBase {
  final _selectedMealSubject = PublishSubject<Meal>();
  final _foundMealSubject = PublishSubject<Meal>();
  final _loadingSubject = BehaviorSubject.seeded(false);

  Sink<Meal> get selectedMealSink => _selectedMealSubject.sink;

  Stream<Meal> get foundMealStream => _foundMealSubject.stream;

  Stream<bool> get loadingStream => _loadingSubject.stream;

  ChildPageBloc() {
    _selectedMealSubject.listen((meal) {
      _loadingSubject.add(true);
      MealDbApi.instance.getMealById(meal.id).then((foundMeal) {
        _loadingSubject.add(false);
        _foundMealSubject.add(foundMeal);
      });
    });
  }

  @override
  dispose() {
    _selectedMealSubject.close();
    _foundMealSubject.close();
    _loadingSubject.close();
  }
}
