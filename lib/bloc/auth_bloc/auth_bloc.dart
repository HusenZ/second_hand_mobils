import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:second_hand_mobils/bloc/auth_bloc/auth_event.dart';
import 'package:second_hand_mobils/bloc/auth_bloc/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:second_hand_mobils/models/show_snack.dart';
import 'package:second_hand_mobils/screens/home_screen.dart';
import 'package:second_hand_mobils/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BuildContext context;
  final AuthService authService = AuthService();
  AuthBloc(super.initialState, {required this.context}) {
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
      final String id = jsonDecode(response.body)['_id'];
      if (response.statusCode == 200) {
        authService.setToken(jsonDecode(response.body)['token']);
        add(LoadHomeScreenEvent(true));
        add(AuthenticatedEvent(userId: id));
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
      if (response.statusCode == 200) {
        authService.setToken(jsonDecode(response.body)['token']);
        add(LoadHomeScreenEvent(token));
        add(AuthenticatedEvent(userId: id));
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context, response.toString());
      }
    });

    on<AuthenticatedEvent>(((event, emit) {
      emit(AuthenticatedState(userId: event.userId));
    }));

    on<LoadHomeScreenEvent>((event, emit) async {
      final token = await authService.getToken(); //Retrieve the token
      if (token != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        emit(LoadHomeScreenState(token: event.token));
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'Please Login');
      }
    });
  }
}
