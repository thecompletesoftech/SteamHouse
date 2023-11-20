import '../../Otp/Otp.dart';
import '../../Otp/OtpController.dart';
import 'package:steamhouse/config/Import.dart';

class CheckInButton extends StatefulWidget {
  const CheckInButton({super.key});

  @override
  State<CheckInButton> createState() => _CheckInButtonState();
}

class _CheckInButtonState extends State<CheckInButton> {
  ComplainController complainController = Get.put(ComplainController());
  OtpController otpController = Get.put(OtpController());
  var data = Get.arguments;
  var showotp = false;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButtons(
            width: 0.82,
            name: 'checkin'.tr,
            loading: complainController.isloading.value,
            onTap: () async {
              otpController.SendOtp(
                data['phone'],
                data['id'],
              );
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Otp(
                    OnresendTap: () {
                      otpController.SendOtp(
                        data['phone'],
                        data['id'],
                      );
                    },
                    ontap: () {
                      Get.back();
                      otpController.VerifyOtp(data['phone'], data['id'], 2);
                    },
                  );
                },
              );
            })).paddingSymmetric(vertical: 15);
  }
}
