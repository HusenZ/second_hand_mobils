import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
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

  @override
  List<Object?> get props => [userName, email, password];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthenticatedEvent extends AuthEvent {
  final String userId; // Include any user-specific information here

  AuthenticatedEvent({
    required this.userId,
  });
  @override
  List<Object?> get props => [userId];
}

class LoadHomeScreenEvent extends AuthEvent {
  final bool token;
  LoadHomeScreenEvent(this.token);
  @override
  List<Object?> get props => [token];
}
