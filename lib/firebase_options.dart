// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2sZgf0ugmaIqoMnwSvnvhnKAs4wPD9B4',
    appId: '1:47606691109:android:e9b224689a2f660082d6cc',
    messagingSenderId: '47606691109',
    projectId: 'thaughts-9aef7',
    databaseURL: 'https://thaughts-9aef7-default-rtdb.firebaseio.com',
    storageBucket: 'thaughts-9aef7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-RCVR9kd7TxgMxLgyJS_NXXpXEgnuRm8',
    appId: '1:47606691109:ios:ba0d3ff6903172c582d6cc',
    messagingSenderId: '47606691109',
    projectId: 'thaughts-9aef7',
    databaseURL: 'https://thaughts-9aef7-default-rtdb.firebaseio.com',
    storageBucket: 'thaughts-9aef7.appspot.com',
    iosBundleId: 'com.example.vsdChat',
  );

}