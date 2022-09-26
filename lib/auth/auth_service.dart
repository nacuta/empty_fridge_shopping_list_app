// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mobi_lab_shopping_list_app/auth/auth_repository.dart';
// import 'package:mobi_lab_shopping_list_app/models/user_model.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<UserModel> anonSignIn() async {
//     final userCredential = await _auth.signInAnonymously();
//     return UserModel(id: userCredential.user!.uid);
//   }

//   // static UserModel get user1{
//   //   return  user;
//   // }
//   static const userCacheKey = '__user_cache_key__';
//   Stream<UserModel> get user {
//     return _auth.authStateChanges().map((firebaseUser) {
//       final user = firebaseUser == null
//           ? UserModel.empthy
//           : UserModel(
//               id: firebaseUser.uid,
//               isAnonymous: firebaseUser.isAnonymous,
//             );
//       return user;
//     });
//   }

//   Future<void> signUp({required String email, required String password}) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
//     } catch (_) {
//       throw SignUpWithEmailAndPasswordFailure();
//     }
//   }

//   Future<void> logInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
//     } catch (_) {
//       throw LogInWithEmailAndPasswordFailure();
//     }
//   }

//   Future<void> logOut() async {
//     try {
//       await Future.wait([
//         _auth.signOut(),
//       ]);
//     } catch (_) {
//       throw LogOutFailure();
//     }
//   }
// }
