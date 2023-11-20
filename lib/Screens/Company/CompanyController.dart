import 'dart:developer';
import 'package:steamhouse/config/Import.dart';

class CompanyController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController complaindesc = TextEditingController();

  List<XFile> SendImage = [];
  var isloading = false.obs;
  var companydata = [].obs;
  final box = GetStorage();

  Companylist() async {
    isloading.value = true;
    var map = new Map<String, dynamic>();
    map['ManagerID'] = box.read('userid');
    // log("Send Data for CompanyList" + map.toString());
    await Api().getApi(companyList, map, true).then((value) async {
      // log("hereData" + value.toString());
      if (value['status'] == true) {
        log("Company List data" + value['data'].toString());
        companydata.value = value['data'];
        isloading.value = false;
      } else {
        log("Retry" + value['status']);
        isloading.value = false;
      }
      isloading.value = false;
    });
  }

  runFilter(String enteredKeyword) {
    var results = [];
    if (enteredKeyword.isEmpty) {
      Companylist();
    } else {
      results = companydata
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    companydata.value = results;
  }
}
