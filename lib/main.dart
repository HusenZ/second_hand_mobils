import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_mobils/bloc/app_bloc/app_bloc.dart';
import 'package:second_hand_mobils/bloc/app_bloc/app_state.dart';
import 'package:second_hand_mobils/constants/global_variables.dart';
import 'package:second_hand_mobils/screens/auth_screen.dart';
import 'package:second_hand_mobils/screens/product_details.dart';
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
    Future<AppState> checkAuthentication() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('x-auth-token');
      final email = prefs.getString('email');
      final name = prefs.getString('name');

      if (token != null && email != null && name != null) {
        return AuthenticatedState(
          userId: token,
          email: email,
          name: name,
        );
      } else {
        return InitialState();
      }
    }

    return FutureBuilder(
      future: checkAuthentication(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final initialState = snapshot.data as AppState;

          return BlocProvider<AppBloc>(
            create: (context) => AppBloc(context: context, initialState),
            child: BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                if (state is AuthenticatedState ||
                    state is LoadHomeScreenState ||
                    state is HomeScreenState ||
                    state is AddToFavoriteState ||
                    state is ProductDetailScreenState) {
                  return const Screens();
                } else if (state is ProductDetailScreenState) {
                  return ProductDetailsScreen(product: state.product);
                } else if (state is TabChangedState) {
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
