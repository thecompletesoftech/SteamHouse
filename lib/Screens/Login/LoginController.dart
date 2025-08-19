import 'dart:developer';
import 'package:steamhouse/Screens/BottomNavigation/BottomNavigationbar.dart';
import 'package:steamhouse/Screens/Login/Login.dart';
import 'package:steamhouse/config/FireBase/Getfirebasetoken.dart';
import 'package:steamhouse/config/Import.dart';

class LoginController extends GetxController {
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController signuppassword = TextEditingController();
  TextEditingController password = TextEditingController();
  List<TextEditingController> textlist = [];
  var isloadingsignup = false.obs;
  var isloadinglogin = false.obs;
  var isloadinglogout = false.obs;
  final box = GetStorage();

  Future<void> login(
    BuildContext context,
  ) async {
    isloadinglogin.value = true;
    var map = new Map<String, dynamic>();
    map['username'] = phone.text;
    map['password'] = password.text;
    map['fcm_token'] = box.read('fcmtoken');
    // log("Send Data" + map.toString());
    await Api().getApi(loginapi, map, true).then((value) {
      if (value['status'] == true) {
        // checkRecords(value);
        log("User Details==>" + value['data'].toString());
        storeData(value);
        phone.clear();
        password.clear();
        nextScreen(
            context,
            BottomnavigationBar(
              usertype: value['data']['role'],
            ));
        isloadinglogin.value = false;
      } else {
        Get.snackbar('Validation'.tr, value['message'], backgroundColor: White);
        isloadinglogin.value = false;
      }
    });
  }

  Signup(BuildContext context) async {
    isloadingsignup.value = true;
    var map = new Map<String, dynamic>();
    map['username'] = name.text;
    map['name'] = username.text;
    map['password'] = signuppassword.text;
    // log("Send Data" + map.toString());
    await Api().getApi(companyRegister, map, true).then((value) {
      print("User Detailswwww==>" + value.toString());
      if (value == false) {
        Get.snackbar('Validation'.tr, 'Something went wrong',
            backgroundColor: White);
        isloadingsignup.value = false;
      } else if (value['status'] == true) {
        log("User Details==>" + value['data'].toString());
        name.clear();
        username.clear();
        signuppassword.clear();
        nextScreen(context, Login());
        isloadingsignup.value = false;
      } else {
        Get.snackbar('Validation'.tr, value['message'], backgroundColor: White);
        isloadingsignup.value = false;
      }
    });
  }

  // Future<void> checkRecords(data) async {
  //   //mob_verify 0= unverify 1=verify
  //   if(data['data']['mob_verify']==0){
  //     // Get.toNamed(otpRoute,parameters: {"phoneNo":data['data']['phone'],"ContryCode":data['data']['country_code']});
  //   }else{
  //     await storeData(data);
  //     Get.toNamed(Bottomnavigation);
  //   }
  // }

  storeData(value) {
    var userData = value['data'];
    print(value['data']);
    box.write("isLogin", true);
    box.write("userid", userData['id']);
    box.write("meterid", userData['meter_id']);
    box.write("managerid", userData['manager_id']);
    box.write("username", userData['username']);
    box.write("name", userData['name']);
    box.write("email", userData['email']);
    box.write("phone", userData['phone']);
    box.write("about", userData['about']);
    box.write("address", userData['c_address']);
    box.write("usertype", userData['role']);
    box.write("token", value['token']);
    box.write("latitude", userData['latitude'].toString());
    box.write("longitude", userData['longitude'].toString());
    box.write("helpline", userData['helpline_no']);
    box.write("notify", userData['push_notification']);

  }

  logout() async {
    isloadinglogout.value = true;
    await Api().getApi(Logout, [], true).then((value) async {
      print("here" + value.toString());
      if (value['status'] == true) {
        box.erase();
        FireBase();
        Get.toNamed(loginRoute);
        isloadinglogout.value = false;
      } else {
        log("Error".tr + value['status'].toString());
      }
      isloadinglogout.value = false;
    });
  }

  deleteAccount() async {
    isloadinglogout.value = true;
    await Api().getApi(DeleteAccount, [], true).then((value) async {
      if (value['status'] == true) {
        box.erase();
        FireBase();
        Get.toNamed(loginRoute);
        isloadinglogout.value = false;
      } else {
        log("Error".tr + value['status'].toString());
      }
      isloadinglogout.value = false;
    });
  }

  FireBase() async {
    await GetFirebasetoken().getfirebasetoken();
  }
}
