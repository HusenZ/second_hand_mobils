import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:second_hand_mobils/constants/error_handling.dart';
import 'package:second_hand_mobils/constants/global_variables.dart' show uri;
import 'package:second_hand_mobils/models/show_snack.dart';
import 'package:second_hand_mobils/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:second_hand_mobils/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user
  Future<http.Response> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    User user = User(
      id: '',
      email: email,
      name: name,
      password: password,
      address: '',
      type: '',
      token: '',
    );
    http.Response res = await http.post(
      Uri.parse('$uri/api/signup'),
      body: user.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    // ignore: use_build_context_synchronously
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        showSnackBar(context,
            "Account has been created! Login with the same credentials");
      },
    );
    return res;
  }

  Future<http.Response> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    http.Response res = await http.post(
      Uri.parse('$uri/api/signin'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    // ignore: use_build_context_synchronously
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        // Store the token
        showSnackBar(context, "LoggedIn successfully!");
      },
    );
    return res;
  }

  // Get the token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('x-auth-token');
    return token;
  }

  // Set the token in SharedPreferences
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', token);
  }

  //log out feature
  void logOut(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('x-auth-token', '');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const AuthScreen(),
          ),
          (route) => false);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
