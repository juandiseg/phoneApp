import 'package:mysql1/mysql1.dart';

class Product {
  int product_id;
  String name;
  double price;

  Product(
      {required this.product_id, required this.name, required this.price});

  factory Product.fromJson(ResultRow row) {
    return Product(
        product_id: row['product_id'],
        name: row['name'],
        price: row['price']);
  }

}