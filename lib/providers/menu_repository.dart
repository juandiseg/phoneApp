import 'package:eatnbeat/usermodels/menu.dart';
import 'package:mysql1/mysql1.dart';

import '../usermodels/category.dart';
import '../usermodels/product.dart';
import 'db_connection.dart';

class CategoriesRepository {
  Future<List<Menus>> getMenusByCategoryID(int categoryID) async {
    final conn = await DatabaseConnection().getConnection();

    final result = await conn.query(
        'SELECT menus.menu_id, menus.name, menus.price FROM menus INNER JOIN categories ON '
        'menus.category_id = categories.category_id WHERE categories.category_id = ? AND menus.active = true AND categories.iscategory_product = false;',
        [categoryID]);

    final menus = <Menus>[];
    for (var row in result) {
      menus.add(
        Menus(
          menu_id: row['menu_id'],
          name: row['name'],
          price: double.parse(row['price'].toString()),
        ),
      );
    }

    await conn.close();

    return menus;
  }

  Future<List<Categories>> getCategories() async {
    final conn = await DatabaseConnection().getConnection();

    final result = await conn.query('SELECT * FROM categories');

    final categories = <Categories>[];
    for (var row in result) {
      categories.add(
        Categories(
          category_id: row['category_id'],
          iscategory_product: row['iscategory_product'],
          category_name: row['category_name'],
        ),
      );
    }

    await conn.close();

    return categories;
  }

  Future<List<Product>> getProductsByCategory(int categoryID) async {
    final conn = await DatabaseConnection().getConnection();

    final result = await conn.query(
        'SELECT products.product_id, products.name, products.price FROM products INNER JOIN categories ON '
            'products.category_id = categories.category_id WHERE categories.category_id = ? AND products.active = true AND categories.iscategory_product = true;',
        [categoryID]);

    final products = <Product>[];
    for (var row in result) {
      products.add(
        Product(
          product_id: row['product_id'],
          name: row['name'],
          price: double.parse(row['price'].toString()),
        ),
      );
    }

    await conn.close();

    return products;
  }



  Future<List<Menus>> getFamilyMenus() async {
    final conn = await DatabaseConnection().getConnection();

    final result =
        await conn.query('SELECT name, price FROM menus WHERE active = 1');

    final menus = <Menus>[];
    for (var row in result) {
      menus.add(Menus.fromJson(row.fields));
    }

    await conn.close();

    return menus;
  }
}

class ProductRepository {
  static Future<List<Product>> getProductsByCategoryID(int categoryID) async {
    final conn = await DatabaseConnection().getConnection();

    final result = await conn.query(
        'SELECT products.product_id, products.name, products.price FROM products INNER JOIN categories ON '
        'products.category_id = categories.category_id WHERE categories.category_id = ? AND products.active = true AND categories.iscategory_product = false;',
        [categoryID]);

    final products = <Product>[];
    for (var row in result) {
      products.add(
        Product(
          product_id: row['product_id'],
          name: row['name'],
          price: double.parse(row['price'].toString()),
        ),
      );
    }

    await conn.close();

    return products;
  }
}
