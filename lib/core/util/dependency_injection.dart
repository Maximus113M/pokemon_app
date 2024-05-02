import 'package:get_it/get_it.dart';
import 'package:pokemon_app/features/sign_in/data/datasources/sign_in_datasource.dart';
import 'package:pokemon_app/features/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:pokemon_app/features/sign_in/domain/use_cases/log_in_use_case.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.instance;

  static void configure() {
    configureSignIn();
  }

  static void configureSignIn() {
    // Data source class
    getIt.registerSingleton<SignInDatasourceImpl>(SignInDatasourceImpl());
    // Repository Implementation class
    getIt.registerSingleton<SignInRepositoryImpl>(SignInRepositoryImpl(datasource: getIt.get<SignInDatasourceImpl>()));
    // Use case
    getIt.registerSingleton<LogInUseCase>(LogInUseCase(signInRepository: getIt.get<SignInRepositoryImpl>()));
  }
}