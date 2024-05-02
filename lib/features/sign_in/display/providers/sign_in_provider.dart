import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/core/data_wrappers/data_result.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/log_in_use_case.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/sign_up_use_case.dart';

class SignInProvider with ChangeNotifier {

  final LogInUseCase logInUseCase;
  final SignUpUseCase signUpUseCase;

  SignInProvider({required this.logInUseCase, required this.signUpUseCase});

  Future<DataResult<UserCredential>> signIn(String email, String password) async {
    return await logInUseCase.call(email, password);
  }

  Future<DataResult<UserCredential>> signUp(String email, String password) async {
    return await signUpUseCase.call(email, password);
  }
}
