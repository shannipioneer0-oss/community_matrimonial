import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UniversalBackWrapperCustom extends StatelessWidget {
  final Widget child;
  final VoidCallback onBackPress;

  const UniversalBackWrapperCustom({
    super.key,
    required this.child,
    required this.onBackPress,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: false is the most important part for Android 13+
      // It stops the OS from closing the app so your code can run.
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // This triggers your custom logic (dialog or index change)
        onBackPress();
      },
      child: child,
    );
  }
}