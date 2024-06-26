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
    apiKey: 'AIzaSyBIH3ABUKdulVXealsaU4GpuH3alC73Vgo',
    appId: '1:1099481828037:web:b8a346747106749040beac',
    messagingSenderId: '1099481828037',
    projectId: 'goodproject369',
    authDomain: 'goodproject369.firebaseapp.com',
    storageBucket: 'goodproject369.appspot.com',
    measurementId: 'G-CKH8N3M4YH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_JuI2QFXYoiSYPIhakdLf55Yx97jn6tI',
    appId: '1:1099481828037:android:33f719cb9a73e99640beac',
    messagingSenderId: '1099481828037',
    projectId: 'goodproject369',
    storageBucket: 'goodproject369.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZUMwWFw-10WZl85BXaPh1QsptQj3vFHs',
    appId: '1:1099481828037:ios:9747e413600b171040beac',
    messagingSenderId: '1099481828037',
    projectId: 'goodproject369',
    storageBucket: 'goodproject369.appspot.com',
    iosClientId: '1099481828037-q3mf7sk140lvnroba2c52to16cv4lrvd.apps.googleusercontent.com',
    iosBundleId: 'com.example.goodproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZUMwWFw-10WZl85BXaPh1QsptQj3vFHs',
    appId: '1:1099481828037:ios:9747e413600b171040beac',
    messagingSenderId: '1099481828037',
    projectId: 'goodproject369',
    storageBucket: 'goodproject369.appspot.com',
    iosClientId: '1099481828037-q3mf7sk140lvnroba2c52to16cv4lrvd.apps.googleusercontent.com',
    iosBundleId: 'com.example.goodproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBIH3ABUKdulVXealsaU4GpuH3alC73Vgo',
    appId: '1:1099481828037:web:73c23b211afc669740beac',
    messagingSenderId: '1099481828037',
    projectId: 'goodproject369',
    authDomain: 'goodproject369.firebaseapp.com',
    storageBucket: 'goodproject369.appspot.com',
    measurementId: 'G-T69GHKJD9B',
  );

}