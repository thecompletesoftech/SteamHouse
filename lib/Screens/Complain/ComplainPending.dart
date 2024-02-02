import 'package:steamhouse/config/Import.dart';

class ComplainPending extends StatefulWidget {
  const ComplainPending({super.key});

  @override
  State<ComplainPending> createState() => _ComplainPendingState();
}

class _ComplainPendingState extends State<ComplainPending> {
  ComplainController complainController = Get.put(ComplainController());
  final box = GetStorage();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      complainController.ComplainList();
    });
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
              child: complainController.pending.length > 0
                  ? Container(
                      width: size.width,
                      height: size.height * 0.9,
                      color: LightGray,
                      child: ListView.builder(
                        itemCount: complainController.pending.length,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            ComplainCard(
                          ticket: "#Tkt " +
                              complainController.pending[index]['id']
                                  .toString(),
                          img: complainController.pending[index]['pictures']
                              .toString(),
                          reason: complainController.pending[index]
                                  ['discription']
                              .toString(),
                          title: complainController.pending[index]
                                  ['Service_request']
                              .toString(),
                          companyname: complainController.pending[index]['user']
                                  [0]['name']
                              .toString(),
                          // address: complainController.pending[index]['address']
                          //     .toString(),
                          mobile: "+91" +
                              complainController.pending[index]['phone']
                                  .toString(),
                          statusmsg: box.read("usertype") == 0
                              ? complainController.pending[index]['status'] == 0
                                  ? "Pending".tr
                                  : "Assigned".tr
                              : box.read("usertype") == 1
                                  ? complainController.pending[index]
                                              ['status'] ==
                                          0
                                      ? "Accept"
                                      : "Assigned".tr
                                  : "Accept",
                          date:((complainController
                              .pending[index]['date'] == null)||(complainController
                              .pending[index]['time'] == null) ) ? '' : (complainController.Datetime(complainController
                              .pending[index]['date'].toString())+ ' '+ complainController.pending[index]['time'].toString()),
                          color: box.read("usertype") == 2
                              ? Lightred
                              : complainController.pending[index]['status'] == 0
                                  ? Lightred
                                  : Darkblue,
                          ontap: () {
                            box.read("usertype") == 0
                                ? Get.toNamed(
                                    usercomplaindetailRoute,
                                    arguments:
                                        complainController.pending[index],
                                    parameters: {
                                      "status": complainController
                                                  .pending[index]['status'] ==
                                              0
                                          ? "Pending".tr
                                          : "Assigned".tr,
                                      "statusmsg": "Waiting for Acceptance"
                                    },
                                  )
                                : Get.toNamed(
                                    complaindetailRoute,
                                    arguments:
                                        complainController.pending[index],
                                    parameters: {
                                      "status": "Pending".tr,
                                      "statusmsg": "Waiting for Acceptance"
                                    },
                                  );
                          },
                        ),
                      ))
                  : complainController.isloading != true
                      ? Center(
                          child: Textfield().text(
                            "nodata".tr,
                            TextStyles.withColor(
                              TextStyles.mn18,
                              PrimaryColor,
                            ),
                          ),
                        )
                      : Container(),
            ),
    );
  }
}
