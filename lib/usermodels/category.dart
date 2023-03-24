class Categories {
  int category_id;
  int iscategory_product;
  String category_name;

  Categories({
    required this.category_id,
    required this.iscategory_product,
    required this.category_name,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
        category_id: json['category_id'],
        iscategory_product: json['iscategory_product'],
        category_name: json['category_name']);
  }

  Map toJson() {
    return {
      'category_id': category_id,
      'iscategory_product': iscategory_product,
      'category_name': category_name
    };
  }
}
