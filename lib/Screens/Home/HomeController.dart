import 'dart:async';
import 'dart:developer';
import 'package:steamhouse/config/Import.dart';

class HomeController extends GetxController {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  var isloading = false.obs;
  var homedataa = [].obs;
  var homelist = [].obs;
  Timer? _timer;
  final box = GetStorage();

  HomeData() async {
    try {
      isloading.value = true;
      await Api().getApi(livedata, true).then((value) async {
        if (value['status'] == true) {
          print("data live data"+value['data'].toString());
          homedataa.value = json.decode(value['data'][0]['livedata']);
          
          checklist();

          isloading.value = false;
        } else {
          log("Retry" + value['status'].toString());
          isloading.value = false;
        }
      });
      isloading.value = false;
    } catch (e) {
      isloading.value = false;
      // Get.snackbar('Error'.tr, 'Something Went Wrong Try Again');
      log("catch execute on Api -- Error" + e.toString());
    }
  }

  checklist() {
    log(box.read("meterid").toString());
    for (var i = 0; i < homedataa.length; i++) {
      if (box.read("meterid").toString() ==
          homedataa[i]['MeterID'].toString()) {
        homelist.add(homedataa[i]);
        // box.write('latitude', homedataa[i]['Latitude']);
        // box.write('longitude', homedataa[i]['Longitude']);
        isloading.value = false;
      }
    }
  }

  startTimer(context) {
    const oneSec = const Duration(seconds: 60);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        // log("SEC");
        HomeData();
        Future.delayed(Duration(seconds: 10));
      },
    );
  }
}
