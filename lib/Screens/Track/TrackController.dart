import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:steamhouse/config/Import.dart';

class TrackController extends GetxController {
  ComplainController complainController = Get.put(ComplainController());
  var isloading = false.obs;
  var trackList = [].obs;
  final box = GetStorage();
  var trackdata = [].obs;
  var data = [
    {
      'id': '1',
      'name': 'Ticket Generated',
      'status': 0,
      'updated_at': null,
      'detail': null,
      'contact': null,
    },
    {
      'id': '2',
      'name': 'Pending For Assignment',
      'status': 0,
      'updated_at': null,
      'detail': null,
      'contact': null,
    },
    {
      'id': '3',
      'name': 'Assign To Engineer',
      'status': 0,
      'updated_at': null,
      'detail': null,
      'contact': null,
    },
    {
      'id': '4',
      'name': 'Engineer Check-In',
      'status': 0,
      'updated_at': null,
      'detail': null,
      'contact': null,
    },
    {
      'id': '5',
      'name': 'Service in process',
      'status': 0,
      'updated_at': null,
      'detail': null,
      'contact': null,
    },
    {
      'id': '6',
      'name': 'Resolved By Engineer',
      'status': 0,
      'updated_at': null,
      'detail': null,
      'contact': null,
    },
    {
      'id': '7',
      'name': 'Service Request Closed',
      'status': 0,
      'updated_at': null,
      'detail': null,
      'contact': null,
    },
  ].obs;

  Track(id) async {
    log("trackid" + id.toString());
    isloading.value = true;
    var map = new Map<String, dynamic>();
    map['Service_request_id'] = id.toString();
    // log("Send Data For Track " + map.toString());
    await Api().getApi(TrackListApi, map, true).then((value) async {
      // log("Track Response Data" + value['status'].toString());
      if (value['status'] == true) {
        log("Track Data" + value['data'].toString());
        trackdata.value = value['data'];
        filterList();
        isloading.value = false;
      } else {
        // Get.snackbar('Error'.tr, 'retry'.tr);
        log("Retry" + value['status'].toString());
        isloading.value = false;
      }
      isloading.value = false;
    });
  }

  filterList() {
    for (var i = 0; i < trackdata.length; i++) {
      for (var e = 0; e < data.length; e++) {
        var name = trackdata[i]['text'].split(',');
        log("length" + name.length.toString());
        if (data[e]['name'] == name[0]) {
          data[e]['status'] = trackdata[i]['status'];
          data[e]['updated_at'] = trackdata[i]['updated_at'];
          log("trackid" + trackdata[i].toString());
          if (name.length > 1) {
            data[e]['detail'] =
                name[1] + '\n' + 'Contact : ' + ' +91 ' + name[2];
          }
        }
      }
    }
    trackList.value = data;
    isloading.value = false;
    // log("data" + data.toString());
  }

  OnlyDate(date) {
    return DateFormat('d MMM yyyy').format(DateTime.parse(date));
  }

  Onlytime(date) {
    return DateFormat('h:mm a').format(DateTime.parse(date));
  }
}
