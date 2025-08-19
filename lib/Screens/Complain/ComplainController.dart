import 'dart:developer';
import 'package:intl/intl.dart';
import '../../Config/Import.dart';
import 'package:http/http.dart' as http;

class ComplainController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController complaindesc = TextEditingController();
  TextEditingController selectdate = TextEditingController();
  TextEditingController selecttime = TextEditingController();
  SelectedEmp _selectedEmp = Get.put(SelectedEmp());
  List<XFile> SendImage = [];
  var isloading = false.obs;
  var ismainloading = false.obs;
  var complaindata = [].obs;
  var empid = ''.obs;
  final box = GetStorage();
  var rating = 0.0.obs;
  var pending = [].obs;
  var inprogress = [].obs;
  var completed = [].obs;

  Addcomplain() async {
    try {
      
      isloading.value = true;
      var url = Uri.parse(baseurl + raisecomplain);
      var userHeader = {
        "Authorization":
            box.read("token") == null ? "" : "Bearer" + box.read("token"),
      };
      
      // log("certificate length" + SendImage.length.toString());
      var request = new http.MultipartRequest(
        "POST",
        url,
      );
      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        "Authorization": "Bearer" + box.read("token")
      };
print("token data"+  box.read('longitude').toString());

      request.headers.addAll(headers);
      // request.fields['user_id'] = box.read('userid').toString();
      request.fields['manger_id'] = box.read('managerid').toString();
      request.fields['riser_name'] = username.text;
      request.fields['meter_id'] = box.read('meterid').toString();
      request.fields['Service_request'] = name.text;
      request.fields['date'] = selectdate.text;
      request.fields['time'] = selecttime.text;
      request.fields['phone'] = phone.text.replaceFirst(RegExp(r'^0+'), "");
      request.fields['discription'] = complaindesc.text;
      request.fields['latitude'] = box.read('latitude') ;
      request.fields['longitude'] = box.read('longitude');
      print("request field"+request.fields.toString());
      for (var file in SendImage) {
        // log("hii" + file.path.toString());
        request.files.add(await http.MultipartFile.fromPath(
            "pictures[]", file.path.toString(),
            filename: file.path.split('/').last));
      }
      print("jsonEncode" + jsonEncode(request.fields));
      // log("FILES" + request.files.toString());
      await request.send().then((response) async {
        var respose = await response.stream.bytesToString();
        print("add Complaindata" + respose);
        if (jsonDecode(respose)['status'] == true) {
          name.clear();
          phone.clear();
          complaindesc.clear();
          SendImage.clear();
          selectdate.clear();
          selecttime.clear();
          Get.snackbar('Successfull'.tr, jsonDecode(respose)['message'],
              backgroundColor: White);
          isloading.value = false;
          Get.toNamed(bottombarRoute);
        } else {
          Get.snackbar('retry'.tr, jsonDecode(respose)['message'],
              backgroundColor: White);
          log("Retry" + respose);
          isloading.value = false;
        }
        isloading.value = false;
      });
    } catch (e) {
      Get.snackbar('retry'.tr, 'Something went wrong'+e.toString(), backgroundColor: White);
      isloading.value = false;
      log("catch==>" + e.toString());
    }
  }

  ComplainList() async {
    isloading.value = true;
    complaindata.value = [];
    pending.value = [];
    inprogress.value = [];
    completed.value = [];
    var map = new Map<String, dynamic>();
    box.read('usertype') == 0
        ? map['UserId'] = box.read('userid')
        : box.read('usertype') == 1
            ? map['ManagerID'] = box.read('userid')
            : map['EmpId'] = box.read('userid');
    var apiurl = box.read('usertype') == 0
        ? complainlistbyuserid
        : box.read('usertype') == 1
            ? complainlistbymanagerid
            : complainlistbyemployeeid;
    print("Send Data" + map.toString());
    await Api().getApi(apiurl, map, true).then((value) async {
      print("Response Data" + value.toString());
      if (value['status'] == true) {
        log("dataa" + value['data'].toString());
        complaindata.value = value['data'];

        for (var i = 0; i < complaindata.length; i++) {
          pending.value = await FilterData(2, 0, 1);
          inprogress.value = await FilterData(2, 2, 3);
          completed.value = await FilterData(1, 4);
        }
        isloading.value = false;
      } else {
        log("Retry" + value['status'].toString());
        isloading.value = false;
      }
      isloading.value = false;
    });
  }

  FilterData(type, status, [status1]) async {
    return await complaindata.where((data) {
      if (type == 1) {
        return data['status'] == status;
      } else
        return data['status'] == status || data['status'] == status1;
    }).toList();
  }

  AssignEmp(id, status) async {
    // log("Empid" + _selectedEmp.empdata['id'].toString());
    // log(id.toString());
    try {
      isloading.value = true;
      var emp = box.read('usertype') == 1
          ? _selectedEmp.empdata['id'] == null
              ? empid.toString()
              : _selectedEmp.empdata['id'].toString()
          : box.read('userid');
      var map = new Map<String, dynamic>();
      map['emp_id'] = emp;
      map['status'] = status;
      log("Send Data" + map.toString());
      await Api()
          .getApi(complainlistupdate + "/" + id.toString(), map, true)
          .then((value) async {
        log("Response Data" + value['status'].toString());
        if (value['status'] == true) {
          // log("dataa" + value.toString());
          Get.back();
          ComplainList();
          Get.snackbar('Successfull'.tr, value['message'],
              backgroundColor: White);
          isloading.value = false;
        } else {
          Get.snackbar('Error'.tr, 'retry'.tr, backgroundColor: White);
          log("Retry" + value['status'].toString());
          isloading.value = false;
        }
        isloading.value = false;
      });
    } catch (e) {
      log("catch==>" + e.toString());
      isloading.value = false;
    }
  }

  PendingrunFilter(String enteredKeyword) {
    var results = [];
    // log("messagse" + data.toString());
    if (enteredKeyword.isEmpty) {
      ComplainList();
    } else {
      results = pending
          .where((user) =>
              user["Service_request"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["discription"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    pending.value = results;
  }

  inprogressrunFilter(String enteredKeyword) {
    var results = [];
    // log("messagse" + data.toString());
    if (enteredKeyword.isEmpty) {
      ComplainList();
    } else {
      results = inprogress
          .where((user) => user["Service_request"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    inprogress.value = results;
  }

  CompleterunFilter(String enteredKeyword) {
    var results = [];
    // log("messagse" + data.toString());
    if (enteredKeyword.isEmpty) {
      ComplainList();
    } else {
      results = completed
          .where((user) => user["Service_request"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    completed.value = results;
  }

  Employeefeedback(id) async {
    if (SendImage.length > 0) {
      if (complaindesc.text.isEmpty) {
        Get.snackbar('Required'.tr, 'Please Provide Some Description'.tr,
            backgroundColor: White);
      } else {
        try {
          isloading.value = true;
          var url = Uri.parse(baseurl + employeefeedbacks);
          var userHeader = {
            "Authorization":
                box.read("token") == null ? "" : "Bearer" + box.read("token"),
          };
          var request = new http.MultipartRequest(
            "POST",
            url,
          );
          Map<String, String> headers = {
            "Content-type": "multipart/form-data",
            "Authorization": "Bearer" + box.read("token")
          };
          request.headers.addAll(headers);
          request.fields['employee_id'] = box.read('userid').toString();
          request.fields['Service_request_id'] = id.toString();
          request.fields['remark'] = complaindesc.text;
          for (var file in SendImage) {
            // log("hii" + file.path.toString());
            request.files.add(await http.MultipartFile.fromPath(
                "pictures[]", file.path.toString(),
                filename: file.path.split('/').last));
          }
          log("jsonEncode" + jsonEncode(request.fields));
          // log("FILES" + request.files.toString());
          await request.send().then((response) async {
            var respose = await response.stream.bytesToString();
            log("work done " + respose);
            if (jsonDecode(respose)['status'] == true) {
              complaindesc.clear();
              SendImage.clear();
              ComplainList();
              Get.back();
              Get.snackbar('Successfull'.tr, jsonDecode(respose)['message'],
                  backgroundColor: White);
              isloading.value = false;
            } else {
              Get.snackbar('Validation'.tr, 'retry'.tr, backgroundColor: White);
              log("Retry" + respose);
              isloading.value = false;
            }
          });
        } catch (e) {
          // _apicrash.apicrashmsg("Someting went wrong");
          isloading.value = false;
          log("catch==>" + e.toString());
        }
      }
    } else {
      Get.snackbar('Required'.tr, 'Please Add Image'.tr,
          backgroundColor: White);
    }
  }

  Managerfeedback(id, emp) async {
    ismainloading.value = true;
    var map = new Map<String, dynamic>();
    map['manager_feedback_id'] = box.read('userid');
    map['Service_request_id'] = id;
    map['discription'] = complaindesc.text;
    log("Send Data" + map.toString());
    await Api().getApi(managerfeedbacks, map, true).then((value) async {
      log("Response Data" + value['status'].toString());
      if (value['status'] == true) {
        // log("dataa" + value['data'].toString());
        complaindesc.clear();
        Get.back();
        ComplainList();
        ismainloading.value = false;
      } else {
        log("Retry" + value['status'].toString());
        ismainloading.value = false;
      }
      ismainloading.value = false;
    });
  }

  Userfeedback(id) async {
    ismainloading.value = true;
    var map = new Map<String, dynamic>();
    map['Service_request_id'] = id;
    map['customer_feedback_id'] = box.read('userid');
    map['star'] = rating.toString();
    map['discription'] = complaindesc.text;
    log("Send Data" + map.toString());
    await Api().getApi(userfeedbacks, map, true).then((value) async {
      log("Response Data" + value['status'].toString());
      if (value['status'] == true) {
        // log("dataa" + value['data'].toString());
        complaindesc.clear();
        Get.back();
        ComplainList();
        Get.snackbar('Successfull'.tr, value['message'],
            backgroundColor: White);
        ismainloading.value = false;
      } else {
        log("Retry" + value['status'].toString());
        ismainloading.value = false;
      }
    });
  }

  Datetime(date) {
    return DateFormat('d MMM yyyy').format(DateTime.parse(date));
  }
}
