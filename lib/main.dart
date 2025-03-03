import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nomadcoder_flutter_final_project2/core/theme/app_theme.dart';
import 'package:nomadcoder_flutter_final_project2/firebase_options.dart';
import 'package:nomadcoder_flutter_final_project2/presentation/screens/sign_up/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mood tracker app',
      theme: AppTheme.lightTheme,

      home: const SignUpScreen(),
    );
  }
}
