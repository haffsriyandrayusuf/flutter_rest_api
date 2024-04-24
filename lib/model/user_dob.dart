class UserDob {
  final DateTime date;
  final int age;

  UserDob({
    required this.date,
    required this.age,
  });

  factory UserDob.fromJson(Map<String, dynamic> json) => UserDob(
        date: DateTime.parse(json['date']),
        age: json['age'],
      );
}
