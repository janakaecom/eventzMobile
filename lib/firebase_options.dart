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
    apiKey: 'AIzaSyDrc4oZxs_I9ZOF4DBmJtlGMZrsJlbtVAs',
    appId: '1:75881224567:web:0624af4e2571b1b7992972',
    messagingSenderId: '75881224567',
    projectId: 'eventzapp-6fa00',
    authDomain: 'eventzapp-6fa00.firebaseapp.com',
    storageBucket: 'eventzapp-6fa00.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAM8lScG3oBylKpjgXCYTy-gkCugQ5ADqE',
    appId: '1:75881224567:android:68091cbf99f96d01992972',
    messagingSenderId: '75881224567',
    projectId: 'eventzapp-6fa00',
    storageBucket: 'eventzapp-6fa00.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALvn1xvZvYZLBuX-DOPtoM2dfqxB4A8bE',
    appId: '1:75881224567:ios:f814644cdccb90f6992972',
    messagingSenderId: '75881224567',
    projectId: 'eventzapp-6fa00',
    storageBucket: 'eventzapp-6fa00.appspot.com',
    iosClientId: '75881224567-8450bu1aektbs12ditq1aiuvj5vf57jf.apps.googleusercontent.com',
    iosBundleId: 'com.jana.eventz.eventzWayo',
  );
}
