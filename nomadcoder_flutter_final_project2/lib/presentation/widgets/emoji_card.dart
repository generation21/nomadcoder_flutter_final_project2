import 'package:flutter/material.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/sizes.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_colors.dart';

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
