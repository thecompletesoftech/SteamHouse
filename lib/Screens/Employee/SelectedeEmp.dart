import 'package:steamhouse/config/Import.dart';

class SelectedEmp extends GetxController {
  var emp = false.obs;
  var empdata = {}.obs;
  final box = GetStorage();

  selectedemp(value, empd) {
    emp.value = value;
    empdata.value = empd;
  }

  clearemp() {
    emp.value = false;
    empdata.value = {};
  }
}
