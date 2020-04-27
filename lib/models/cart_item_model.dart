class CartItem {
  var id;
  var name;
  var price;
  var totalPrice;
  var quantity;
  var type;
  var imageUrl;

  CartItem({
    this.id,
    this.name,
    this.price,
    this.totalPrice,
    this.quantity,
    this.type,
    this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      totalPrice: json['totalPrice'],
      quantity: json['quantity'],
      type: json['type'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'totalPrice': totalPrice,
        'quantity': quantity,
        'type': type,
        'imageUrl': imageUrl,
      };
}
