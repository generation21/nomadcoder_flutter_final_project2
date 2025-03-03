import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/gaps.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/sizes.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_colors.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_dimensions.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_text_styles.dart';
import 'package:nomadcoder_flutter_final_project2/presentation/widgets/button.dart';

class SingUpScreen extends ConsumerStatefulWidget {
  const SingUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends ConsumerState<SingUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "🔥 MOOD 🔥",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppDimensions.fontLg,
            fontWeight: AppTextStyles.headline1.fontWeight,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Join!"),
            TextField(
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: AppTextStyles.bodyText3,
              ),
            ),
            const SizedBox(height: AppDimensions.md),
            TextField(
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: AppTextStyles.bodyText3,
              ),
            ),
            Gaps.v20,
            Button(text: 'Create Account', onTap: () {}),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: Sizes.size96,
        color: AppColors.secondaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.xxl),
          child: Column(children: [Button(text: 'Log in ->', onTap: () {})]),
        ),
      ),
    );
  }
}
