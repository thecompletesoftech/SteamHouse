import 'package:steamhouse/config/Import.dart';

class AssignEmployee extends StatefulWidget {
  const AssignEmployee({super.key});

  @override
  State<AssignEmployee> createState() => _AssignEmployeeState();
}

class _AssignEmployeeState extends State<AssignEmployee> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;
  SelectedEmp _selectedEmp = Get.put(SelectedEmp());

  @override
  void dispose() {
    _selectedEmp.clearemp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Textfield().text(
            "RequestAssignTo".tr,
            TextStyles.withColor(TextStyles.mb16, Black),
            TextAlign.left,
            TextOverflow.ellipsis,
          ),
        ).paddingSymmetric(horizontal: 5, vertical: 10),
        Container(
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context, builder: (context) => Select_Employee());
            },
            child: Container(
              width: size.width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: PrimaryColor, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Textfield().text(
                    "selectemployee".tr,
                    TextStyles.withColor(TextStyles.mb16, PrimaryColor, 1.0),
                  ),
                  SvgPicture.string(
                    arrowdownicon,
                    height: 8,
                    color: PrimaryColor,
                  ),
                ],
              ).paddingSymmetric(horizontal: 10),
            ),
          ),
        ),
        Obx(
          () => _selectedEmp.emp.value
              ? Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: White,
                  elevation: 1,
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 5),
                          _selectedEmp.empdata['emp_img'] == null
                              ? SvgPicture.asset(
                                  Personsvg,
                                  height: 55,
                                  color: ButtonColor,
                                )
                              : CachedNetworkImage(
                                  imageUrl: _selectedEmp.empdata['emp_img'],
                                  height: 60,
                                  width: 60,
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Center(
                                          child: CircularProgressIndicator(
                                              color: Lightgreen,
                                              value:
                                                  downloadProgress.progress)),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.52,
                                    child: Textfield().text(
                                      _selectedEmp.empdata['name'].toString(),
                                      TextStyles.withColor(
                                          TextStyles.mb18, Black),
                                      TextAlign.left,
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Textfield().text(
                                    "Technician",
                                    TextStyles.withColor(
                                        TextStyles.mn16, ReviewHint),
                                    TextAlign.left),
                              ),
                              Container(
                                child: Textfield().text(
                                    _selectedEmp.empdata['phone'].toString(),
                                    TextStyles.withColor(
                                        TextStyles.mn16, ReviewHint),
                                    TextAlign.left),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 5),
                ).paddingOnly(top: 10)
              : Container(),
        ),
        Obx(
          () => Center(
            child: ElevatedButtons(
                width: 0.82,
                name: 'AssignRequest'.tr,
                loading: complainController.isloading.value,
                onTap: () async {
                  if (_selectedEmp.empdata.length > 0 &&
                      complainController.isloading.value == false)
                    complainController.AssignEmp(data['id'], 1);
                  else {
                    Get.snackbar('Error'.tr, 'Please Select an Employee');
                  }
                  ;
                }).paddingSymmetric(vertical: 15),
          ),
        )
      ],
    ).paddingSymmetric(vertical: 15);
  }
}
