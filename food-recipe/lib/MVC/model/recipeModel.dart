class RecipeModel {
  final int id;
  final String title;
  final String image;
  final String imageType;

  RecipeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      imageType: json['imageType'],
    );
  }


   Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'imageType': imageType,
    };
  }
}
