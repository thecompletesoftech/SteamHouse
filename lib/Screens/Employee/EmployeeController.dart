import 'dart:developer';
import 'package:steamhouse/Config/Import.dart';

class EmployeeController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController complaindesc = TextEditingController();

  List<XFile> SendImage = [];
  var isloading = false.obs;
  var Employeedata = [].obs;
  final box = GetStorage();

  Employeelist() async {
    isloading.value = true;
    await Api().getApi(employeeslist, [], true).then((value) async {
      // log("hereData" + value['status'].toString());
      if (value['status'] == true) {
        // log("Employeedata" + value['data'].toString());
        Employeedata.value = value['data'];
        isloading.value = false;
      } else {
        isloading.value = false;
        log("Retry " + value['status'].toString());
      }
      isloading.value = false;
    });
  }

  runFilter(String enteredKeyword) {
    var results = [];

    if (enteredKeyword.isEmpty) {
      Employeelist();
    } else {
      results = Employeedata.where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    Employeedata.value = results;
  }
}
