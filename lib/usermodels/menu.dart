class Menus {
  int menu_id;
  String name;
  double price;

  Menus({
    required this.menu_id,
    required this.name,
    required this.price,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      menu_id: json['menu_id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_id': menu_id,
      'name': name,
      'price': price,
    };
  }
}
