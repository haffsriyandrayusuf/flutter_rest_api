class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;

  User({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        gender: json['gender'],
        email: json['email'],
        phone: json['phone'],
        cell: json['cell'],
        nat: json['nat'],
      );
}
