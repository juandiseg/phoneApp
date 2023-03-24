class Customer {
  String username;
  String name;
  String email;
  int points;
  DateTime birthday;

  Customer(
      {required this.username,
      required this.name,
      required this.email,
      required this.points,
      required this.birthday});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        username: json['username'],
        name: json['name'],
        email: json['email'],
        points: json['points'],
        birthday: json['birthday']);
  }

  Map toJson() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'points': points,
      'birthday': birthday,
    };
  }
}
