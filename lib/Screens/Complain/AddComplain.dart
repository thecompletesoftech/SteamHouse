import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:steamhouse/config/Import.dart';

class AddComplain extends StatefulWidget {
  AddComplain({Key? key}) : super(key: key);

  @override
  State<AddComplain> createState() => _AddComplainState();
}

class _AddComplainState extends State<AddComplain> {
  ComplainController complainController = Get.put(ComplainController());
  final _formKey = GlobalKey<FormState>();
  // List<XFile>? ComplainImage;
  final box = GetStorage();
  var selectdate;
  @override
  void initState() {
    complainController.phone.text = box.read('phone');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                title: 'ServiceRequesttxt'.tr,
                elevation: 0.5,
                show_arrow_icon: 0,
              ),
            ),
            SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: White,
                    border: Border.all(color: White),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(RoundEdgePadding),
                        topRight: Radius.circular(RoundEdgePadding)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: SvgPicture.string(
                              toolicon,
                              height: 60,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Textfield().text(
                              'ServiceRequesttxt'.tr,
                              TextStyles.withColor(
                                  TextStyles.mw50016, DarkText)),
                          TextBoxwidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: complainController.name,
                            hinttext: 'EnterCompanyNametxt'.tr,
                            hintstyle:
                                TextStyles.withColor(TextStyles.mn14, Gray),
                            Bgcolor: White,
                            style:
                                TextStyles.withColor(TextStyles.mn14, DarkText),
                            iconorimage: true,
                            maxlength: 50,
                            readtype: false,
                            ontap: () {},
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Textfield().text(
                              'clickpicturetxt'.tr,
                              TextStyles.withColor(
                                  TextStyles.mw50016, DarkText)),
                          Container(
                              height: 100,
                              child: Row(
                                children: [
                                  if (complainController.SendImage.length > 0)
                                    Expanded(
                                      child: Container(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: complainController
                                              .SendImage.length,
                                          shrinkWrap: true,
                                          // physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Stack(children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: PrimaryColor)),
                                              height: 80,
                                              width: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  File(complainController
                                                      .SendImage[index].path),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ).paddingAll(5.0),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    complainController.SendImage
                                                                .length ==
                                                            1
                                                        ? complainController
                                                            .SendImage = []
                                                        : complainController
                                                                .SendImage
                                                            .removeAt(index);
                                                  });
                                                },
                                                child: Container(
                                                  child: Icon(
                                                    Icons.remove_circle,
                                                    size: 30,
                                                    color: Lightred,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                  GestureDetector(
                                    onTap: () async {
                                      _getFromGallery();
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: LightGray,
                                      ),
                                      child: Center(
                                        child: SvgPicture.string(
                                          cameraicon,
                                          height: 45,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ).paddingSymmetric(horizontal: 10),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Textfield().text(
                              'contactpersontxt'.tr,
                              TextStyles.withColor(
                                  TextStyles.mw50016, DarkText)),
                          IntlPhoneField(
                            // controller: registerationController.phoneNo,
                            dropdownIconPosition: IconPosition.trailing,
                            showCountryFlag: false,
                            dropdownIcon: Icon(
                              FontAwesomeIcons.chevronDown,
                              size: 15,
                            ),
                            style: TextStyles.mw50016,
                            dropdownTextStyle:
                                TextStyles.withColor(TextStyles.mw50016, Gray),
                            decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Gray,
                                  ),
                                )),
                            initialCountryCode: 'IN',
                            controller: complainController.phone,
                            onChanged: (phone) {
                              // registerationController.ContryCode.value =
                              //     phone.countryCode;
                              print(phone.countryCode);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Textfield().text(
                              'selectdate'.tr,
                              TextStyles.withColor(
                                  TextStyles.mw50016, DarkText)),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: (() async {
                              await selectDatepicker(context, 0);
                            }),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(width: 1.0, color: Gray)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Textfield().text(
                                      selectdate == null
                                          ? "selectdate".tr
                                          : selectdate.toString(),
                                      TextStyles.withColor(
                                          TextStyles.mn14,
                                          selectdate == null
                                              ? ReviewHint
                                              : DarkText),
                                      TextAlign.center),
                                  Icon(
                                    Icons.calendar_today,
                                    color: PrimaryColor,
                                  )
                                ],
                              ).paddingSymmetric(vertical: 3),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextBoxwidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            hinttext: 'complainhint'.tr,
                            showborder: false,
                            controller: complainController.complaindesc,
                            hintstyle: TextStyles.withColor(
                                TextStyles.mw40016, ReviewHint),
                            Bgcolor: White,
                            leftpadding: 10.0,
                            radius: 20,
                            style:
                                TextStyles.withColor(TextStyles.mn14, DarkText),
                            iconorimage: true,
                            readtype: false,
                            maxline: 6,
                            showoutlineborder: true,
                            maxlength: 200,
                            ontap: () {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => Center(
                                child: ElevatedButtons(
                                    width: 0.82,
                                    name: 'submit'.tr,
                                    loading: complainController.isloading.value,
                                    onTap: () async {
                                      if (complainController.isloading.value ==
                                          false) if (_formKey.currentState!.validate()) {
                                        complainController.Addcomplain();
                                      }
                                    })).paddingSymmetric(vertical: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ]))),
    );
  }

  _getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile> pickedFileList = await _picker.pickMultiImage(
      imageQuality: 30,
    );
    if (pickedFileList.length > 3)
      Get.snackbar('Error'.tr, 'Imguploadmsg'.tr, backgroundColor: White);
    else {
      setState(() {
        // ComplainImage = pickedFileList;
        complainController.SendImage = pickedFileList;
      });
    }
  }

  selectDatepicker(cntxt, mode) async {
    // var selectedDate;
    if (Platform.isAndroid) {
      final DateTime? pickedDate = await showDatePicker(
        initialDate: DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime.now().add(Duration(days: 1)),
        lastDate: DateTime(2100),
        context: Get.context!,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
      );
      if (pickedDate != null) {
        setState(() {
          selectdate = DateFormat("yyyy-MM-dd").format(pickedDate);
        });
      }
    } else {
      showCupertinoModalPopup(
          context: cntxt,
          builder: (_) => Container(
                height: 190,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    Container(
                      height: 180,
                      child: CupertinoDatePicker(
                          mode: mode == 0
                              ? CupertinoDatePickerMode.date
                              : CupertinoDatePickerMode.time,
                          initialDateTime: DateTime.now(),
                          minimumDate: DateTime(
                              DateTime.now().year, DateTime.now().month),
                          maximumDate: DateTime(2100),
                          onDateTimeChanged: (val) {
                            // print()
                            setState(() {
                              selectdate = DateFormat("yyyy-MM-dd").format(val);
                            });
                            // selectedDate = val;
                            // print(val.toString());
                            // var Date = DateFormat("yyyy-MM-dd")
                            //     .format(selectedDate.value);
                          }),
                    ),
                  ],
                ),
              ));
    }
  }
}
