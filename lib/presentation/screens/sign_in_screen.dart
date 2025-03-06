import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/gaps.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/router_const.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_colors.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_dimensions.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_text_styles.dart';
import 'package:nomadcoder_flutter_final_project2/presentation/widgets/button.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  String? isValidEmail(String value) {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }

  String? isValidPassword(String value) {
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.xxl),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gaps.v128,
                  Text("Welcome!", style: AppTextStyles.bodyText1),
                  Gaps.v20,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: AppTextStyles.caption,
                    ),
                    validator: (value) => isValidEmail(value ?? ''),
                    onSaved: (value) {
                      email = value ?? '';
                    },
                  ),
                  Gaps.v20,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: AppTextStyles.caption,
                    ),
                    validator: (value) => isValidPassword(value ?? ''),
                    onSaved: (value) {
                      password = value ?? '';
                    },
                  ),
                  Gaps.v20,
                  Button(
                    text: 'Enter',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        print(email);
                        print(password);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.xxl,
                ),
                child: Column(
                  children: [
                    Button(
                      text: 'Create an account ->',
                      onTap: () => context.goNamed(RouteNames.signup),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
