import 'package:flutter/material.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/sizes.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_colors.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_dimensions.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double width;

  const Button({
    super.key,
    required this.text,
    required this.onTap,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          border: const Border(
            top: BorderSide(color: AppColors.textPrimary, width: 2),
            left: BorderSide(color: AppColors.textPrimary, width: 2),
            bottom: BorderSide(color: AppColors.textPrimary, width: 4),
            right: BorderSide(color: AppColors.textPrimary, width: 4),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
