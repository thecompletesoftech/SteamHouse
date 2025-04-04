import 'dart:developer';

import 'package:steamhouse/config/Import.dart';


class TrackButton extends StatefulWidget {
  const TrackButton({super.key});

  @override
  State<TrackButton> createState() => _TrackButtonState();
}

class _TrackButtonState extends State<TrackButton> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("trackk");
        Get.toNamed(trackcomplainRoute, arguments: data['id']);
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Lightgreen, borderRadius: BorderRadius.circular(5.0)),
          child: Textfield()
              .text('track'.tr, TextStyles.withColor(TextStyles.mb16, White))
              .paddingAll(8.0),
        ),
      ).paddingOnly(top: 30, bottom: 10),
    );
  }
}
