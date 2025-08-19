import 'package:steamhouse/config/Import.dart';

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
