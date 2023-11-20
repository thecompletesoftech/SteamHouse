import 'package:flutter_svg/svg.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:steamhouse/Screens/Complain/ComplainController.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Config/Import.dart';
import '../../../Widget/Textfield.dart';
import '../../../config/Color.dart';
import '../../../config/Svgstring.dart';
import '../../../config/TextStyle.dart';
import '../../../config/string.dart';

class UserFeedbackList extends StatefulWidget {
  const UserFeedbackList({super.key});

  @override
  State<UserFeedbackList> createState() => _UserFeedbackListState();
}

class _UserFeedbackListState extends State<UserFeedbackList> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: White,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textfield().text(
                    "Review".tr,
                    TextStyles.withColor(
                      TextStyles.mb16,
                      Black,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.string(
                          staricon,
                          color: Yellow,
                        ),
                        Textfield().text(
                          data['customerfeedback'][0]['star'].toString(),
                          TextStyles.withColor(
                            TextStyles.mn16,
                            Black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ).paddingSymmetric(vertical: 8),
              Textfield().text(
                data['customerfeedback'][0]['discription'].toString(),
                TextStyles.withColor(
                  TextStyles.mn16,
                  Darkgray,
                ),
              ),
            ],
          ).paddingOnly(bottom: 5),
        )).paddingOnly(bottom: 20);
  }
}
