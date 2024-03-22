import 'package:steamhouse/config/Import.dart';

class Profile extends StatefulWidget {
  final usertype;
  Profile({Key? key, this.usertype}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LoginController loginController = Get.put(LoginController());
  ProfileController profileController = Get.put(ProfileController());
  var switch_btn = false;
  final box = GetStorage();
  List lang = ["english".tr, "french".tr];
  String? dropdownvalue;
  @override
  void initState() {
    setState(() {
      if (box.read('notify') == '1') {
        setState(() {
          switch_btn = true;
        });
      } else {
        setState(() {
          switch_btn = false;
        });
      }
    });
    super.initState();
  }

  callNumber(number) async {
    var res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Stack(
        children: [
          Header(
            title: 'Profile'.tr,
            elevation: 0.5,
            show_arrow_icon: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Textfield()
                    .text("Hello".tr + box.read('name').toString(),
                        TextStyles.withColor(TextStyles.mb20, DarkGreen))
                    .paddingSymmetric(horizontal: 10),
                SizedBox(height: 20),
                Profilemenu(PersonIcon, 'edit_Profilext'.tr, () async {
                  Get.toNamed(editrouteRoute, parameters: {"pageIndex": "0"});
                }),
                SizedBox(height: box.read('usertype') == 1 ? 20 : 0),
                if (box.read('usertype') == 1)
                  Profilemenu(locationicon, 'livesteam'.tr, () async {
                    Get.toNamed(livedataRoute);
                  }),
                // SizedBox(
                //     height: box.read('usertype') == 1 ? 20 : 0),
                // Profilemenu(toolsicon, 'complaintxt'.tr,
                //     () async {
                //   nextScreen(
                //       context,
                //       BottomnavigationBar(
                //         pageIndex:
                //             box.read('usertype') == 0 ? 1 : 0,
                //         usertype: box.read('usertype'),
                //       ));
                // }),
                SizedBox(height: 20),
                Profilemenu(PushnotificationIcon, 'push_Notificationxt'.tr,
                    () {}, switch_btn, (bool value) {
                  setState(() {
                    switch_btn = value;
                  });
                  if (switch_btn == true) {
                    profileController.Notificationupdate('1');
                  } else {
                    profileController.Notificationupdate('0');
                  }
                }),
                SizedBox(height: box.read('usertype') == 0 ? 20 : 0),
                if (box.read('usertype') == 0)
                  Profilemenu(CallIcon, 'Contactustxt'.tr, () async {
                    print('/-----------/ ' + box.read('helpline').toString());
                    callNumber(box.read('helpline').toString());
                  }),
                SizedBox(height: 20),
                box.read('usertype') == 1
                    ? Profilemenu(PersonIcon, 'employeelist'.tr, () async {
                        Get.toNamed(
                          employeelistRoute,
                        );
                      })
                    : SizedBox(),
                SizedBox(height: box.read('usertype') == 1 ? 20 : 0),
                box.read('usertype') == 0
                    ? Profilemenu(toolsicon, 'RaiseComplain'.tr, () async {
                        Get.toNamed(
                          addcomplainRoute,
                        );
                      })
                    : box.read('usertype') == 1
                        ? Profilemenu(buildingicon, 'CompanyList'.tr, () async {
                            Get.toNamed(
                              companylistRoute,
                            );
                          })
                        : Container(),
                SizedBox(height: box.read('usertype') != 2 ? 20 : 0),
                Profilemenu(
                  LogoutIcon,
                  'logouttxt'.tr,
                  () async {
                    showDialog(
                      context: context,
                      builder: (context) => StatefulBuilder(
                        builder: (context, StateSetter setState) {
                          return Cancel_req_dialog(
                            leftbtnname: 'No',
                            rightbtnname: 'Yes',
                            showhead: false,
                            leftbtnnameontap: () {
                              backScreen(context);
                            },
                            rightbtnnameontap: () async {
                              backScreen(context);
                              loginController.logout();
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Textfield().text(
                                        "Are you sure want to Logout".tr,
                                        TextStyles.withColor(
                                            TextStyles.mn16, PrimaryColor),
                                        TextAlign.center),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    child: SvgPicture.string(
                                      LogoutIcon,
                                      height: 50,
                                    ),
                                  ),
                                  Textfield()
                                      .text(
                                        'logouttxt'.tr,
                                        TextStyles.withColor(
                                            TextStyles.mb26, Green),
                                      )
                                      .paddingOnly(top: 20),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          if (loginController.isloadinglogout.value == true)
            Center(
              child: CircularProgressIndicator(
                color: Lightgreen,
              ),
            ),
        ],
      ),
    );
  }

  Profilemenu(img, menuname,
      [Function? ontap, switch_btn_name, Function? switch_tap]) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: White,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 1,
              color: Color.fromRGBO(1, 1, 1, 0.05),
            )
          ]),
      height: 60,
      child: InkWell(
        onTap: () {
          ontap!();
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 10, top: 0, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black)
                          ),
                      child: SvgPicture.string(
                        img,
                        height: 23,
                        width: 100,
                        color: DarkGreen,
                      )),
                  SizedBox(width: 10),
                  Container(
                    width: size.width * 0.5,
                    child: Textfield().text(
                        menuname,
                        TextStyles.withletterspacing(
                            TextStyles.mw50016, DarkText, 0.5, 1.2)),
                  ),
                ],
              ),
              menuname == 'push_Notificationxt'.tr
                  ? CustomSwitch(
                      value: switch_btn_name,
                      onChanged: (bool value) {
                        switch_tap!(value);
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
