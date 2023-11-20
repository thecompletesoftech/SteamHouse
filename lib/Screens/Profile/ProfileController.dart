import 'dart:developer';
import 'package:steamhouse/Screens/BottomNavigation/BottomnavigationBar.dart';
import '../../Config/Import.dart';

class ProfileController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  var isloading = false.obs;
  final box = GetStorage();

  EditProfile(BuildContext context) async {
    var map = new Map<String, dynamic>();
    if (confirmpass.text != '') {
      if (newpass.text != confirmpass.text) {
        Get.snackbar(
            'Error'.tr, 'New Password and Confirm Password Should be same');
      }
    }
    isloading.value = true;
    map['email'] = email.text;
    map['phone'] = phone.text;
    map['c_address'] = address.text;
    map['old_password'] = oldpass.text;
    map['new_password'] = confirmpass.text;
    // log("Send Data" + map.toString());
    await Api().getApi(editProfile, map, true).then((value) {
      log("message" + value.toString());
      if (value['status'] == true) {
        // checkRecords(value);
        log("User Details==>" + value['data'].toString());
        storeData(value);
        Get.snackbar('Successfull'.tr, value['message'],
            backgroundColor: White);
        nextScreen(
            context,
            BottomnavigationBar(
              usertype: value['data']['role'],
            ));
        isloading.value = false;
      } else {
        Get.snackbar('Error'.tr, value['message']);
        isloading.value = false;
      }
    });
  }

  Notificationupdate(status) async {
    var map = new Map<String, dynamic>();
    map['push_notification'] = status;
    await Api().getApi(notification, map, true).then((value) {
      log("message" + value.toString());
      if (value['status'] == true) {
        box.remove('notify');
        box.write('notify', status);
      }
    });
  }

  storeData(value) {
    box.remove('email');
    box.remove('phone');
    box.remove('address');
    var userData = value['data'];
    box.write("email", userData['email']);
    box.write("phone", userData['phone']);
    box.write("address", userData['c_address']);
  }
}
