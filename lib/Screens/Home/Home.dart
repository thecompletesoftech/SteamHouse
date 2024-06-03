import 'dart:async';
import 'dart:developer';
import 'package:steamhouse/config/Import.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Home extends StatefulWidget {
  final usertype;

  Home({Key? key, this.usertype}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  HomeController homeController = HomeController();
  ComplainController complainController = Get.put(ComplainController());
  final box = GetStorage();
  var switch_btn = false;
  int _selectedIndex = 0;
  String? dropdownvalue;

  @override
  void initState() {
    homeController.HomeData();
    homeController.startTimer(context);

    super.initState();
  }

  callNumber(number) async {
    var res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    log("helpline" + box.read('helpline').toString());
    var size = MediaQuery.of(context).size;
    var scaffold = Scaffold(
        body: Obx(
      () => Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: PrimaryColor,
            child: SafeArea(
              child: CustomScrollView(shrinkWrap: true, slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: PrimaryColor,
                  expandedHeight: 4,
                  title: SilverAppBar(
                    title: ''.tr,
                    elevation: 0.5,
                    show_arrow_icon: Get.parameters['show'] != 'true' ? 1 : 0,
                    // showimage: true,
                    // image: Largelogo,
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: White,
                      border: Border.all(color: White),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(RoundEdgePadding),
                          topRight: Radius.circular(RoundEdgePadding)),
                    ),
                    child: Column(
                      children: [
                        homeController.homelist.length == 0 &&
                                homeController.isloading == true
                            ? Container(
                                height: size.height * 0.5,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Green,
                                )),
                              )
                            : Container(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Center(
                                      child: Obx(
                                        () => Textfield().text(
                                          homeController.homelist.length > 0
                                              ? homeController.homelist[0]
                                                  ['CompanyName']
                                              : "NAN",
                                          TextStyles.withColor(
                                            TextStyles.mb26,
                                            DarkGreen,
                                          ),
                                          TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              // color: LightGray,
                                              // borderRadius: BorderRadius.circular(10.0),
                                              border: Border(
                                                  right: BorderSide(
                                                      color: Lightgreen,
                                                      width: 1.0),
                                                  bottom: BorderSide(
                                                      color: Lightgreen,
                                                      width: 1.0))),
                                          height: 140,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Textfield().text(
                                                  'pressuretxt'.tr,
                                                  TextStyles.withColor(
                                                      TextStyles.mn20,
                                                      PrimaryColor)),
                                              Container(
                                                width: size.width * 0.5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  border: Border.all(
                                                      color: GrayBorder,
                                                      width: 2.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Obx(
                                                      () => Text(
                                                        homeController.homelist
                                                                    .length >
                                                                0
                                                            ? homeController
                                                                    .homelist[0]
                                                                        [
                                                                        'Pressure']
                                                                    .toString() +
                                                                ' kg/cm2'
                                                            : "NAN",
                                                        style: TextStyles
                                                            .withColor(
                                                          TextStyles.mn18,
                                                          PrimaryColor,
                                                        ),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // child: ,
                                              ).paddingOnly(right: 10),
                                            ],
                                          ),
                                        )
                                            // .paddingOnly(right: 2.5),
                                            ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                // color: LightGray,
                                                // borderRadius: BorderRadius.circular(10.0),
                                                border: Border(
                                                    left: BorderSide(
                                                        color: Lightgreen,
                                                        width: 1.0),
                                                    bottom: BorderSide(
                                                        color: Lightgreen,
                                                        width: 1.0))),
                                            height: 140,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Textfield().text(
                                                    'tempraturetxt'.tr,
                                                    TextStyles.withColor(
                                                        TextStyles.mn20,
                                                        PrimaryColor)),
                                                Container(
                                                  width: size.width * 0.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: Border.all(
                                                        color: GrayBorder,
                                                        width: 2.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                      child: Center(
                                                        child: Obx(
                                                          () => Text(
                                                            homeController
                                                                        .homelist
                                                                        .length >
                                                                    0
                                                                ? homeController
                                                                        .homelist[
                                                                            0][
                                                                            'Temperature']
                                                                        .toString() +
                                                                    ' °C'
                                                                : "NAN",
                                                            style: TextStyles
                                                                .withColor(
                                                              TextStyles.mn18,
                                                              PrimaryColor,
                                                            ),
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // child: ,
                                                ).paddingOnly(left: 10)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      color: Lightgreen,
                                                      width: 1.0),
                                                  top: BorderSide(
                                                      color: Lightgreen,
                                                      width: 1.0))),
                                          height: 140,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Textfield().text(
                                                  'flowtxt'.tr,
                                                  TextStyles.withColor(
                                                      TextStyles.mn20,
                                                      PrimaryColor)),
                                              Container(
                                                width: size.width * 0.5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  border: Border.all(
                                                      color: GrayBorder,
                                                      width: 2.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Obx(
                                                      () => Text(
                                                        homeController.homelist
                                                                    .length >
                                                                0
                                                            ? homeController.homelist[
                                                                            0][
                                                                        'locationname'] ==
                                                                    'Ankleshwar' || homeController.homelist[
                                                                            0][
                                                                        'locationname'] ==
                                                                    'Dahej'
                                                                ? homeController
                                                                        .homelist[
                                                                            0][
                                                                            'Flow']
                                                                        .toString() +
                                                                    ' Ton/Hr'
                                                                : homeController
                                                                        .homelist[
                                                                            0][
                                                                            'Flow']
                                                                        .toString() +
                                                                    ' Kg/Hr'
                                                            : "NAN",
                                                        style: TextStyles
                                                            .withColor(
                                                          TextStyles.mn18,
                                                          PrimaryColor,
                                                        ),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ).paddingOnly(right: 10),
                                            ],
                                          ),
                                        )),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    left: BorderSide(
                                                        color: Lightgreen,
                                                        width: 1.0),
                                                    top: BorderSide(
                                                        color: Lightgreen,
                                                        width: 1.0))),
                                            height: 140,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Textfield().text(
                                                    'totalizertxt'.tr,
                                                    TextStyles.withColor(
                                                        TextStyles.mn20,
                                                        PrimaryColor)),
                                                Container(
                                                  width: size.width * 0.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: Border.all(
                                                        color: GrayBorder,
                                                        width: 2.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                      child: Obx(
                                                        () => Text(
                                                          homeController
                                                                      .homelist
                                                                      .length >
                                                                  0
                                                              ? homeController.homelist[0]
                                                                          [
                                                                          'locationname'] ==
                                                                      'Ankleshwar' || homeController.homelist[0]
                                                                          [
                                                                          'locationname'] ==
                                                                      'Dahej'
                                                                  ? homeController
                                                                          .homelist[
                                                                              0]
                                                                              [
                                                                              'Totalizer']
                                                                          .toString() +
                                                                      ' Tonnes'
                                                                  : homeController
                                                                          .homelist[
                                                                              0]
                                                                              [
                                                                              'Totalizer']
                                                                          .toString() +
                                                                      ' Kg'
                                                              : "NAN",
                                                          style: TextStyles
                                                              .withColor(
                                                            TextStyles.mn18,
                                                            PrimaryColor,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ).paddingOnly(left: 10),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Textfield().text(
                                'homemsgtxt'.tr,
                                TextStyles.withColor(
                                    TextStyles.mn16, ButtonColor)),
                          ],
                        ).paddingOnly(top: 30),
                        Obx(
                          () => Center(
                            child: Textfield().text(
                                homeController.homelist.length > 0
                                    ? homeController.homelist[0]
                                                ['LastReading'] ==
                                            ""
                                        ? 'NAN'
                                        : homeController.homelist[0]
                                                ['LastReading']
                                            .toString()
                                    : 'NAN',
                                TextStyles.withColor(
                                    TextStyles.mb16, Lightgreen)),
                          ).paddingSymmetric(vertical: 20),
                        ),
                        if (Get.parameters['show'] != 'true')
                          ElevatedButtons(
                            name: 'RaiseserviceRequest'.tr,
                            onTap: () {
                              Get.toNamed(
                                addcomplainRoute,
                              );
                            },
                          ).paddingSymmetric(horizontal: 30),
                        if (Get.parameters['show'] != 'true')
                          ElevatedButtons(
                            height: 35,
                            borderRadius: 10,
                            colorbtn: LightPink,
                            txtcolor: White,
                            name: 'helplinetxt'.tr,
                            onTap: () {
                              callNumber(box.read('helpline').toString());
                            },
                          ).paddingSymmetric(horizontal: 80, vertical: 20),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse("mailto:customer.care@steamhouse.in"));
                          },
                          child: Textfield()
                              .text(
                                'customer.care@steamhouse.in',
                                TextStyles.withColor(
                                    TextStyles.mn16, Lightgreen),
                              )
                              .paddingOnly(bottom: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  largelogo,
                  height: 75,
                ),
              ),
            ),
          ).marginOnly(top: size.height * 0.06),
        ],
      ),
    ));
    return scaffold;
  }
}
