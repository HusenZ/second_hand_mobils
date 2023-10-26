import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:second_hand_mobils/bloc/app_bloc/app_event.dart';
import 'package:second_hand_mobils/bloc/app_bloc/app_state.dart';
import 'package:bloc/bloc.dart';
import 'package:second_hand_mobils/models/show_snack.dart';
import 'package:second_hand_mobils/screens/screens.dart';
import 'package:second_hand_mobils/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final BuildContext context;
  final AuthService authService = AuthService();
  AppBloc(super.initialState, {required this.context}) {
    on<SignInEvent>((event, emit) async {
      SignInState(
        email: event.email,
        password: event.password,
      );

      // ignore: use_build_context_synchronously
      final response = await authService.signInUser(
        context: context,
        email: event.email,
        password: event.password,
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String id = jsonDecode(response.body)['_id'];
      final String name = jsonDecode(response.body)['name'];
      final String email = jsonDecode(response.body)['email'];

      await prefs.setString('id', id);
      await prefs.setString('email', email);
      await prefs.setString('name', name);

      if (response.statusCode == 200) {
        authService.setToken(jsonDecode(response.body)['token']);
        add(LoadHomeScreenEvent(true));
        add(AuthenticatedEvent(
          userId: id,
          email: email,
          name: name,
        ));
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context, response.toString());
      }
    });
    on<SignUpEvent>((event, emit) async {
      SignUpState(
        userName: event.userName,
        email: event.email,
        password: event.password,
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // ignore: use_build_context_synchronously
      final response = await authService.signUpUser(
        context: context,
        email: event.email,
        password: event.password,
        name: event.userName,
      );

      final token = await prefs.setString(
          'x-auth-token', jsonDecode(response.body)['token']);
      final String id = jsonDecode(response.body)['_id'];
      final String name = jsonDecode(response.body)['name'];
      final String email = jsonDecode(response.body)['email'];

      //storing all these data
      await prefs.setString('email', email);
      await prefs.setString('name', name);
      if (response.statusCode == 200) {
        authService.setToken(jsonDecode(response.body)['token']);
        add(LoadHomeScreenEvent(token));
        add(AuthenticatedEvent(
          userId: id,
          email: email,
          name: name,
        ));
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context, response.toString());
      }
    });

    on<AuthenticatedEvent>(((event, emit) {
      emit(AuthenticatedState(
          userId: event.userId, email: event.email, name: event.name));
    }));

    on<LoadHomeScreenEvent>((event, emit) async {
      final token = await authService.getToken(); //Retrieve the token
      if (token != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Screens()));
        emit(LoadHomeScreenState(token: event.token));
        add(TabChangedEvent(tabIndex: 1));
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'Please Login');
      }
    });

    on<TabChangedEvent>(
      (event, emit) {
        emit(TabChangedState(tabIndex: event.tabIndex));
      },
    );

    on<AddToFavoriteEvent>(
      (event, emit) {
        emit(AddToFavoriteState(favoriteProduct: event.favoriteProduct));
      },
    );

    on<HomeScreenEvent>(
      (event, emit) {
        emit(HomeScreenState());
      },
    );

    on<ProductDetailScreenEvent>(
      (event, emit) {
        emit(ProductDetailScreenState(product: event.product));
      },
    );
  }
}
