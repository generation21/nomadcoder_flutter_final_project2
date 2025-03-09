import 'package:dio/dio.dart';
import 'package:nomadcoder_flutter_final_project2/core/network/api_client.dart';
import 'package:nomadcoder_flutter_final_project2/models/auth/user_model.dart';

class UserRepository {
  final ApiClient _apiClient;
  final String _prefix = '/users';
  UserRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  // 사용자 정보 가져오기
  Future<AppUserModel> getUserById(String userId) async {
    try {
      final response = await _apiClient.get('$_prefix/$userId');
      return AppUserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('사용자 정보를 가져오는데 실패했습니다: ${e.message}');
    } catch (e) {
      throw Exception('예상치 못한 오류가 발생했습니다: $e');
    }
  }

  // 사용자 생성하기
  Future<AppUserModel> createUser({
    required String firebaseUid,
    required String email,
  }) async {
    try {
      final response = await _apiClient.post(
        '$_prefix/create',
        data: {'firebase_uid': firebaseUid, 'email': email},
      );
      return AppUserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('사용자 생성에 실패했습니다: ${e.message}');
    } catch (e) {
      throw Exception('예상치 못한 오류가 발생했습니다: $e');
    }
  }
}
