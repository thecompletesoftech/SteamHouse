import 'Routes/Routes.dart';
import 'package:get/get.dart';
import 'Routes/RoutesString.dart';
import 'package:flutter/material.dart';    
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:steamhouse/config/LocalString.dart';

void main() async {
  await GetStorage.init();
    WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp();
    print("Firebase Initialized Successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Localstring(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,  
      initialRoute: splashRoute,
      getPages: Routes(),
    );
  }
}

