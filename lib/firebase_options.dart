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
    apiKey: 'AIzaSyB18COVMwOxWT4m5VOWNoi2Dp_kzofeE5w',
    appId: '1:1085223617508:web:06937443bb6037d2ce3df1',
    messagingSenderId: '1085223617508',
    projectId: 'gdsc-movie-app',
    authDomain: 'gdsc-movie-app.firebaseapp.com',
    databaseURL: 'https://gdsc-movie-app-default-rtdb.firebaseio.com',
    storageBucket: 'gdsc-movie-app.appspot.com',
    measurementId: 'G-K4Z8X2HST6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3cSCvfRda7ZjpKagKKu8W7oMhgqR34Kw',
    appId: '1:1085223617508:android:c18e0d4e2efdf12dce3df1',
    messagingSenderId: '1085223617508',
    projectId: 'gdsc-movie-app',
    databaseURL: 'https://gdsc-movie-app-default-rtdb.firebaseio.com',
    storageBucket: 'gdsc-movie-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPBb-UD9hJeZL2keiXcmK0rdH5pjJtDCE',
    appId: '1:1085223617508:ios:82538ee9f5e6214dce3df1',
    messagingSenderId: '1085223617508',
    projectId: 'gdsc-movie-app',
    databaseURL: 'https://gdsc-movie-app-default-rtdb.firebaseio.com',
    storageBucket: 'gdsc-movie-app.appspot.com',
    iosBundleId: 'com.example.gdscMovieApp',
  );
}