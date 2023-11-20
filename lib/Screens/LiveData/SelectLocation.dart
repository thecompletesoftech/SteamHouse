import '../../Config/Import.dart';

class SelectLocation extends StatefulWidget {
  final data;
  final locationlist;
  final Function? ontap;
  SelectLocation({
    Key? key,
    this.locationlist,
    this.data,
    this.ontap,
  }) : super(key: key);

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  LiveController liveController = Get.put(LiveController());
  @override
  void initState() {
    liveController.dropdownvalue.value = widget.locationlist[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                          color: Bordercolor,
                          style: BorderStyle.solid,
                          width: 1),
                    ),
                    child: Obx(
                      () => DropdownButton(
                        isExpanded: true,
                        value: liveController.dropdownvalue.toString(),
                        underline:
                            DropdownButtonHideUnderline(child: Container()),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: widget.locationlist
                            .map<DropdownMenuItem<String>>(
                                (value) => new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    ))
                            .toList(),
                        onChanged: (String? newValue) {
                          liveController.setDropDownValue(
                              newValue, widget.data);
                        },
                      ),
                    ),
                  ).paddingSymmetric(vertical: 20),
                  ElevatedButtons(
                    name: 'submit'.tr,
                    onTap: () {
                      liveController.Livedatafilter();
                      Get.back();
                    },
                  ).paddingOnly(top: 10),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // )
      // : Center(
      //     child: Textfield().text(
      //       "nodata".tr,
      //       TextStyles.withColor(
      //         TextStyles.mn18,
      //         PrimaryColor,
      //       ),
      //     ),
      //   ),
    );
  }
}
