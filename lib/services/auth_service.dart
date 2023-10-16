import 'package:flutter/material.dart';
import 'package:second_hand_mobils/constants/error_handling.dart';
import 'package:second_hand_mobils/constants/global_variables.dart' show uri;
import 'package:second_hand_mobils/models/show_snack.dart';
import 'package:second_hand_mobils/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
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
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
