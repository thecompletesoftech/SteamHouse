import 'package:steamhouse/config/Import.dart';

class ComplainInprocess extends StatefulWidget {
  const ComplainInprocess({super.key});

  @override
  State<ComplainInprocess> createState() => _ComplainInprocessState();
}

class _ComplainInprocessState extends State<ComplainInprocess> {
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
              child: complainController.inprogress.length > 0
                  ? Container(
                      width: size.width,
                      height: size.height * 0.9,
                      color: LightGray,
                      child: ListView.builder(
                        itemCount: complainController.inprogress.length,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            ComplainCard(
                          ticket: "#Tkt " +
                              complainController.inprogress[index]['id']
                                  .toString(),
                          img: complainController.inprogress[index]['pictures']
                              .toString(),
                          reason: complainController.inprogress[index]
                                  ['discription']
                              .toString(),
                          title: complainController.inprogress[index]
                                  ['Service_request']
                              .toString(),
                          companyname: complainController.inprogress[index]
                                  ['user'][0]['name']
                              .toString(),
                          mobile: "+91" +
                              complainController.inprogress[index]['phone']
                                  .toString(),
                          statusmsg: complainController.inprogress[index]
                                      ['status'] ==
                                  2
                              ? "serviceinprocess".tr
                              : "Completed".tr,
                          date: ((complainController
                              .inprogress[index]['date'] == null)||(complainController
                              .inprogress[index]['time'] == null) ) ? '' : (complainController.Datetime(complainController
                              .inprogress[index]['date'].toString())+ ' '+ complainController.inprogress[index]['time'].toString()),
                          color: complainController.inprogress[index]
                                      ['status'] ==
                                  2
                              ? Yellow
                              : Lightgreen,
                          ontap: () {
                            box.read("usertype") == 0
                                ? Get.toNamed(
                                    usercomplaindetailRoute,
                                    arguments:
                                        complainController.inprogress[index],
                                    parameters: {
                                      "status":
                                          complainController.inprogress[index]
                                                      ['status'] ==
                                                  2
                                              ? "Inprocess"
                                              : "Completed",
                                      "statusmsg":
                                          complainController.inprogress[index]
                                                      ['status'] ==
                                                  2
                                              ? "serviceinprocess".tr
                                              : "Completed",
                                    },
                                  )
                                : Get.toNamed(
                                    complaindetailRoute,
                                    arguments:
                                        complainController.inprogress[index],
                                    parameters: {
                                      "status":
                                          complainController.inprogress[index]
                                                      ['status'] ==
                                                  2
                                              ? "Inprocess"
                                              : "Completed",
                                      "statusmsg":
                                          complainController.inprogress[index]
                                                      ['status'] ==
                                                  2
                                              ? "serviceinprocess".tr
                                              : "Completed",
                                    },
                                  );
                          },
                        ),
                      ),
                    )
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
