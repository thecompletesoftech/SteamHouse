import 'package:steamhouse/Screens/Track/TrackController.dart';
import 'package:steamhouse/config/Import.dart';

class TrackComplain extends StatefulWidget {
  final id;
  const TrackComplain({super.key, this.id});

  @override
  State<TrackComplain> createState() => _TrackComplainState();
}

class _TrackComplainState extends State<TrackComplain> {
  TrackController trackController = Get.put(TrackController());
  var id = Get.arguments;
  void initState() {
    trackController.Track(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // log("dataaaaaaa" + trackController.trackList.toString());
    return Scaffold(
      body: RefreshIndicator(
        color: Lightgreen,
        onRefresh: (() => trackController.Track(id)),
        child: Header(
          title: 'trackingstatus'.tr,
          elevation: 0.5,
          show_arrow_icon: 0,
          child: Obx(
            () => trackController.isloading == true
                ? Center(
                    child: CircularProgressIndicator(
                    color: Green,
                  ))
                : trackController.trackList.length > 0
                    ? Column(children: [
                        Center(
                          child: Textfield().text('tkt'.tr + id.toString(),
                              TextStyles.withColor(TextStyles.mb16, Darkgray)),
                        ).paddingOnly(top: 20),
                        Center(
                          child: Textfield().text(
                              'ServiceRequeststatus'.tr,
                              TextStyles.withColor(
                                  TextStyles.mb16, Lightgreen)),
                        ).paddingOnly(top: 10, bottom: 20),
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                              itemCount: trackController.trackList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.string(
                                        trackController.trackList[index] ==
                                                trackController.trackList.last
                                            ? locationicon
                                            : circledoticon,
                                        height: 25,
                                        color: trackController.trackList[index]
                                                    ['status'] ==
                                                0
                                            ? Grey1
                                            : trackController.trackList[index]
                                                        ['status'] ==
                                                    1
                                                ? Orange
                                                : trackController.trackList[
                                                            index]['status'] ==
                                                        2
                                                    ? Lightgreen
                                                    : Yellow,
                                      ).paddingSymmetric(
                                          horizontal: trackController
                                                      .trackList[index] ==
                                                  trackController.trackList.last
                                              ? 19
                                              : 15),
                                      Expanded(
                                        child: Textfield().text(
                                            trackController.trackList[index]
                                                    ['name']
                                                .toString(),
                                            TextStyles.withColor(
                                                TextStyles.mb16, LightText)),
                                      ),
                                      Container(
                                        child: Textfield().text(
                                            trackController.trackList[index]
                                                        ['updated_at'] ==
                                                    null
                                                ? ''
                                                : trackController.OnlyDate(
                                                    trackController
                                                        .trackList[index]
                                                            ['updated_at']
                                                        .toString()),
                                            TextStyles.withColor(
                                                TextStyles.mn14, Lightgreen)),
                                      )
                                    ],
                                  ).paddingSymmetric(vertical: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.string(
                                        lineicon,
                                        color: trackController
                                                    .trackList[index] ==
                                                trackController.trackList.last
                                            ? LightGray
                                            : trackController.trackList[index]
                                                        ['status'] ==
                                                    2
                                                ? Lightgreen
                                                : Black,
                                      ).paddingSymmetric(horizontal: 25),
                                      Expanded(
                                        child: Textfield()
                                            .text(
                                                trackController.trackList[index]
                                                            ['detail'] ==
                                                        null
                                                    ? ''
                                                    : trackController
                                                        .trackList[index]
                                                            ['detail']
                                                        .toString(),
                                                TextStyles.withColor(
                                                    TextStyles.mn14, LightText))
                                            .paddingOnly(right: 3),
                                      ),
                                      Textfield()
                                          .text(
                                              trackController.trackList[index]
                                                          ['updated_at'] ==
                                                      null
                                                  ? ''
                                                  : trackController.Onlytime(
                                                      trackController
                                                          .trackList[index]
                                                              ['updated_at']
                                                          .toString()),
                                              TextStyles.withColor(
                                                  TextStyles.mn14, Lightgreen))
                                          .paddingOnly(right: 5)
                                    ],
                                  ).paddingSymmetric(vertical: 5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ])
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
        ),
      ),
    );
  }
}
