import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/core/data_wrappers/data_result.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/log_in_use_case.dart';

class SignInProvier with ChangeNotifier {

  final LogInUseCase logInUseCase;

  SignInProvier({required this.logInUseCase});

  Future<DataResult<UserCredential>> signIn(String email, String password) {
    return logInUseCase.call(email, password);
  }
}
