import 'package:second_hand_mobils/bloc/auth_bloc/auth_event.dart';
import 'package:second_hand_mobils/bloc/auth_bloc/auth_state.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(super.initialState) {
    on<LoginEvent>(
      (event, emit) => LoginState(
        email: event.email,
        password: event.password,
      ),
    );
    on<SignUpEvent>(
      (event, emit) => SignUpState(
        userName: event.userName,
        email: event.email,
        password: event.password,
      ),
    );
  }
}
