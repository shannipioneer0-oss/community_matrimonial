import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

class UniversalBackWrapper extends StatelessWidget {
  final Widget child;
  final bool isRoot;

  const UniversalBackWrapper({
    super.key,
    required this.child,
    this.isRoot = false
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Set to false to prevent the OS from taking control
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        // didPop is true if the pop already happened (e.g., via a button call)
        if (didPop) return;

        // Logic for Home Screen (Root)
        if (isRoot) {
          bool exitApp = await _confirmExit(context);
          if (exitApp) {
            SystemNavigator.pop(); // Standard way to exit on all Android versions
          }
        }
        // Logic for all other screens
        else {
          if (NavigationService.navigationKey.currentState!.canPop()) {
            NavigationService.navigationKey.currentState!.pop();
          } else {
            // Safety fallback: if no stack, just exit
            SystemNavigator.pop();
          }
        }
      },
      child: child,
    );
  }

  Future<bool> _confirmExit(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit"),
        content: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("No")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Yes")),
        ],
      ),
    ) ?? false;
  }
}