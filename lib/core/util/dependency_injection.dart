import 'package:get_it/get_it.dart';
import 'package:pokemon_app/features/game/data/datasources/game_datasource.dart';
import 'package:pokemon_app/features/game/data/repositories/game_repository_impl.dart';
import 'package:pokemon_app/features/game/display/providers/game_provider.dart';
import 'package:pokemon_app/features/game/domain/respositories/game_repository.dart';
import 'package:pokemon_app/features/game/domain/use_cases/get_pokemons_use_case.dart';
import 'package:pokemon_app/features/sign_in/data/datasources/sign_in_datasource.dart';
import 'package:pokemon_app/features/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/log_in_use_case.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/sign_up_use_case.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.instance;

  static void configure() {
    configureSignIn();
    configureGame();
  }

  static void configureSignIn() {
    // Data source class
    getIt.registerSingleton<SignInDatasourceImpl>(SignInDatasourceImpl());
    // Repository Implementation class
    getIt.registerSingleton<SignInRepositoryImpl>(
        SignInRepositoryImpl(datasource: getIt.get<SignInDatasourceImpl>()));
    // Use case Log in
    getIt.registerSingleton<LogInUseCase>(
        LogInUseCase(signInRepository: getIt.get<SignInRepositoryImpl>()));
    // Use case Sign up
    getIt.registerSingleton<SignUpUseCase>(
        SignUpUseCase(signInRepository: getIt.get<SignInRepositoryImpl>()));
  }

  static void configureGame() {
    // Data source class
    getIt.registerSingleton<GameDatasource>(GameDatasourceImpl());
    // Repository Implementation class
    getIt.registerSingleton<GameRepositoryImpl>(
        GameRepositoryImpl(gameDatasource: getIt.get<GameDatasource>()));
    // Use case Log in
    getIt.registerSingleton<GetPokemonsUseCase>(
        GetPokemonsUseCase(gameRepository: getIt.get<GameRepositoryImpl>()));
    // Provider
    getIt.registerSingleton<GameProvider>(
        GameProvider(getPokemonsUseCase: getIt.get<GetPokemonsUseCase>()));
  }
}
