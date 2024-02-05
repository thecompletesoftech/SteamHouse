import 'package:steamhouse/config/Import.dart';

class ComplainCompleted extends StatefulWidget {
  const ComplainCompleted({super.key});

  @override
  State<ComplainCompleted> createState() => _ComplainCompletedState();
}

class _ComplainCompletedState extends State<ComplainCompleted> {
  ComplainController complainController = Get.put(ComplainController());
  final box = GetStorage();

  @override
  void initState() {
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   complainController.CompanyList();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => complainController.isloading == true
          ? Center(
              child: CircularProgressIndicator(
              color: Green,
            ))
          : RefreshIndicator(
              color: Lightgreen,
              onRefresh: () => complainController.ComplainList(),
              child: complainController.completed.length > 0
                  ? Container(
                      width: size.width,
                      height: size.height * 0.9,
                      color: LightGray,
                      child: ListView.builder(
                          itemCount: complainController.completed.length,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              ComplainCard(
                                ticket: "#Tkt " +
                                    complainController.completed[index]['id']
                                        .toString(),
                                img: complainController.completed[index]
                                        ['pictures']
                                    .toString(),
                                reason: complainController.completed[index]
                                        ['discription']
                                    .toString(),
                                title: complainController.completed[index]
                                        ['Service_request']
                                    .toString(),
                                companyname: complainController.completed[index]
                                        ['user'][0]['name']
                                    .toString(),
                                mobile: "+91" +
                                    complainController.completed[index]['phone']
                                        .toString(),
                                statusmsg: "Resolved".tr,
                                date: ((complainController
                              .completed[index]['date'] == null)||(complainController
                              .completed[index]['time'] == null) ) ? '' : (complainController.Datetime(complainController
                              .completed[index]['date'].toString())+ ' '+ complainController.completed[index]['time'].toString()),
                                color: Lightgreen,
                                ontap: () {
                                  box.read("usertype") == 0
                                      ? Get.toNamed(
                                          usercomplaindetailRoute,
                                          arguments: complainController
                                              .completed[index],
                                          parameters: {
                                            "status": "Resolved",
                                            "statusmsg": "Resolved".tr
                                          },
                                        )
                                      : Get.toNamed(
                                          complaindetailRoute,
                                          arguments: complainController
                                              .completed[index],
                                          parameters: {
                                            "status": "Resolved",
                                            "statusmsg": "Resolved".tr
                                          },
                                        );
                                },
                              )))
                  : Center(
                      child: Textfield().text(
                        "nodata".tr,
                        TextStyles.withColor(
                          TextStyles.mn18,
                          PrimaryColor,
                        ),
                      ),
                    ),
            ),
    );
  }
}
