import 'package:flutter/material.dart';
import 'package:second_hand_mobils/constants/global_variables.dart';
import 'package:second_hand_mobils/services/auth_service.dart';

class UserLogOutScreen extends StatelessWidget {
  const UserLogOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: const Text('Log Out page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AuthService authService = AuthService();
            authService.logOut(context);
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(23),
          ),
          child: const Text(
            'Sign Out',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
