import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/gaps.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/router_const.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/sizes.dart';
import 'package:nomadcoder_flutter_final_project2/presentation/widgets/board_card.dart';
import 'package:nomadcoder_flutter_final_project2/providers/auth/auth_repository_provider.dart';
import 'package:nomadcoder_flutter_final_project2/providers/board/board_repository_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> deleteBoard(String id) async {
    final isOwner = await ref
        .read(boardRepositoryProvider)
        .isBoardOwner(boardId: id);
    if (isOwner) {
      ref.read(boardRepositoryProvider).deleteBoard(boardId: id);
      ref.invalidate(boardListProviderProvider);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('게시글 삭제 권한이 없습니다.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final boardsAsync = ref.watch(boardListProviderProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed:
                () => {
                  ref.read(authRepositoryProvider).signout(),
                  if (context.mounted) {context.go(RoutePath.signin)},
                },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: boardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('오류 발생: $error')),
        data: (boards) {
          if (boards.isEmpty) {
            return const Center(child: Text('게시글이 없습니다'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(boardListProviderProvider);
            },

            child: ListView.separated(
              itemCount: boards.length,
              separatorBuilder: (context, index) => Gaps.v8,
              itemBuilder: (context, index) {
                final board = boards[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size24,
                    vertical: Sizes.size8,
                  ),
                  child: GestureDetector(
                    onLongPress:
                        () => {
                          showCupertinoModalPopup(
                            context: context,
                            builder:
                                (context) => CupertinoActionSheet(
                                  title: const Text('Delete note'),
                                  message: const Text(
                                    'Are you sure you want to do this?',
                                  ),
                                  actions: [
                                    CupertinoActionSheetAction(
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        deleteBoard(board.id);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                          ),
                        },
                    child: BoardCard(board: board),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
