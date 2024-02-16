import 'dart:developer';

import 'package:steamhouse/config/Import.dart';

class LiveData extends StatefulWidget {
  const LiveData({super.key});

  @override
  State<LiveData> createState() => _LiveDataState();
}

class _LiveDataState extends State<LiveData> {
  LiveController liveController = Get.put(LiveController());
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    liveController.Live();
    liveController.startTimer();
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // log("list" + liveController.locationList.toString());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBarHeight),
        child: Appbartext(
          title: 'livesteam'.tr,
          elevation: 0.0,
          show_arrow_icon: 0,
          show_icon: 1,
          icon: Icons.location_on,
          imagecolor: Lightgreen,
          ontap: () {
            log("-------------" + liveController.locationList.toString());
            liveController.Live();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return SelectLocation(
                      locationlist: liveController.locationList.unique(),
                      data: liveController.companydata,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      body: Obx(
        () => liveController.companydata.length == 0 &&
                liveController.isloading == true
            ? Center(
                child: CircularProgressIndicator(
                color: Green,
              ))
            : liveController.companydata.length > 0
                ? RefreshIndicator(
                    color: Lightgreen,
                    onRefresh: () => liveController.recall(),
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Table(
                              border:
                                  TableBorder.all(color: Bordercolor, width: 1),
                              columnWidths: const {
                                0: FlexColumnWidth(5),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(2.5),
                                3: FlexColumnWidth(3),
                                4: FlexColumnWidth(3),
                                5: FlexColumnWidth(3.5),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Text(
                                      "CustomerName",
                                      style: TextStyles.withColor(
                                        TextStyles.mb14,
                                        Darkgray,
                                      ),
                                      textAlign: TextAlign.center,
                                    ).paddingSymmetric(vertical: 5),
                                    Text(
                                      "Flow",
                                      style: TextStyles.withColor(
                                        TextStyles.mb14,
                                        Darkgray,
                                      ),
                                      textAlign: TextAlign.center,
                                    ).paddingSymmetric(vertical: 5),
                                    Text(
                                      "Pressure",
                                      style: TextStyles.withColor(
                                        TextStyles.mb14,
                                        Darkgray,
                                      ),
                                      textAlign: TextAlign.center,
                                    ).paddingSymmetric(vertical: 5),
                                    Text(
                                      "Temperature",
                                      style: TextStyles.withColor(
                                        TextStyles.mb14,
                                        Darkgray,
                                      ),
                                      textAlign: TextAlign.center,
                                    ).paddingSymmetric(vertical: 5),
                                    Text(
                                      "Totalizer",
                                      style: TextStyles.withColor(
                                        TextStyles.mb14,
                                        Darkgray,
                                      ),
                                      textAlign: TextAlign.center,
                                    ).paddingSymmetric(vertical: 5),
                                    Text(
                                      "Last Reading Time",
                                      style: TextStyles.withColor(
                                        TextStyles.mb14,
                                        Darkgray,
                                      ),
                                      textAlign: TextAlign.center,
                                    ).paddingSymmetric(vertical: 5),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: liveController.companydata.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  Obx(
                                () => Table(
                                  border: TableBorder(
                                    left: BorderSide(
                                        color: Bordercolor, width: 1),
                                    right: BorderSide(
                                        color: Bordercolor, width: 1),
                                    top: BorderSide(
                                        color: Bordercolor,
                                        width: liveController
                                                    .companydata[index] ==
                                                liveController.companydata.first
                                            ? 0
                                            : 0.5),
                                    bottom: BorderSide(
                                        color: Bordercolor,
                                        width: liveController
                                                    .companydata[index] ==
                                                liveController.companydata.last
                                            ? 1.0
                                            : 0.5),
                                    horizontalInside: BorderSide(
                                        color: Bordercolor, width: 1.0),
                                    verticalInside: BorderSide(
                                        color: Bordercolor, width: 1.0),
                                  ),
                                  columnWidths: const {
                                    0: FlexColumnWidth(5),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(2.5),
                                    3: FlexColumnWidth(3),
                                    4: FlexColumnWidth(3),
                                    5: FlexColumnWidth(3.5),
                                  },
                                  children: [
                                    TableRow(children: [
                                      Container(
                                        child: Text(
                                          liveController.companydata[index]
                                                      ['CompanyName']
                                                  .toString() +
                                              " ( " +
                                              liveController.companydata[index]
                                                      ['locationname']
                                                  .toString() +
                                              " )",
                                          style: TextStyles.withColor(
                                            TextStyles.mn12,
                                            Darkgray,
                                          ),
                                          textAlign: TextAlign.center,
                                        ).paddingSymmetric(vertical: 5),
                                      ),
                                      Container(
                                        child: Text(
                                          liveController.companydata[index]
                                                  ['Flow']
                                              .toString(),
                                          style: TextStyles.withColor(
                                            TextStyles.mn12,
                                            Darkgray,
                                          ),
                                          textAlign: TextAlign.center,
                                        ).paddingSymmetric(vertical: 5),
                                      ),
                                      Container(
                                        child: Text(
                                          liveController.companydata[index]
                                                  ['Pressure']
                                              .toString(),
                                          style: TextStyles.withColor(
                                            TextStyles.mn12,
                                            Darkgray,
                                          ),
                                          textAlign: TextAlign.center,
                                        ).paddingSymmetric(vertical: 5),
                                      ),
                                      Container(
                                        child: Text(
                                          liveController.companydata[index]
                                                  ['Temperature']
                                              .toString(),
                                          style: TextStyles.withColor(
                                            TextStyles.mn12,
                                            Darkgray,
                                          ),
                                          textAlign: TextAlign.center,
                                        ).paddingSymmetric(vertical: 5),
                                      ),
                                      Container(
                                        child: Text(
                                          liveController.companydata[index]
                                                  ['Totalizer']
                                              .toString(),
                                          style: TextStyles.withColor(
                                            TextStyles.mn12,
                                            Darkgray,
                                          ),
                                          textAlign: TextAlign.center,
                                        ).paddingSymmetric(vertical: 5),
                                      ),
                                      Container(
                                        child: Text(
                                          liveController.companydata[index]
                                                  ['LastReading']
                                              .toString(),
                                          style: TextStyles.withColor(
                                            TextStyles.mn12,
                                            Darkgray,
                                          ),
                                          textAlign: TextAlign.center,
                                        ).paddingSymmetric(vertical: 5),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 10, vertical: 20),
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
