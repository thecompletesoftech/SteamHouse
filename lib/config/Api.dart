import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'Navagate_Next.dart';
import '../Screens/Login/Login.dart';
import 'package:http/http.dart' as http;
import 'package:steamhouse/config/Urls.dart';
import 'package:get_storage/get_storage.dart';

class Api {
  get context => null;

  getApi(apiname, params, [type = true]) async {
    final box = GetStorage();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var url = Uri.parse(baseurl + apiname);
        print(url);
        try {
          var userHeader = {
            "Content-type":
                type == true ? "application/json" : "multipart/form-data",
            "Authorization":
                box.read("token") == null ? "" : "Bearer" + box.read("token"),
            "Accept-Language": box.read("lang") == 1 ? "en-Fr" : "en-Us"
          };
          var response = await http.post(url,
              body: jsonEncode(params), headers: userHeader);
          if (response.statusCode == 401) {
            box.erase();
            nextScreen(context, Login());
          } else {
            return jsonDecode(response.body);
          }
        } catch (e) {
          // Get.snackbar('Error'.tr, 'Something Went Wrong Try Again');
          log("catch execute on Api -- Error" + e.toString());
          return false;
        }
      }
    } on SocketException catch (_) {
      return false;
      // apicrash.apicrashmsg("enableinternettxt".tr);
      // final snackBar = SnackBar(
      //   content: Textfield().text("checkinternettxt".tr, TextStyles.mn14),
      //   action: SnackBarAction(
      //     label: 'ok',
      //     onPressed: () {
      //       // Some code to undo the change.
      //     },
      //   ),
      // );
      // ScaffoldMessenger.of(cntx).showSnackBar(snackBar);
    }
  }
}
