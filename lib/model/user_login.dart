class UserLogin {
  final String username;
  final String password;

  UserLogin({
    required this.username,
    required this.password,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        username: json['username'],
        password: json['password'],
      );
}
