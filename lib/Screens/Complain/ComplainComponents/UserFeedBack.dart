import 'package:steamhouse/config/Import.dart';

class UserFeedBack extends StatefulWidget {
  const UserFeedBack({super.key});

  @override
  State<UserFeedBack> createState() => _UserFeedBackState();
}

class _UserFeedBackState extends State<UserFeedBack> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButtons(
        width: 0.82,
        name: 'Review'.tr,
        loading: false,
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ReviewPopUp(
                onTap: () {
                  if (complainController.complaindesc.text == "" ||
                      complainController.complaindesc.text.length <= 0) {
                    Get.snackbar(
                        'Alert'.tr,
                        'Please Enter Text'
                            .trParams({"validation": "Questiontxt".tr}));
                    return;
                  }
                  Get.back();
                  complainController.Userfeedback(data['id']);
                },
              );
            },
          );
        },
      ),
    ).paddingSymmetric(vertical: 20);
  }
}
