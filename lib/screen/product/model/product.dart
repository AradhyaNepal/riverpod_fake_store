abstract class ProductAbstract{}
class NoProduct extends ProductAbstract{}
class Product extends ProductAbstract{
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  double rating;
  int count;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.count,
  });

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map["id"],
      title: map["title"],
      price: (map["price"] as num).toDouble(),
      description: map["description"],
      category: map["category"],
      image: map["image"],
      rating: (map["rating"]["rate"] as num).toDouble(),
      count: map["rating"]["count"],
    );
  }

  @override
  String toString() {
    return "Id = $id\n\nTitle = $title\n\n Price = $price \n\n Description = $description \n\n Category = $category\n\n Rating = $rating\n\n Count = $count";
  }

}
