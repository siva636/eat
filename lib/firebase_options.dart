// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC2wnEOoIee_VFDO0KQILFjISBSTL2c5k0',
    appId: '1:93407217218:web:00c7436d1745fa038c0fdb',
    messagingSenderId: '93407217218',
    projectId: 'portfolio636',
    authDomain: 'portfolio636.firebaseapp.com',
    storageBucket: 'portfolio636.appspot.com',
    measurementId: 'G-3CHY6BYK0C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4OsDcIFJqAM-8c3FwXIxasfGhtiCXliA',
    appId: '1:93407217218:android:c84a3a4213ab15908c0fdb',
    messagingSenderId: '93407217218',
    projectId: 'portfolio636',
    storageBucket: 'portfolio636.appspot.com',
  );
}