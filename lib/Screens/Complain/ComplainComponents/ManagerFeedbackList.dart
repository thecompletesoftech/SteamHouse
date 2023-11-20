import 'package:maps_launcher/maps_launcher.dart';
import 'package:steamhouse/Screens/Complain/ComplainController.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Config/Import.dart';
import '../../../Widget/Textfield.dart';
import '../../../config/Color.dart';
import '../../../config/TextStyle.dart';
import '../../../config/string.dart';

class ManagerFeedbackList extends StatefulWidget {
  const ManagerFeedbackList({super.key});

  @override
  State<ManagerFeedbackList> createState() => _ManagerFeedbackListState();
}

class _ManagerFeedbackListState extends State<ManagerFeedbackList> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Textfield().text(
            "Reviewtxt".tr,
            TextStyles.withColor(
              TextStyles.mb16,
              Black,
            ),
          ),
        ).paddingSymmetric(horizontal: 10),
        Container(
          width: size.width,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: White,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Textfield().text(
                  data['managerfeedback'][0]['discription'],
                  TextStyles.withColor(
                    TextStyles.mn16,
                    Darkgray,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
