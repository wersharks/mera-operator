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
    apiKey: 'AIzaSyDz1FziuD5dRY-hFw66gtIjaV9_R2ZE9ec',
    appId: '1:800240519039:web:32e31e30d518fd5e51bc4a',
    messagingSenderId: '800240519039',
    projectId: 'sportyme-9927c',
    authDomain: 'sportyme-9927c.firebaseapp.com',
    databaseURL: 'https://sportyme-9927c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sportyme-9927c.appspot.com',
    measurementId: 'G-JD0H8F9117',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCy24LszFzZ92VaIuL9CR0fid13JXBZLgw',
    appId: '1:800240519039:android:ec49bf6dbc60cba451bc4a',
    messagingSenderId: '800240519039',
    projectId: 'sportyme-9927c',
    databaseURL: 'https://sportyme-9927c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sportyme-9927c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6cgOOLWZeX8wY-dqzVSbOO38sbi66gRg',
    appId: '1:800240519039:ios:6822938df04c4f5d51bc4a',
    messagingSenderId: '800240519039',
    projectId: 'sportyme-9927c',
    databaseURL: 'https://sportyme-9927c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sportyme-9927c.appspot.com',
    androidClientId: '800240519039-2scu6hr05uj92htiutgednte3od1o41e.apps.googleusercontent.com',
    iosClientId: '800240519039-q11hdqb88bifpasnd9f18ru14vbvrttd.apps.googleusercontent.com',
    iosBundleId: 'com.shark.meraOperator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6cgOOLWZeX8wY-dqzVSbOO38sbi66gRg',
    appId: '1:800240519039:ios:6822938df04c4f5d51bc4a',
    messagingSenderId: '800240519039',
    projectId: 'sportyme-9927c',
    databaseURL: 'https://sportyme-9927c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'sportyme-9927c.appspot.com',
    androidClientId: '800240519039-2scu6hr05uj92htiutgednte3od1o41e.apps.googleusercontent.com',
    iosClientId: '800240519039-q11hdqb88bifpasnd9f18ru14vbvrttd.apps.googleusercontent.com',
    iosBundleId: 'com.shark.meraOperator',
  );
}
