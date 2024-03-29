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
    apiKey: 'AIzaSyDPOdUXTdTK1A3EuTe-UPQ63X5SqpkU89s',
    appId: '1:757478710267:web:79fa3e8d3d528a1414495e',
    messagingSenderId: '757478710267',
    projectId: 'invention-plus',
    authDomain: 'invention-plus.firebaseapp.com',
    databaseURL: 'https://invention-plus-default-rtdb.firebaseio.com',
    storageBucket: 'invention-plus.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIO1gj0KOLv_yr5-zYIbox7Wg7q4uBens',
    appId: '1:757478710267:android:e8a5fa0ed83618ed14495e',
    messagingSenderId: '757478710267',
    projectId: 'invention-plus',
    databaseURL: 'https://invention-plus-default-rtdb.firebaseio.com',
    storageBucket: 'invention-plus.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyATzoDSgxHNlTtdcEXiQ1gg2WHs2r-qOYI',
    appId: '1:757478710267:ios:8720368596516b1514495e',
    messagingSenderId: '757478710267',
    projectId: 'invention-plus',
    databaseURL: 'https://invention-plus-default-rtdb.firebaseio.com',
    storageBucket: 'invention-plus.appspot.com',
    iosClientId: '757478710267-4ebtr6qnjb5k22i712l78d9u5b9qd5to.apps.googleusercontent.com',
    iosBundleId: 'com.example.weldingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyATzoDSgxHNlTtdcEXiQ1gg2WHs2r-qOYI',
    appId: '1:757478710267:ios:8720368596516b1514495e',
    messagingSenderId: '757478710267',
    projectId: 'invention-plus',
    databaseURL: 'https://invention-plus-default-rtdb.firebaseio.com',
    storageBucket: 'invention-plus.appspot.com',
    iosClientId: '757478710267-4ebtr6qnjb5k22i712l78d9u5b9qd5to.apps.googleusercontent.com',
    iosBundleId: 'com.example.weldingApp',
  );
}
