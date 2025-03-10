import 'package:flutter/material.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/gaps.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/sizes.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_colors.dart';
import 'package:nomadcoder_flutter_final_project2/models/board/board_model.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({super.key, required this.board});

  final BoardModel board;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            border: const Border(
              bottom: BorderSide(color: Colors.black, width: Sizes.size3),
              top: BorderSide(color: Colors.black, width: Sizes.size1),
              left: BorderSide(color: Colors.black, width: Sizes.size1),
              right: BorderSide(color: Colors.black, width: Sizes.size1),
            ),
            borderRadius: BorderRadius.circular(Sizes.size24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24,
              vertical: Sizes.size8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mood: ${board.mood}',
                  style: const TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v4,
                Text(board.text),
              ],
            ),
          ),
        ),
        Gaps.v8,
        Text(
          board.relative_time,
          style: const TextStyle(fontSize: Sizes.size12, color: Colors.grey),
        ),
      ],
    );
  }
}
