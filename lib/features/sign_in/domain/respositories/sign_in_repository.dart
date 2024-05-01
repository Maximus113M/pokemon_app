import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokemon_app/core/data_wrappers/data_result.dart';

abstract class SignInRepository {

  Future<DataResult<UserCredential>> signIn(String email, String password);

}
