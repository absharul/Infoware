class SimpleProduct {
  int id;
  String title;
  List<String> images;
  int price;
  String description;

  SimpleProduct({
    required this.id,
    required this.title,
    required this.images,
    required this.price,
    required this.description,
  });

  factory SimpleProduct.fromJson(Map<String, dynamic> json) {
    List<dynamic> imagesJson = json["images"];
    List<String> images = imagesJson.map((image) => image.toString()).toList();
    return SimpleProduct(
      id: json["id"],
      title: json["title"],
      images: images,
      price: json["price"],
      description: json["description"],
    );
  }
}
