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
        return windows;
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
    apiKey: 'AIzaSyAsEhhbf7OlZtuiOOKPXC4LCeSZ8dcCUHM',
    appId: '1:421057789625:web:f23de8bb7cb27d76c9e568',
    messagingSenderId: '421057789625',
    projectId: 'physix-9c8bd',
    authDomain: 'physix-9c8bd.firebaseapp.com',
    storageBucket: 'physix-9c8bd.appspot.com',
    measurementId: 'G-RNL37HN0D3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXBcpUw0dNTpqdx6uT4q67qFt45c1_Ds0',
    appId: '1:421057789625:android:2dbd768907809faec9e568',
    messagingSenderId: '421057789625',
    projectId: 'physix-9c8bd',
    storageBucket: 'physix-9c8bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZsbOP2UKSoFX5ESoOj62deADeklkqJfY',
    appId: '1:421057789625:ios:26295d81aa2d498fc9e568',
    messagingSenderId: '421057789625',
    projectId: 'physix-9c8bd',
    storageBucket: 'physix-9c8bd.appspot.com',
    iosBundleId: 'com.example.physixCompanionApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZsbOP2UKSoFX5ESoOj62deADeklkqJfY',
    appId: '1:421057789625:ios:26295d81aa2d498fc9e568',
    messagingSenderId: '421057789625',
    projectId: 'physix-9c8bd',
    storageBucket: 'physix-9c8bd.appspot.com',
    iosBundleId: 'com.example.physixCompanionApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAsEhhbf7OlZtuiOOKPXC4LCeSZ8dcCUHM',
    appId: '1:421057789625:web:de180792f3590addc9e568',
    messagingSenderId: '421057789625',
    projectId: 'physix-9c8bd',
    authDomain: 'physix-9c8bd.firebaseapp.com',
    storageBucket: 'physix-9c8bd.appspot.com',
    measurementId: 'G-2GB6H0L2NT',
  );
}