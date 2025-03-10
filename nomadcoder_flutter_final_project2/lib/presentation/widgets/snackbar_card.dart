import 'package:flutter/material.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/sizes.dart';

class SnackBarCard {
  static SnackBar success({required String message}) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.size12),
          topRight: Radius.circular(Sizes.size12),
        ),
      ),
    );
  }

  static SnackBar error({required String message}) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.size12),
          topRight: Radius.circular(Sizes.size12),
        ),
      ),
    );
  }

  static SnackBar info({required String message}) {
    return SnackBar(content: Text(message), backgroundColor: Colors.blue);
  }

  static SnackBar warning({required String message}) {
    return SnackBar(content: Text(message), backgroundColor: Colors.orange);
  }
}
