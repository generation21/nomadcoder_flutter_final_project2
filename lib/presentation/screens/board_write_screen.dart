import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/gaps.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/router_const.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/sizes.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_colors.dart';
import 'package:nomadcoder_flutter_final_project2/presentation/widgets/button.dart';
import 'package:nomadcoder_flutter_final_project2/providers/auth/auth_repository_provider.dart';
import 'package:nomadcoder_flutter_final_project2/providers/board/board_repository_provider.dart';

class BoardWriteScreen extends ConsumerStatefulWidget {
  const BoardWriteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BoardWriteScreenState();
}

class _BoardWriteScreenState extends ConsumerState<BoardWriteScreen> {
  int selectedEmojiIndex = -1;
  final List<String> emojis = ["😀", "😤", "🥲", "🫠", "🥰", "🤬", "😂", "🥹"];

  final TextEditingController _textController = TextEditingController();

  void _onPostButtonTap() {
    if (selectedEmojiIndex == -1) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select an emoji')));
      return;
    }

    if (_textController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please write a message')));
      return;
    }

    ref
        .read(boardRepositoryProvider)
        .createBoard(
          mood: emojis[selectedEmojiIndex],
          text: _textController.text,
          userId: ref.read(authRepositoryProvider).getCurrentUserId(),
        )
        .then((value) {
          if (mounted) {
            ref.invalidate(boardListProviderProvider);
            context.go(RoutePath.home);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v48,
              const Text(
                'How do you feel?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gaps.v16,
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Sizes.size12)),
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: Sizes.size3),
                    top: BorderSide(color: Colors.black, width: Sizes.size1),
                    left: BorderSide(color: Colors.black, width: Sizes.size1),
                    right: BorderSide(color: Colors.black, width: Sizes.size1),
                  ),
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: 7,
                  minLines: 7,
                  decoration: InputDecoration(
                    hintText: 'Write it down here!',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.normal,
                    ),
                    filled: true,
                    fillColor: AppColors.secondaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.size12),
                      borderSide: BorderSide.none,
                    ),

                    contentPadding: const EdgeInsets.symmetric(
                      vertical: Sizes.size12,
                      horizontal: Sizes.size12,
                    ),
                  ),
                ),
              ),
              Gaps.v24,
              const Text("What's your mood?"),
              Gaps.v8,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < emojis.length; i++) ...[
                    Gaps.h12,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedEmojiIndex = i;
                        });
                      },
                      child: EmojiCard(
                        index: i,
                        emoji: emojis[i],
                        selectedEmojiIndex: selectedEmojiIndex,
                      ),
                    ),
                  ],
                ],
              ),
              Gaps.v56,
              Center(
                child: Button(
                  text: "Post",
                  onTap: _onPostButtonTap,
                  width: Sizes.size96 * 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmojiCard extends StatelessWidget {
  final int index;
  final String emoji;
  final int selectedEmojiIndex;

  const EmojiCard({
    super.key,
    required this.index,
    required this.emoji,
    required this.selectedEmojiIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.size6),
      decoration: BoxDecoration(
        color:
            selectedEmojiIndex == index ? AppColors.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size4),
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: Sizes.size3),
          top: BorderSide(color: Colors.black, width: Sizes.size1),
          left: BorderSide(color: Colors.black, width: Sizes.size1),
          right: BorderSide(color: Colors.black, width: Sizes.size1),
        ),
      ),
      alignment: Alignment.center,
      child: Text(emoji, textAlign: TextAlign.center),
    );
  }
}
