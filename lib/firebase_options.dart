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
        return macos;
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
    apiKey: 'AIzaSyA4iLUwvXZkR66ykwdxxGx68EkEgfHyxco',
    appId: '1:1098564229252:web:e63024f1320dde0d254ad1',
    messagingSenderId: '1098564229252',
    projectId: 'flutterdata1-86878',
    authDomain: 'flutterdata1-86878.firebaseapp.com',
    storageBucket: 'flutterdata1-86878.appspot.com',
    measurementId: 'G-RFFFYFWS59',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFO9DjonqCBFi5UASsTS21Y-FJ0n7VoGs',
    appId: '1:1098564229252:android:8c602ea2e1998b5e254ad1',
    messagingSenderId: '1098564229252',
    projectId: 'flutterdata1-86878',
    storageBucket: 'flutterdata1-86878.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgIYFnWaQzABOOat68HWTxQ6Bd-a_wt6U',
    appId: '1:1098564229252:ios:dfcb74bb7d4e43a2254ad1',
    messagingSenderId: '1098564229252',
    projectId: 'flutterdata1-86878',
    storageBucket: 'flutterdata1-86878.appspot.com',
    iosClientId: '1098564229252-ttajc9pgenbf22lhdbjulu1gok6n92fa.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterData1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgIYFnWaQzABOOat68HWTxQ6Bd-a_wt6U',
    appId: '1:1098564229252:ios:dfcb74bb7d4e43a2254ad1',
    messagingSenderId: '1098564229252',
    projectId: 'flutterdata1-86878',
    storageBucket: 'flutterdata1-86878.appspot.com',
    iosClientId: '1098564229252-ttajc9pgenbf22lhdbjulu1gok6n92fa.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterData1',
  );
}
