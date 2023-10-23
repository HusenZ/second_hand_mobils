import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_mobils/bloc/auth_bloc/auth_bloc.dart';
import 'package:second_hand_mobils/bloc/auth_bloc/auth_state.dart';
import 'package:second_hand_mobils/constants/global_variables.dart';
import 'package:second_hand_mobils/screens/auth_screen.dart';
import 'package:second_hand_mobils/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(
    MaterialApp(
      title: 'R G communication',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<AuthState> checkAuthentication() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('x-auth-token');

      if (token != null) {
        return AuthenticatedState(userId: token);
      } else {
        return InitialState();
      }
    }

    return FutureBuilder(
      future: checkAuthentication(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final initialState = snapshot.data as AuthState;

          return BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(context: context, initialState),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthenticatedState ||
                    state is LoadHomeScreenState) {
                  return const Screens();
                } else {
                  return const AuthScreen();
                }
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
