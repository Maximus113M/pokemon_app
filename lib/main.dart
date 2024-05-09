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
  //lo convertimos en asincrono (async)
  WidgetsFlutterBinding.ensureInitialized();
  //future que inicializa la configuracion de firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //se inicializa el contenedor de dependencias
  DependencyInjection.configure();

  //metodo que ejecuta la app
  runApp(
    //instancia de Provider siendo padre de la app para poder accederse por todo el contexto a las instacias
    MultiProvider(
      //creacion de los providers que van a usarse
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignInProvider(
            logInUseCase: DependencyInjection.getIt.get<
                LogInUseCase>(), //se utiliza la DI para acceder a las instancias de los casos de uso
            signUpUseCase: DependencyInjection.getIt.get<SignUpUseCase>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DependencyInjection.getIt.get<
              GameProvider>(), //se puede crear la instancia del provider en el mismo contendor de DI
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
      //MaterialApp.router permite colocar la configuracion de goRouter
      child: MaterialApp.router(
        //configuracion de goRouter
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
