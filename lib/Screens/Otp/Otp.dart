import 'dart:async';
import 'dart:io';
import 'package:pinput/pinput.dart';
import 'package:steamhouse/Screens/Complain/ComplainController.dart';
import 'package:steamhouse/Screens/Otp/OtpController.dart';
import 'package:steamhouse/Widget/Appbartext.dart';
import 'package:steamhouse/Widget/Button.dart';
import 'package:steamhouse/Widget/Textfield.dart';
import 'package:steamhouse/config/Color.dart';
import 'package:steamhouse/config/TextStyle.dart';
import 'package:steamhouse/config/string.dart';

import '../../Config/Import.dart';

class Otp extends StatefulWidget {
  final Function? ontap;
  final Function? OnresendTap;
  const Otp({super.key, this.ontap, this.OnresendTap});

  @override
  _OtpState createState() => _OtpState();
}

class IconMenu {
  final IconData iconName;
  final String titleIcon;
  IconMenu({required this.iconName, required this.titleIcon});
}

class _OtpState extends State<Otp> {
  OtpController otpController = Get.put(OtpController());
  Timer? _timer;
  int _start = 20;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void dispose() {
    _timer!.cancel();
  }

  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    // get_typeaccount();
    final defaultPinTheme = PinTheme(
      width: 80,
      margin: EdgeInsets.only(
          left: 5, right: Platform.isAndroid ? 15 : 20, bottom: 5),
      // padding: EdgeInsets.symmetric(horizontal: 40),
      textStyle: TextStyles.withColor(TextStyles.mw60021, PrimaryColor),
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(color: Gray),
        ),
      ),
    );
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Textfield().text(
                      'Otpmsg'.tr,
                      TextStyles.withletterspacing(
                        TextStyles.mw40014,
                        PrimaryColor,
                        0.5,
                      ),
                      TextAlign.left,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Lightred,
                        size: 25,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 60,
                  child: Pinput(
                    controller: otpController.otp,
                    length: 4,
                    pinAnimationType: PinAnimationType.none,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    showCursor: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Textfield()
                        .text(
                          'NotGetOtp'.tr,
                          TextStyles.withletterspacing(
                            TextStyles.mw50016,
                            Gray,
                            0.5,
                          ),
                          TextAlign.center,
                        )
                        .paddingOnly(right: 10),
                    _start > 0
                        ? Textfield().text(
                            formatedTime(_start).toString(),
                            TextStyles.withletterspacing(
                              TextStyles.mw50016,
                              DarkGreen,
                              0.5,
                            ),
                            TextAlign.center,
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                _start = 20;
                              });
                              startTimer();
                              widget.OnresendTap!();
                            },
                            child: Textfield().text(
                              'Resend'.tr,
                              TextStyles.withletterspacing(
                                TextStyles.mw50016,
                                DarkGreen,
                                0.5,
                              ),
                              TextAlign.center,
                            ),
                          ),
                  ],
                ).paddingSymmetric(vertical: 10),
                ElevatedButtons(
                    width: 0.82,
                    name: 'Done'.tr,
                    loading: false,
                    onTap: () async {
                      widget.ontap!();
                    }).paddingSymmetric(vertical: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  formatedTime(time) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }
}
