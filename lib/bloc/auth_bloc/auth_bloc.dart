import 'package:flutter/material.dart';
import 'package:second_hand_mobils/bloc/auth_bloc/auth_event.dart';
import 'package:second_hand_mobils/bloc/auth_bloc/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:second_hand_mobils/services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BuildContext context;
  AuthBloc(super.initialState, {required this.context}) {
    on<LoginEvent>(
      (event, emit) => LoginState(
        email: event.email,
        password: event.password,
      ),
    );
    on<SignUpEvent>((event, emit) {
      SignUpState(
        userName: event.userName,
        email: event.email,
        password: event.password,
      );
      AuthService().signUpUser(
        context: context,
        email: event.email,
        password: event.password,
        name: event.userName,
      );
    });
  }
}
