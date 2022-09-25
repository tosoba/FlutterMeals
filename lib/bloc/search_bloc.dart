import 'dart:async';

import 'package:flutter_meals/api/meal_db_api.dart';
import 'package:flutter_meals/bloc/bloc_provider.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BlocBase {
  final _searchSubject = PublishSubject<String>();
  final _foundMealsSubject = PublishSubject<List<Meal>>();
  final _loadingSubject = PublishSubject<bool>();

  bool disposed = false;

  Stream<List<Meal>> get foundMealsStream => _foundMealsSubject.stream;

  Stream<bool> get loadingStream => _loadingSubject.stream;

  Sink<String> get searchSink => _searchSubject.sink;

  SearchBloc() {
    _searchSubject
        .debounceTime(Duration(milliseconds: 500))
        .distinct()
        .listen((searchTerm) {
      if (!disposed) _loadingSubject.add(true);
      MealDbApi.instance.searchMeals(searchTerm).then((meals) {
        if (!disposed) {
          _loadingSubject.add(false);
          _foundMealsSubject.add(meals);
        }
      });
    });
  }

  @override
  dispose() {
    disposed = true;
    _searchSubject.close();
    _foundMealsSubject.close();
    _loadingSubject.close();
  }
}
