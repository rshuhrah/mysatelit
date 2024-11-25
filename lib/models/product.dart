// TODO Implement this library.// TODO Implement this library.class Product {
class Product{

  String id;
  String code;
  String name;
  String description;
  String image;
  int price;
  String category;
  int quantity;
  String inventoryStatus;
  int rating;

  Product({this.id = "",
      this.code = "",
      this.name = "",
      this.description = "",
      this.image = "",
      this.price = 0,
      this.category = "",
      this.quantity = 0,
      this.inventoryStatus = "",
      this.rating = 0});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      category: json['category'],
      quantity: json['quantity'],
      inventoryStatus: json['inventoryStatus'],
      rating: json['rating']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['price'] = price;
    data['category'] = category;
    data['quantity'] = quantity;
    data['inventoryStatus'] = inventoryStatus;
    data['rating'] = rating;
    return data;
  }

}