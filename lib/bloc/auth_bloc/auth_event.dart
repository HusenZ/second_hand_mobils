import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthEvent {}

class LoginEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {}
