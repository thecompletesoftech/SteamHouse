
import 'package:steamhouse/config/Import.dart';

class RequestStatusmsg extends StatefulWidget {
  const RequestStatusmsg({super.key});

  @override
  State<RequestStatusmsg> createState() => _RequestStatusmsgState();
}

class _RequestStatusmsgState extends State<RequestStatusmsg> {
  ComplainController complainController = Get.put(ComplainController());
  var status = Get.parameters['status'];
  var statusmsg = Get.parameters['statusmsg'];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
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
        ],
      ),
    );
  }
}
