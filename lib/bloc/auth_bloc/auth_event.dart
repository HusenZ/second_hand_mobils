import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

class SignUpEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  SignUpEvent({
    required this.userName,
    required this.email,
    required this.password,
  });
}

class LoadHomeScreenEvent extends AuthEvent {}
