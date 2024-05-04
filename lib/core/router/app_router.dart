import 'package:go_router/go_router.dart';
import 'package:pokemon_app/features/game/display/screens/game_screen.dart';
import 'package:pokemon_app/features/sign_in/display/screens/sign_in_screen.dart';
import 'package:pokemon_app/features/sign_in/display/screens/splash_screen.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/signIn',
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
    path: '/game',
    builder: (context, state) => const GameScreen(),
  ),
]);
