import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:second_hand_mobils/models/product_model.dart';

@immutable
abstract class AppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AppEvent {
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

class SignInEvent extends AppEvent {
  final String email;
  final String password;

  SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthenticatedEvent extends AppEvent {
  final String userId; // Include any user-specific information here
  final String name;
  final String email;

  AuthenticatedEvent({
    required this.userId,
    required this.name,
    required this.email,
  });
  @override
  List<Object?> get props => [userId, name, email];
}

class LoadHomeScreenEvent extends AppEvent {
  final bool token;
  LoadHomeScreenEvent(this.token);
  @override
  List<Object?> get props => [token];
}

class TabChangedEvent extends AppEvent {
  final int tabIndex;
  TabChangedEvent({required this.tabIndex});
  @override
  List<Object?> get props => [tabIndex];
}

class AddToFavoriteEvent extends AppEvent {
  final List<Product>? favoriteProduct;
  AddToFavoriteEvent({
    required this.favoriteProduct,
  });
  @override
  List<Object?> get props => [favoriteProduct];
}

class HomeScreenEvent extends AppEvent {
  HomeScreenEvent();
}

class ProductDetailScreenEvent extends AppEvent {
  final Product product;
  ProductDetailScreenEvent({required this.product});
  @override
  List<Object?> get props => [product];
}
