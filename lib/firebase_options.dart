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
        return ios;
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
    apiKey: 'AIzaSyBj13lc4JgFamVf9BSqo465KrjZjyua7zs',
    appId: '1:842119901350:web:fb04c1400528c4563c0467',
    messagingSenderId: '842119901350',
    projectId: 'healthful-886c2',
    authDomain: 'healthful-886c2.firebaseapp.com',
    databaseURL: 'https://healthful-886c2-default-rtdb.firebaseio.com',
    storageBucket: 'healthful-886c2.appspot.com',
    measurementId: 'G-HBQKRDJGQ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8UFghqn_PQgQGf8SKMZZ_qnwb0r2OM5g',
    appId: '1:842119901350:android:6d244c9076d12c9c3c0467',
    messagingSenderId: '842119901350',
    projectId: 'healthful-886c2',
    databaseURL: 'https://healthful-886c2-default-rtdb.firebaseio.com',
    storageBucket: 'healthful-886c2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHuicBihW_wl-5bkEQxZ6R9ANeHPGmAe8',
    appId: '1:842119901350:ios:496ca3a9a38a162c3c0467',
    messagingSenderId: '842119901350',
    projectId: 'healthful-886c2',
    databaseURL: 'https://healthful-886c2-default-rtdb.firebaseio.com',
    storageBucket: 'healthful-886c2.appspot.com',
    iosBundleId: 'com.healthful.healthful',
  );
}