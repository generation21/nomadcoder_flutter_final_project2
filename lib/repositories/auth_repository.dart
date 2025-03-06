import 'package:firebase_auth/firebase_auth.dart';
import 'package:nomadcoder_flutter_final_project2/repositories/base_repository.dart';

class AuthRepository {
  User? get currentUser => fbAuth.currentUser;

  Future<void> signup({required String email, required String password}) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // final signedInUser = userCredential.user!;

      // nickname을 userCollection에 저장
      // await usersCollection.doc(signedInUser.uid).set({'email': email});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signin({required String email, required String password}) async {
    try {
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signout() async {
    try {
      await fbAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
