import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';

class GetFirebasetoken {
  GetStorage box = GetStorage();
  getfirebasetoken() async {
    box.remove("fcmtoken");
    var token = (await FirebaseMessaging.instance.getToken());
    box.write("fcmtoken", token);
    log("fcmtoken ===> " + token.toString());
  }
}
