import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
abstract class AuthState {}

class InitialState extends AuthState {}

class SignInState extends AuthState {
  final String email;
  final String password;

  SignInState({
    required this.email,
    required this.password,
  });
}

class SignUpState extends AuthState {
  final String userName;
  final String email;
  final String password;

  SignUpState({
    required this.userName,
    required this.email,
    required this.password,
  });
}

class AuthenticatedState extends AuthState {
  final String userId; // Include any user-specific information here

  AuthenticatedState({
    required this.userId,
  });
}

class LoadHomeScreenState extends AuthState {
  final bool token;
  LoadHomeScreenState({
    required this.token,
  });
}
