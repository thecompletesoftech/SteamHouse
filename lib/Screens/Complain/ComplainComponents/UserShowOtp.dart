import 'package:steamhouse/config/Import.dart';

class UserShowOtp extends StatefulWidget {
  const UserShowOtp({super.key});

  @override
  State<UserShowOtp> createState() => _UserShowOtpState();
}

class _UserShowOtpState extends State<UserShowOtp> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;
  var status = Get.parameters['status'];
  var statusmsg = Get.parameters['statusmsg'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SvgPicture.string(doticon,
                      color: status == "Completed"
                          ? Lightgreen
                          : status == "Resolved"
                              ? Lightgreen
                              : Yellow)
                  .paddingOnly(right: 5),
              Textfield().text(
                  statusmsg,
                  TextStyles.withColor(
                    TextStyles.mn14,
                    status == "Completed"
                        ? Lightgreen
                        : status == "Resolved"
                            ? Lightgreen
                            : Yellow,
                  )),
            ],
          ),
          if (status == "Assigned".tr && data['otp'] != null)
            Row(
              children: [
                Textfield()
                    .text(
                        "otp".tr,
                        TextStyles.withColor(TextStyles.mb16, Darkgray),
                        TextAlign.center)
                    .paddingOnly(right: 8),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Lightpurple,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Textfield().text(
                      data['otp'].toString(),
                      TextStyles.withColor(TextStyles.mb16, Darkgray, 1.5),
                      TextAlign.center),
                ),
              ],
            )
        ],
      ),
    );
  }
}
