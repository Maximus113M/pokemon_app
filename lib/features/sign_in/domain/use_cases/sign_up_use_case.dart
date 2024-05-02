import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokemon_app/core/data_wrappers/data_result.dart';
import 'package:pokemon_app/features/sign_in/domain/respositories/sign_in_repository.dart';

class SignUpUseCase {
  //Code
  final SignInRepository signInRepository;

  SignUpUseCase({required this.signInRepository});

  Future<DataResult<UserCredential>> call(String email, String password) {
    return signInRepository.signUp(email, password);
  }
}
