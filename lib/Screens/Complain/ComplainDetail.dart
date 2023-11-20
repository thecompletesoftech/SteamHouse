import 'dart:developer';

import 'package:steamhouse/Screens/Complain/ComplainComponents/CloseTicketButton.dart';
import 'package:steamhouse/config/Import.dart';

class ComplainDetail extends StatefulWidget {
  const ComplainDetail({
    super.key,
  });

  @override
  State<ComplainDetail> createState() => _ComplainDetailState();
}

class _ComplainDetailState extends State<ComplainDetail> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;
  var status = Get.parameters['status'];
  var statusmsg = Get.parameters['statusmsg'];
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // log("detail" + data.toString());
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Header(
              title: 'ComplainDetail'.tr,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
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
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.5,
                              child: Textfield().text(
                                data['user'].length > 0
                                    ? data['user'][0]['name'].toString()
                                    : 'NAN',
                                TextStyles.withColor(
                                  TextStyles.mb18,
                                  PrimaryColor,
                                ),
                              ),
                            ),
                            if (box.read('usertype') == 1)
                              GestureDetector(
                                onTap: () {
                                  box
                                      .write(
                                          "meterid",
                                          data['user'].length > 0
                                              ? data['user'][0]['meter_id']
                                              : null)
                                      .toString();

                                  Get.toNamed(homeRoute,
                                      parameters: {'show': 'true'});
                                },
                                child: Textfield().text(
                                  'livesteam'.tr,
                                  TextStyles.withColor(
                                    TextStyles.mb16,
                                    Lightgreen,
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      UserAddressandCall(),
                      SizedBox(
                        height: 10,
                      ),
                      TitleandDiscription(),
                      SizedBox(
                        height: 10,
                      ),
                      RequestImage(),
                      RequestStatusmsg(),
                      TrackButton(),
                      if (box.read('usertype') == 1 &&
                          data['employee'].length > 0)
                        AssignedEmployee(title: 'Assignto'.tr),
                      SizedBox(
                        height: status != "Pending" ? 10 : 0,
                      ),
                      if (data['employeefeedback'].length > 0)
                        EmployeeFeedback(),
                      if (status == 'Completed' &&
                          data['managerfeedback'].length < 1)
                        if (box.read('usertype') == 1) CloseTicketButton(),
                      if (data['managerfeedback'].length > 0)
                        ManagerFeedbackList(),
                      // status == "Completed" &&
                      if (box.read("usertype") == 1 &&
                          data['customerfeedback'].length > 0)
                        UserFeedbackList(),
                      box.read("usertype") == 1 && status == "Pending"
                          ? AssignEmployee()
                          : box.read("usertype") == 2 && status == "Pending"
                              ? CheckInButton()
                              : box.read("usertype") == 2 &&
                                      status == "Inprocess"
                                  ? EmployeeAddReview()
                                  : Container(),
                    ],
                  ),
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
