import 'package:flutter/material.dart';
import 'package:steamhouse/NoInternet.dart';
import 'package:get_storage/get_storage.dart';
import 'package:steamhouse/config/string.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:steamhouse/Screens/Login/Login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:steamhouse/config/FireBase/Getfirebasetoken.dart';
import 'package:steamhouse/config/FireBase/NotificationServices.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:steamhouse/Screens/BottomNavigation/BottomnavigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();
  bool nointernet = false;
  @override
  void initState() {
    Firebase();
  }

  Firebase() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
      PushNotificationService().setupInteractedMessage();
      await GetFirebasetoken().getfirebasetoken();
      super.initState();
    } else {
      setState(() {
        nointernet = true;
      });
      print('No internet :( Reason:');
      print(InternetConnectionChecker());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      splashIconSize: 200,
      splash: Image.asset(newLogo, height: size.height * 0.2),
      nextScreen: nointernet == false
          ? box.read("isLogin") == true
              ? BottomnavigationBar(
                  usertype: 1,
                )
              : Login()
          : NoInternet(),
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: Colors.white,
    );
  }
}
