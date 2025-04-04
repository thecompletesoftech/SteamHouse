import 'package:maps_launcher/maps_launcher.dart';
import 'package:steamhouse/Screens/Complain/ComplainController.dart';
import 'package:steamhouse/config/Import.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Widget/Textfield.dart';
import '../../../config/Color.dart';
import '../../../config/TextStyle.dart';

class TitleandDiscription extends StatefulWidget {
  const TitleandDiscription({super.key});

  @override
  State<TitleandDiscription> createState() => _TitleandDiscriptionState();
}

class _TitleandDiscriptionState extends State<TitleandDiscription> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Textfield().text(
            data['Service_request'].toString(),
            TextStyles.withColor(
              TextStyles.mb16,
              Darkgray,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Textfield().text(
            data['discription'].toString(),
            TextStyles.withColor(
              TextStyles.mn16,
              Darkgray,
            ),
          ),
        ],
      ),
    );
  }
}
