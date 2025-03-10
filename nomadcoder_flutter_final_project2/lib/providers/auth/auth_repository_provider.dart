import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nomadcoder_flutter_final_project2/models/auth/user_model.dart';
import 'package:nomadcoder_flutter_final_project2/repositories/auth_repository.dart';
import 'package:nomadcoder_flutter_final_project2/repositories/base_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nomadcoder_flutter_final_project2/providers/user/user_repository_provider.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(userRepository: ref.watch(userRepositoryProvider));
}

@riverpod
Stream<User?> authStateStream(Ref ref) {
  return fbAuth.authStateChanges();
}

// ... existing code ...

// 현재 사용자를 AppUserModel로 변환하는 provider 추가
@riverpod
Future<AppUserModel?> currentUser(Ref ref) async {
  final authStateStream = ref.watch(authStateStreamProvider);

  return authStateStream.when(
    data: (user) {
      if (user == null) return null;
      return AppUserModel(id: user.uid, email: user.email ?? '');
    },
    error: (_, __) => null,
    loading: () => null,
  );
}

// 인증 상태를 추적하는 provider 추가
@riverpod
class AuthState extends _$AuthState {
  @override
  AsyncValue<bool> build() {
    final authState = ref.watch(authStateStreamProvider);
    return authState.when(
      data: (user) => AsyncValue.data(user != null),
      error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
      loading: () => const AsyncValue.loading(),
    );
  }

  // 로그인 메소드
  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signin(email: email, password: password)
          .then((_) => true),
    );
  }

  // 회원가입 메소드
  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signup(email: email, password: password)
          .then((_) => true),
    );
  }

  // 로그아웃 메소드
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signout().then((_) => false),
    );
  }
}
// ... existing code ...