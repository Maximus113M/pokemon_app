import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokemon_app/core/data_wrappers/data_result.dart';

abstract class SignInDatasource {
  //abstract Functions
  Future<DataResult<UserCredential>> signIn(String email, String password);
}

class SignInDatasourceImpl extends SignInDatasource {
  @override
  Future<DataResult<UserCredential>> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);     
      return DataResult(success: true, message: "Ingresaste a la cuenta correctamente", data: credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return DataResult(success: false, message: "No user found for that email", data: null);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return DataResult(success: false, message: "Wrong password provided for that user.", data: null);
      }
      return DataResult(success: false, message: e.message!, data: null);
    }
  }
}
