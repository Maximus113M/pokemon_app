import 'package:flutter/material.dart';
import 'package:pokemon_app/core/router/app_router.dart';
import 'package:pokemon_app/core/util/dependency_injection.dart';
import 'package:pokemon_app/features/game/display/providers/game_provider.dart';
import 'package:pokemon_app/features/sign_in/display/providers/sign_in_provider.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/log_in_use_case.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/sign_up_use_case.dart';

import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection.configure();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignInProvider(
            logInUseCase: DependencyInjection.getIt.get<LogInUseCase>(),
            signUpUseCase: DependencyInjection.getIt.get<SignUpUseCase>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DependencyInjection.getIt.get<GameProvider>(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
