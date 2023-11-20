import 'dart:developer';
import 'package:steamhouse/config/Import.dart';

class OtpController extends GetxController {
  ComplainController complainController = Get.put(ComplainController());
  TextEditingController otp = TextEditingController();
  var isloading = false.obs;
  final box = GetStorage();

  SendOtp(userno, id) async {
    isloading.value = true;
    var map = new Map<String, dynamic>();
    map['phone'] = userno;
    map['service_request_id'] = id.toString();
    log("Send Number Data" + map.toString());
    await Api().getApi(sendOtp, map, true).then((value) async {
      log("Send Otp Response Data" + value['status'].toString());
      if (value['status'] == true) {
        // log("dataa" + value['data'].toString());
        isloading.value = false;
      } else {
        log("Retry" + value['status'].toString());
        isloading.value = false;
      }
      isloading.value = false;
    });
  }

  VerifyOtp(phone, id, status) async {
    complainController.ismainloading.value = true;
    var map = new Map<String, dynamic>();
    map['phone'] = phone;
    map['otp'] = otp.text;
    map['service_request_id'] = id.toString();
    log("Send Otp Data" + map.toString());
    await Api().getApi(verifyOtp, map, true).then((value) async {
      log("Verify Otp Response Data" + value['status'].toString());
      otp.clear();
      if (value['status'] == true) {
        log("dataa" + value['data'].toString());
        complainController.ComplainList();
        Get.back();
        complainController.ismainloading.value = false;
      } else {
        Get.snackbar(value['message'], 'Please Enter Valid OTP',
            backgroundColor: White);
        log("Retry" + value['status'].toString());
        complainController.ismainloading.value = false;
      }
    });
  }
}
