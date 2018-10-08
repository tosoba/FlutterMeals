import 'dart:async';
import 'dart:convert';

import 'package:flutter_meals/model/category.dart';
import 'package:flutter_meals/model/ingredient.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:http/http.dart' as http;

class MealDbApi {
  static const _baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  static final instance = MealDbApi();

  Future<List<Meal>> getLatestMeals() async {
    return _mapToListOfMeals(
        await _getListFromUrl("${_baseUrl}latest.php", "meals"));
  }

  Future<List<Category>> getCategories() async {
    final categories =
        await _getListFromUrl("${_baseUrl}categories.php", "categories");
    return categories
        .map((categoryJson) =>
            Category.fromJson(categoryJson as Map<String, dynamic>))
        .toList();
  }

  Future<List<Ingredient>> getIngredients() async {
    final ingredients =
        await _getListFromUrl("${_baseUrl}list.php?i=list", "meals");
    return ingredients
        .map((ingredientJson) =>
            Ingredient.fromJson(ingredientJson as Map<String, dynamic>))
        .toList();
  }

  Future<Meal> getRandomMeal() async {
    return _mapToListOfMeals(
        await _getListFromUrl("${_baseUrl}random.php", "meals"))[0];
  }

  Future<Meal> getMealById(String id) async {
    return _mapToListOfMeals(
        await _getListFromUrl("${_baseUrl}lookup.php?i=$id", "meals"))[0];
  }

  Future<List<Meal>> searchMeals(String searchTerm) async {
    return _mapToListOfMeals(
        await _getListFromUrl("${_baseUrl}search.php?s=$searchTerm", "meals"));
  }

  Future<List<Meal>> findMealsByIngredient(Ingredient ingredient) async {
    return _mapToListOfMeals(await _getListFromUrl(
        "${_baseUrl}filter.php?i=${ingredient.name}", "meals"));
  }

  Future<List<Meal>> findMealsByCategory(Category category) async {
    return _mapToListOfMeals(await _getListFromUrl(
        "${_baseUrl}filter.php?c=${category.name}", "meals"));
  }

  Future<List<dynamic>> _getListFromUrl(
      String url, String listPropertyName) async {
    final response = await http.get(url);
    return json.decode(response.body)[listPropertyName] as List<dynamic>;
  }

  List<Meal> _mapToListOfMeals(List<dynamic> list) {
    return list == null
        ? []
        : list
            .map((mealJson) => Meal.fromJson(mealJson as Map<String, dynamic>))
            .toList();
  }
}
