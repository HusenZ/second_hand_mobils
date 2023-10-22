import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_mobils/bloc/auth_bloc/auth_bloc.dart';
import 'package:second_hand_mobils/bloc/auth_bloc/auth_event.dart';
import 'package:second_hand_mobils/bloc/auth_bloc/auth_state.dart';
import 'package:second_hand_mobils/constants/global_variables.dart';
import 'package:second_hand_mobils/models/show_snack.dart';
import 'package:second_hand_mobils/widgets/custom_button.dart';
import 'package:second_hand_mobils/widgets/custom_text_field.dart';

enum Auth {
  signIn,
  signUp,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;

  final _singUpFormKey = GlobalKey<FormState>();
  final _singInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, appState) {},
          builder: (context, state) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ListTile(
                    tileColor: _auth == Auth.signUp
                        ? GlobalVariables.backgroundColor
                        : GlobalVariables.greyBackgroundCOlor,
                    title: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signUp,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      },
                    ),
                  ),
                  if (_auth == Auth.signUp)
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: GlobalVariables.backgroundColor,
                      child: Form(
                        key: _singUpFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: 'name',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (isLoading == true)
                              const CircularProgressIndicator(),
                            if (isLoading == false)
                              CustomButton(
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    if (_singUpFormKey.currentState!
                                        .validate()) {
                                      final String userName =
                                          _nameController.text;
                                      final String email =
                                          _emailController.text;
                                      final String password =
                                          _passwordController.text;
                                      context.read<AuthBloc>().add(
                                            SignUpEvent(
                                              userName: userName,
                                              email: email,
                                              password: password,
                                            ),
                                          );
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackBar(context, e.toString());
                                  }
                                },
                                text: 'Sign Up',
                              ),
                          ],
                        ),
                      ),
                    ),
                  ListTile(
                    tileColor: _auth == Auth.signIn
                        ? GlobalVariables.backgroundColor
                        : GlobalVariables.greyBackgroundCOlor,
                    title: const Text(
                      'Sign-In.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signIn,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      },
                    ),
                  ),
                  if (_auth == Auth.signIn)
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: GlobalVariables.backgroundColor,
                      child: Form(
                        key: _singInFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (isLoading == true)
                              const CircularProgressIndicator(),
                            if (isLoading == false)
                              CustomButton(
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    if (_singInFormKey.currentState!
                                        .validate()) {
                                      final String email =
                                          _emailController.text;
                                      final String password =
                                          _passwordController.text;
                                      // ignore: use_build_context_synchronously
                                      context.read<AuthBloc>().add(
                                            SignInEvent(
                                              email: email,
                                              password: password,
                                            ),
                                          );
                                    }
                                  } catch (e) {
                                    // ignore: use_build_context_synchronously
                                    showSnackBar(context, e.toString());
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                text: 'Sign In',
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
