import 'package:flutter/material.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/sizes.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_colors.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_dimensions.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_text_styles.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double width;
  final bool isLoading;

  const Button({
    super.key,
    required this.text,
    required this.onTap,
    this.width = double.infinity,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        decoration: BoxDecoration(
          color:
              isLoading
                  ? AppColors.primaryColor.withOpacity(0.7)
                  : AppColors.primaryColor,
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          border: const Border(
            top: BorderSide(color: AppColors.textPrimary, width: 2),
            left: BorderSide(color: AppColors.textPrimary, width: 2),
            bottom: BorderSide(color: AppColors.textPrimary, width: 4),
            right: BorderSide(color: AppColors.textPrimary, width: 4),
          ),
        ),
        child:
            isLoading
                ? const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  ),
                )
                : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.button,
                ),
      ),
    );
  }
}
