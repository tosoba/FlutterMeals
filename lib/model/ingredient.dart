class Ingredient {
  final String id;
  final String name;
  String thumbnailUrl;

  Ingredient.fromJson(Map<String, dynamic> json)
      : id = json["idIngredient"],
        name = json["strIngredient"] {
    thumbnailUrl = "https://www.themealdb.com/images/ingredients/$name.png";
  }
}
