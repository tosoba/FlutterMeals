import 'dart:async';
import 'dart:convert';

import 'package:flutter_meals/model/meal.dart';
import 'package:http/http.dart' as http;

class MealDbApi {
  static const baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  Future<List<Meal>> getLatestMeals() async {
    final url = "${baseUrl}latest.php";
    final response = await http.get(url);
    final meals = json.decode(response.body)["meals"] as List<dynamic>;
    return meals.map((m) => Meal.fromJson(m as Map<String, dynamic>)).toList();
  }
}

final api = MealDbApi();
