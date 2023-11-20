import 'package:steamhouse/config/Import.dart';

class UserComplainDetail extends StatefulWidget {
  const UserComplainDetail({
    super.key,
  });

  @override
  State<UserComplainDetail> createState() => _UserComplainDetailState();
}

class _UserComplainDetailState extends State<UserComplainDetail> {
  ComplainController complainController = Get.put(ComplainController());
  var showemployee = false;
  final box = GetStorage();
  var data = Get.arguments;
  var status = Get.parameters['status'];
  var statusmsg = Get.parameters['statusmsg'];

  @override
  Widget build(BuildContext context) {
    // log("userdata" + data.toString());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Header(
              title: 'ComplainDetail'.tr,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Textfield().text(
                            "#Tkt " + data['id'].toString(),
                            TextStyles.withColor(
                              TextStyles.mb16,
                              Darkgray,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TitleandDiscription(),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          child: Textfield().text(
                            "+91 ".tr + data['phone'].toString(),
                            TextStyles.withColor(
                              TextStyles.mb16,
                              Darkgray,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: status == "Pending" ? 30 : 10,
                    ),
                    RequestImage(),
                    UserShowOtp(),
                    TrackButton(),
                    if (data['employee'].length > 0 && status != "Pending")
                      AssignedEmployee(title: "Attendedby".tr),
                    if (data['employeefeedback'].length > 0) EmployeeFeedback(),
                    if (data['managerfeedback'].length > 0)
                      ManagerFeedbackList(),
                    status == "Resolved"
                        ? status == "Resolved" &&
                                data['customerfeedback'].length < 1
                            ? UserFeedBack()
                            : UserFeedbackList()
                        : Container(),
                  ],
                ),
              ),
            ),
            if (complainController.ismainloading.value == true)
              Center(
                  child: CircularProgressIndicator(
                color: Lightgreen,
              ))
          ],
        ),
      ),
    );
  }
}
