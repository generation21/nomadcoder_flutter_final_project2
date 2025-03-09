import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nomadcoder_flutter_final_project2/core/network/api_client.dart';
import 'package:nomadcoder_flutter_final_project2/models/auth/user_model.dart';
import 'package:nomadcoder_flutter_final_project2/providers/auth/auth_repository_provider.dart';
import 'package:nomadcoder_flutter_final_project2/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient(
    getCurrentUserId: () async {
      final authState = ref.read(authStateStreamProvider).value;
      return authState?.uid;
    },
  );
}

// 사용자 저장소 프로바이더
@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository(apiClient: apiClient(ref));
}

// 현재 사용자 정보 프로바이더
@riverpod
Future<AppUserModel> userDetail(Ref ref, {required String userId}) {
  return ref.watch(userRepositoryProvider).getUserById(userId);
}

// 사용자 생성 상태 관리 프로바이더
@riverpod
class UserCreation extends _$UserCreation {
  @override
  AsyncValue<AppUserModel?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> createUser({
    required String id,
    required String email,
    String? name,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(userRepositoryProvider)
          .createUser(firebaseUid: id, email: email),
    );
  }
}
