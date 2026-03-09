import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
// You may need to add package_info_plus to your pubspec.yaml to detect the package name
// or use a Global variable set in your main() flavor config.

class DefaultFirebaseOptions2 {
  // We add a static variable that we can set in main.dart
  static String? currentPackageName;

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) throw UnsupportedError('Web not configured');

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      // LOGIC: If the package ends in .appb, return the AppB options
        if (currentPackageName?.endsWith('.appb') ?? false) {
          return androidAppB;
        }

        print(currentPackageName.toString()+"====");
        return android; // Default to AppA
      default:
        throw UnsupportedError('Platform not supported');
    }
  }


  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcyIwNHXPBTiCGECmyHuyeHMk2Ldd9S9g',
    appId: '1:371992800955:android:46ec48ec5f8d881d4ac39e', // App A
    messagingSenderId: '371992800955',
    projectId: 'ravaldev-matrimony',
    storageBucket: 'ravaldev-matrimony.firebasestorage.app',
  );


  static const FirebaseOptions androidAppB = FirebaseOptions(
    apiKey: 'AIzaSyCcyIwNHXPBTiCGECmyHuyeHMk2Ldd9S9g',
    appId: '1:371992800955:android:d8581f46d0d52e784ac39e', // App B
    messagingSenderId: '371992800955',
    projectId: 'ravaldev-matrimony',
    storageBucket: 'ravaldev-matrimony.firebasestorage.app',
  );

}