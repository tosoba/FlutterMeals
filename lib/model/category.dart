class Category {
  final String id;
  final String name;
  final String thumbnailUrl;
  final String description;

  Category.fromJson(Map<String, dynamic> json)
      : id = json["idCategory"],
        name = json["strCategory"],
        thumbnailUrl = json["strCategoryThumb"],
        description = json["strCategoryDescription"];
}
