import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:second_hand_mobils/models/product_model.dart';

@immutable
abstract class AppState {
  get favoriteProduct => null;
}

class InitialState extends AppState {}

class SignInState extends AppState {
  final String email;
  final String password;

  SignInState({
    required this.email,
    required this.password,
  });
}

class SignUpState extends AppState {
  final String userName;
  final String email;
  final String password;

  SignUpState({
    required this.userName,
    required this.email,
    required this.password,
  });
}

class AuthenticatedState extends AppState {
  final String userId; // Include any user-specific information here
  final String name;
  final String email;

  AuthenticatedState({
    required this.userId,
    required this.email,
    required this.name,
  });
}

class LoadHomeScreenState extends AppState {
  final bool token;
  LoadHomeScreenState({
    required this.token,
  });
}

class TabChangedState extends AppState {
  final int tabIndex;
  TabChangedState({required this.tabIndex});
}

class AddToFavoriteState extends AppState {
  @override
  final List<Product>? favoriteProduct;
  AddToFavoriteState({
    required this.favoriteProduct,
  });
}

class HomeScreenState extends AppState {
  HomeScreenState();
}

class ProductDetailScreenState extends AppState {
  final Product product;
  ProductDetailScreenState({required this.product});
}
