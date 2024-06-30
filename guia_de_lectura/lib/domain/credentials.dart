class LoginCredentials {
  final String email;
  final String password;

  LoginCredentials({
    required this.email,
    required this.password,
  });

  bool get isValid => email.isNotEmpty && password.isNotEmpty;
}

class SignUpCredentials {
  final String username;
  final String email;
  final String password;

  SignUpCredentials({
    required this.username,
    required this.email,
    required this.password,
  });

  bool get isValid =>
      email.isNotEmpty && password.isNotEmpty && username.isNotEmpty;
}
