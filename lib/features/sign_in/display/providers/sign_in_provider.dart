import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/core/data_wrappers/data_result.dart';
import 'package:pokemon_app/core/util/app_functions.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/log_in_use_case.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/sign_up_use_case.dart';

class SignInProvider with ChangeNotifier {
  final LogInUseCase logInUseCase;
  final SignUpUseCase signUpUseCase;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInProvider({required this.logInUseCase, required this.signUpUseCase});

  Future<DataResult<UserCredential>> signIn(
      String email, String password) async {
    return await logInUseCase.call(email, password);
  }

  Future<DataResult<UserCredential>> signUp(
      String email, String password) async {
    return await signUpUseCase.call(email, password);
  }

  bool validateEmail() {
    if (emailController.text.trim().isEmpty ||
        !AppFunctions.emailRegExp.hasMatch(emailController.text)) {
      //NOTIFICAR
      return false;
    }
    return true;
  }

  bool validatePassword() {
    if (passwordController.text.trim().isEmpty ||
        passwordController.text.length < 6) {
      //NOTIFICAR
      return false;
    }
    return true;
  }

  Future<void> validateLogIn(BuildContext context) async {
    if (!validateEmail() || !validatePassword()) return;
    final result = await signIn(emailController.text, passwordController.text);
    if (result.data == null) {
      //notificar
    }
    //Navegar a la siguiente ruta
    context.pushReplacement('/game');
  }
}
