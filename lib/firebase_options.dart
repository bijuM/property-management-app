import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        return android;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXUrquS_Aw-N3T76AVxVreWGtuSUkOKg4',
    appId: '1:938320861231:android:cae1f34a4ccf3566e88eda',
    messagingSenderId: '938320861231',
    projectId: 'investment-calculator-811fd',
    storageBucket: 'investment-calculator-811fd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXUrquS_Aw-N3T76AVxVreWGtuSUkOKg4',
    appId: '1:938320861231:android:cae1f34a4ccf3566e88eda',
    messagingSenderId: '938320861231',
    projectId: 'investment-calculator-811fd',
    storageBucket: 'investment-calculator-811fd.firebasestorage.app',
    iosBundleId: 'villa.management.app',
  );

  static const FirebaseOptions macos = ios;

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXUrquS_Aw-N3T76AVxVreWGtuSUkOKg4',
    appId: '1:938320861231:android:cae1f34a4ccf3566e88eda',
    messagingSenderId: '938320861231',
    projectId: 'investment-calculator-811fd',
    storageBucket: 'investment-calculator-811fd.firebasestorage.app',
  );

  static const FirebaseOptions linux = windows;

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDXUrquS_Aw-N3T76AVxVreWGtuSUkOKg4',
    appId: '1:938320861231:android:cae1f34a4ccf3566e88eda',
    messagingSenderId: '938320861231',
    projectId: 'investment-calculator-811fd',
    authDomain: 'investment-calculator-811fd.firebaseapp.com',
    storageBucket: 'investment-calculator-811fd.firebasestorage.app',
  );
}
