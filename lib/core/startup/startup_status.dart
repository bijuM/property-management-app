import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartupStatus {
  final bool firebaseInitialized;
  final String? firebaseError;

  const StartupStatus({
    this.firebaseInitialized = false,
    this.firebaseError,
  });

  bool get hasFirebaseError => firebaseError != null;
}

final startupStatusProvider = Provider<StartupStatus>((ref) {
  return const StartupStatus();
});
