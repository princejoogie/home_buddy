class Product {
  var id;
  var name;
  var category;
  var price;
  var stock;
  var description;
  var imageUrl;
  var rating;

  Product({
    this.id,
    this.name,
    this.category,
    this.price,
    this.stock,
    this.description,
    this.imageUrl,
    this.rating
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      stock: json['stock'],
      description: json['description'],
      imageUrl: json['image_url'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'price': price,
        'stock': stock,
        'description': description,
        'image_url': imageUrl,
        'rating': rating,
      };
}
