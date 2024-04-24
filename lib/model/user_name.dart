class UserName {
  final String title;
  final String firstName;
  final String lastName;

  UserName({
    required this.title,
    required this.firstName,
    required this.lastName,
  });

  factory UserName.fromJson(Map<String, dynamic> json) {
    return UserName(
      title: json['title'],
      firstName: json['first'],
      lastName: json['last'],
    );
  }
}
