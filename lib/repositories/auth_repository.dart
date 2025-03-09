import 'package:firebase_auth/firebase_auth.dart';
import 'package:nomadcoder_flutter_final_project2/repositories/base_repository.dart';
import 'package:nomadcoder_flutter_final_project2/repositories/user_repository.dart';

class AuthRepository {
  User? get currentUser => fbAuth.currentUser;
  final UserRepository _userRepository;

  AuthRepository({required UserRepository userRepository})
    : _userRepository = userRepository;

  Future<void> signup({required String email, required String password}) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredential.user!;

      // 자체 서버에 사용자 정보 등록
      await _userRepository.createUser(
        firebaseUid: signedInUser.uid,
        email: email,
      );
    } catch (e) {
      // Firebase 인증은 성공했지만 자체 서버 등록에 실패한 경우
      if (e is Exception && currentUser != null) {
        // Firebase에서 사용자 삭제
        try {
          await currentUser!.delete();
        } catch (deleteError) {
          // 사용자 삭제 실패 시 추가 로깅
          print('Firebase 사용자 삭제 실패: $deleteError');
        }
        throw Exception('회원가입 중 오류가 발생했습니다. 자체 서버 등록 실패: $e');
      }
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

  String getCurrentUserId() {
    final user = currentUser;
    if (user == null) {
      throw Exception('사용자가 로그인되지 않았습니다.');
    }
    return user.uid;
  }
}
