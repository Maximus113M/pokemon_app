import 'package:flutter/material.dart';
import 'package:pokemon_app/core/router/app_router.dart';
import 'package:pokemon_app/core/util/app_functions.dart';
import 'package:pokemon_app/core/util/in_app_notification.dart';
import 'package:pokemon_app/core/data_wrappers/data_result.dart';
import 'package:pokemon_app/features/game/display/providers/game_provider.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/log_in_use_case.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/sign_up_use_case.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInProvider with ChangeNotifier {
  final LogInUseCase logInUseCase;
  final SignUpUseCase signUpUseCase;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoggingIn = false;
  bool isCheckingIn = false;

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
        !AppFunctions.emailRegExp.hasMatch(emailController.text.trim())) {
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
    if (isLoggingIn) return;
    isLoggingIn = true;
    notifyListeners();

    if (!validateEmail() || !validatePassword()) {
      InAppNotification.invalidEmailAndPassword(context: context);
      return;
    }
    await signIn(emailController.text, passwordController.text).then((result) {
      if (!result.success) {
        //notificar
        isLoggingIn = false;
        notifyListeners();
        InAppNotification.serverFailure(
            context: context, message: result.message);
        return;
      }
      emailController.clear();
      passwordController.clear();
      context.read<GameProvider>().initGame();
      InAppNotification.successfulSignUp(context: context);
      //Navegar a la siguiente ruta
      appRouter.go("/game");
      isLoggingIn = false;
    });
  }

  Future<void> validateSignUp(BuildContext context) async {
    if (isCheckingIn) return;
    isCheckingIn = true;
    notifyListeners();

    if (!validateEmail() || !validatePassword()) {
      InAppNotification.invalidEmailAndPassword(context: context);
      return;
    }
    await signUp(emailController.text.trim(), passwordController.text.trim())
        .then((result) {
      if (!result.success) {
        isCheckingIn = false;
        notifyListeners();
        //notificar
        InAppNotification.serverFailure(
            context: context, message: result.message);
        return;
      }
      emailController.clear();
      passwordController.clear();
      //Navegar a la siguiente ruta
      context.read<GameProvider>().initGame();
      appRouter.go("/game");
      isCheckingIn = false;
    });
  }

  Future<void> checkAuthenticated(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (FirebaseAuth.instance.currentUser != null) {
      Future.microtask(() {
        context.read<GameProvider>().initGame();
        appRouter.go("/game");
      });
    } else {
      appRouter.go("/signIn");
    }
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    appRouter.go("/signIn");
  }
}
