import 'package:demopetnest/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // Ensure that widgets are initialized
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Local Storage
 // await GetStorage.init();

  // Await Splash until other items load
 // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

 // Initialize Firebase & Authentication Repository
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  //     .then(
  //   (FirebaseApp value) => Get.put(AuthenticationRepository()),
  // );

  runApp(const App());
}
