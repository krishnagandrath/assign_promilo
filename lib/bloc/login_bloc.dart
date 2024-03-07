import 'dart:async';

import 'package:assign_promilo/services/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FieldState { none, invalid, valid }

abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginLoadingState extends LoginState {}

// class LoginInvalidEmailState extends LoginState {}

class LoginEnableSubmitState extends LoginState {}

class LoginLoggedInState extends LoginState {}

class LoginFailedState extends LoginState {}

abstract class LoginEvent {}

// class LoginVerifyEmailEvent extends LoginEvent {
//   LoginVerifyEmailEvent({required this.email});
//   final String email;
// }

class LoginEmailAndPassEntered extends LoginEvent {
  LoginEmailAndPassEntered(this.email, this.password);

  final String email;
  final String password;
}

class LoginSubmitPressed extends LoginEvent {
  LoginSubmitPressed(this.email, this.password);
  final String email;
  final String password;
}

class LoginInitialState {}

class LoginbLOC extends Bloc<LoginEvent, LoginState> {
  LoginbLOC() : super(LoginInitState()) {
    // on<LoginVerifyEmailEvent>(verifyEmail);
    on<LoginEmailAndPassEntered>(verifyEmailAndPassword);
    on<LoginSubmitPressed>(handleLoginRequest);
  }

  // FutureOr<void> verifyEmail(
  //     LoginVerifyEmailEvent event, Emitter<LoginState> emit) {
  //   if (event.email.isEmpty || event.email.isEmpty) {
  //     emit(LoginInvalidEmailState());
  //   } else {
  //     emit(LoginInitState());
  //   }
  // }

  FutureOr<void> verifyEmailAndPassword(
      LoginEmailAndPassEntered event, Emitter<LoginState> emit) {
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      emit(LoginEnableSubmitState());
    }
  }

  // FutureOr<void> handleLogin(
  //     LoginSubmitPressed event, Emitter<LoginState> emit) {
  //   emit(LoginLoadingState());

  // }

  FutureOr<void> handleLoginRequest(
      LoginSubmitPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final result = await LoginService().checkLogin(event.email, event.password);

    if (result) {
      emit(LoginLoggedInState());
    } else {
      emit(LoginFailedState());
    }
  }
}
