import 'package:dio/dio.dart';
import 'package:nomadcoder_flutter_final_project2/core/network/api_client.dart';
import 'package:nomadcoder_flutter_final_project2/models/board/board_model.dart';
import 'package:nomadcoder_flutter_final_project2/repositories/auth_repository.dart';

class BoardRepository {
  final ApiClient _apiClient;

  final String _prefix = '/boards';
  BoardRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  // 게시글 목록 가져오기
  Future<List<BoardModel>> getBoards() async {
    try {
      final response = await _apiClient.get('$_prefix/all');
      return (response.data as List)
          .map((json) => BoardModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('게시글 목록을 가져오는데 실패했습니다: ${e.message}');
    } catch (e) {
      throw Exception('예상치 못한 오류가 발생했습니다: $e');
    }
  }

  // 게시글 생성하기
  Future<BoardModel> createBoard({
    required String mood,
    required String text,
    required String userId,
  }) async {
    Options options = Options(headers: {'current-user-id': userId});
    try {
      final response = await _apiClient.post(
        '$_prefix/create',
        options: options,
        data: {'mood': mood, 'text': text},
      );
      return BoardModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('게시글 생성에 실패했습니다: ${e.message}');
    } catch (e) {
      throw Exception('예상치 못한 오류가 발생했습니다: $e');
    }
  }

  // 게시글 삭제하기
  Future<void> deleteBoard({
    required String boardId,
    required String userId,
  }) async {
    Options options = Options(headers: {'current-user-id': userId});
    try {
      await _apiClient.delete('$_prefix/delete/$boardId', options: options);
    } on DioException catch (e) {
      throw Exception('게시글 삭제에 실패했습니다: ${e.message}');
    } catch (e) {
      throw Exception('예상치 못한 오류가 발생했습니다: $e');
    }
  }

  Future<bool> isBoardOwner({
    required String boardId,
    required String userId,
  }) async {
    Options options = Options(headers: {'current-user-id': userId});
    try {
      final response = await _apiClient.get(
        '$_prefix/check_owner/$boardId',
        options: options,
      );
      return response.data['is_owner'];
    } on DioException catch (e) {
      throw Exception('게시글 소유자 확인에 실패했습니다: ${e.message}');
    }
  }
}
