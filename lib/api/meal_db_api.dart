import 'dart:async';
import 'dart:convert';

import 'package:flutter_meals/model/category.dart';
import 'package:flutter_meals/model/ingredient.dart';
import 'package:flutter_meals/model/meal.dart';
import 'package:http/http.dart' as http;

class MealDbApi {
  static const _baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  Future<List<Meal>> getLatestMeals() async {
    final url = "${_baseUrl}latest.php";
    final response = await http.get(url);
    final meals = json.decode(response.body)["meals"] as List<dynamic>;
    return meals
        .map((mealJson) => Meal.fromJson(mealJson as Map<String, dynamic>))
        .toList();
  }

  Future<List<Category>> getCategories() async {
    final url = "${_baseUrl}categories.php";
    final response = await http.get(url);
    final categories =
        json.decode(response.body)["categories"] as List<dynamic>;
    return categories
        .map((categoryJson) =>
            Category.fromJson(categoryJson as Map<String, dynamic>))
        .toList();
  }

  Future<List<Ingredient>> getIngredients() async {
    final url = "${_baseUrl}list.php?i=list";
    final response = await http.get(url);
    final ingredients = json.decode(response.body)["meals"] as List<dynamic>;
    return ingredients
        .map((ingredientJson) =>
            Ingredient.fromJson(ingredientJson as Map<String, dynamic>))
        .toList();
  }
}

final api = MealDbApi();
