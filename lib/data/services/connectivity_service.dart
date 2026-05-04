import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  Stream<bool> get onlineStatus async* {
    final initialResults = await _connectivity.checkConnectivity();
    final initialIsOnline = _hasConnection(initialResults);
    debugPrint(
      '[Connectivity] initial results=$initialResults, isOnline=$initialIsOnline',
    );
    yield initialIsOnline;

    yield* _connectivity.onConnectivityChanged.map((results) {
      final isOnline = _hasConnection(results);
      debugPrint('[Connectivity] changed results=$results, isOnline=$isOnline');
      return isOnline;
    }).distinct();
  }

  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    final isOnline = _hasConnection(results);
    debugPrint('[Connectivity] check results=$results, isOnline=$isOnline');
    return isOnline;
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}
