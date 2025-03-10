import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/gaps.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/router_const.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_colors.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_dimensions.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_text_styles.dart';
import 'package:nomadcoder_flutter_final_project2/core/utlis/auth_logic.dart';
import 'package:nomadcoder_flutter_final_project2/presentation/widgets/button.dart';
import 'package:nomadcoder_flutter_final_project2/presentation/widgets/snackbar_card.dart';
import 'package:nomadcoder_flutter_final_project2/providers/auth/auth_repository_provider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _obscurePassword = true;

  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await ref
          .read(authStateProvider.notifier)
          .signIn(email: email, password: password);
    }

    if (!mounted) return;

    final authState = ref.read(authStateProvider);

    if (authState.hasError) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBarCard.error(message: authState.error.toString()));
    } else if (!authState.isLoading) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBarCard.success(message: '로그인 성공!'));

      context.go(RoutePath.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final isLoading = authState.isLoading;

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
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.buttonRadius,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    validator: (value) => AuthLogic().isValidEmail(value ?? ''),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    onSaved: (value) {
                      email = value ?? '';
                    },
                    enabled: !isLoading,
                  ),
                  Gaps.v20,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: AppTextStyles.caption,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.buttonRadius,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    validator:
                        (value) => AuthLogic().isValidPassword(value ?? ''),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    onSaved: (value) {
                      password = value ?? '';
                    },
                    enabled: !isLoading,
                  ),
                  Gaps.v20,
                  Button(text: 'Enter', onTap: signIn),
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
