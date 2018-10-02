import 'package:flutter_meals/model/ingredient_with_measure.dart';

class Meal {
  final String id;
  final String name;
  final String category;
  final String cuisine;
  final String instructions;
  final String thumbnailUrl;
  final String youtubeUrl;
  final String source;
  final List<IngredientWithMeasure> ingredients;

  Meal.fromJson(Map<String, dynamic> json)
      : id = json["idMeal"],
        name = json["strMeal"],
        category = json["strCategory"],
        cuisine = json["strArea"],
        instructions = json["strInstructions"],
        thumbnailUrl = json["strMealThumb"],
        youtubeUrl = json["strYoutube"],
        source = json["strSource"],
        ingredients = [] {
    for (var i = 1; i <= 20; i++) {
      final ingredientProperty = "strIngredient$i";
      if (ingredientProperty == "") break;
      ingredients.add(IngredientWithMeasure(
          ingredient: json[ingredientProperty], measure: json["strMeasure$i"]));
    }
  }
}
