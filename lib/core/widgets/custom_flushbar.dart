import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../services/localizations/localizations.dart';

class CustomFlushbar {
  static void showDefaultErrorFlushbar(BuildContext context,
      {String? errorCode}) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var localization = AppLocalization.of(context)!;

      Flushbar<List<String>>(
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 15),
        userInputForm: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(localization.getString(errorDefaultMessage)),
            ],
          ),
        ),
      ).show(context);
    });
  }

  static void showErrorFlushbar(BuildContext context, String message) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Flushbar<List<String>>(
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 15),
        userInputForm: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(message),
            ],
          ),
        ),
      ).show(context);
    });
  }
}
