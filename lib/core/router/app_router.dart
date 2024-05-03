import 'package:go_router/go_router.dart';
import 'package:pokemon_app/features/game/display/screens/game_screen.dart';
import 'package:pokemon_app/features/sign_in/display/screens/sign_in_screen.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => SignInScreen(),
  ),
  GoRoute(
    path: '/game',
    builder: (context, state) => const GameScreen(),
  ),
]);
