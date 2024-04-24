class UserId {
  final String? name;
  final String? value;

  UserId({
    required this.name,
    required this.value,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        name: json['name'],
        value: json['value'],
      );
}
