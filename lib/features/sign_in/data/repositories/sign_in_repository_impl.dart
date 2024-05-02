import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokemon_app/core/data_wrappers/data_result.dart';
import 'package:pokemon_app/features/sign_in/data/datasources/sign_in_datasource.dart';
import 'package:pokemon_app/features/sign_in/domain/respositories/sign_in_repository.dart';

class SignInRepositoryImpl extends SignInRepository {
  
  //Code

  final SignInDatasource datasource;

  SignInRepositoryImpl({required this.datasource});

  @override
  Future<DataResult<UserCredential>> signIn(String email, String password) {
    return datasource.signIn(email, password);
  }
  
  @override
  Future<DataResult<UserCredential>> signUp(String email, String password) {
    return datasource.signUp(email, password);
  }
}
