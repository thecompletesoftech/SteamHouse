import 'dart:async';
import 'dart:developer';
import '../../Config/Import.dart';

class LiveController extends GetxController {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  var isloading = false.obs;
  var companydata = [].obs;
  var locationList = [];
  var dropdownvalue = ''.obs;
  Timer? _timer;
  final box = GetStorage();

  Live() async {
    isloading.value = true;
    await Api().getApi(managerCompany, true).then((value) async {
      if (value['status'] == true) {
        companydata.value = value['data'];
        uniqifyList(companydata);
        isloading.value = false;
      } else {
        log("Retry" + value['status'].toString());
        isloading.value = false;
      }
    });
    isloading.value = false;
  }

  uniqifyList(List<dynamic> companydata) {
    for (var i = 0; i < companydata.length; i++) {
      locationList.add(companydata[i]['locationname']);
    }
  }

  recall() async {
    await Live();
    Livedatafilter();
  }

  Livedatafilter() {
    var results = [];
    if (dropdownvalue.isEmpty) {
      Live();
    } else {
      results = companydata
          .where((item) => item["locationname"]
              .toString()
              .toLowerCase()
              .contains(dropdownvalue.toString().toLowerCase()))
          .toList();
      companydata.value = results;
    }
    // log('companydata results' + results.toString());
  }

  setDropDownValue(value, data) {
    dropdownvalue.value = value;
  }

  startTimer() {
    const oneSec = const Duration(seconds: 60);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        // log("SEC");
        recall();
        Future.delayed(Duration(seconds: 10));
      },
    );
  }
}
