import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nomadcoder_flutter_final_project2/models/board/board_model.dart';
import 'package:nomadcoder_flutter_final_project2/providers/user/user_repository_provider.dart';
import 'package:nomadcoder_flutter_final_project2/repositories/board_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_repository_provider.g.dart';

@riverpod
BoardRepository boardRepository(Ref ref) {
  return BoardRepository(apiClient: apiClient(ref));
}

@riverpod
Future<List<BoardModel>> boardListProvider(Ref ref) async {
  try {
    final boardRepository = ref.watch(boardRepositoryProvider);
    return await boardRepository.getBoards();
  } catch (e) {
    print('보드 데이터 로딩 오류: $e');
    // 임시 데이터 반환으로 UI가 동작하도록 함
    return [
      BoardModel(
        mood: '테스트',
        text: '임시 데이터입니다.',
        relative_time: DateTime.now().toString(),
      ),
    ];
  }
}
