import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

String getBaseUrl() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return 'http://10.0.2.2:8000'; // Android Emulator
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return 'http://localhost:8000'; // iOS Simulator
  } else {
    return 'http://127.0.0.1:8000'; // Desktop (Mac/Windows/Linux)
  }
}