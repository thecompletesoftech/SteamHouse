import 'package:steamhouse/config/Import.dart';

import '../../../Widget/Button.dart';
import '../../../Widget/RemarkPopup.dart';
import '../ComplainController.dart';

class CloseTicketButton extends StatefulWidget {
  const CloseTicketButton({super.key});

  @override
  State<CloseTicketButton> createState() => _CloseTicketButtonState();
}

class _CloseTicketButtonState extends State<CloseTicketButton> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButtons(
        width: 0.82,
        name: 'Closeticket'.tr,
        loading: false,
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return RemarkPopup(
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
                  complainController.Managerfeedback(
                      data['id'], data['emp_id']);
                },
              );
            },
          );
        },
      ),
    ).paddingSymmetric(vertical: 20);
  }
}
