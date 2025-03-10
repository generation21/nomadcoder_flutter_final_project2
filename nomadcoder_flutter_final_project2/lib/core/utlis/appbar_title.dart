import 'package:flutter/material.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_colors.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_dimensions.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_text_styles.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "🔥 MOOD 🔥",
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: AppDimensions.fontLg,
        fontWeight: AppTextStyles.headline1.fontWeight,
      ),
    );
  }
}
