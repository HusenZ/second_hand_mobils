import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthState {}

class LoginState extends AuthState {
  final String email;
  final String password;

  LoginState({
    required this.email,
    required this.password,
  });
}

class SignUp extends AuthState {
  final String userName;
  final String email;
  final String password;

  SignUp({
    required this.userName,
    required this.email,
    required this.password,
  })
}
