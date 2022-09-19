import 'package:mobi_lab_shopping_list_app/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_service.dart';
import 'package:mobi_lab_shopping_list_app/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthService dbAuth = AuthService();
  @override
  Future<UserModel> authAnon() {
    return dbAuth.anonSignIn();
  }

  @override
  Future<void> authEmailAndPass(String email, String password) {
    return dbAuth.signUp(email: email, password: password);
  }

  @override
  Future<void> logInEmailAndPass(String email, String password) {
    return dbAuth.logInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> authOut() {
    return dbAuth.logOut();
  }
}
