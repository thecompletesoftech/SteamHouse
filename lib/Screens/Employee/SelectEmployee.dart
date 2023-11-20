import 'dart:developer';
import 'package:steamhouse/config/Import.dart';

class Select_Employee extends StatefulWidget {
  Select_Employee({
    Key? key,
  }) : super(key: key);

  @override
  State<Select_Employee> createState() => _Select_EmployeeState();
}

class _Select_EmployeeState extends State<Select_Employee> {
  EmployeeController employeeController = Get.put(EmployeeController());
  TextEditingController Serach = TextEditingController();
  SelectedEmp _selectedEmp = Get.put(SelectedEmp());

  @override
  void initState() {
    employeeController.Employeelist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: LightGray,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: size.width * 0.94,
        height: size.height * 0.94,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                // color: White,
                decoration: BoxDecoration(
                    border: Border.all(color: LighterGrey),
                    borderRadius: BorderRadius.circular(15),
                    color: White),
                child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  // controller: search,
                  onSubmitted: (value) {
                    // widget.onchange!(value);
                  },
                  onChanged: (value) {
                    log(value.toString());
                    // employeeController.runFilter(value);
                  },
                  onTap: (() {}),
                  style: TextStyles.withColor(TextStyles.mn14, Black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Searchtxt'.tr,
                      hintStyle:
                          TextStyles.withColor(TextStyles.mn14, ReviewHint),
                      prefixIcon: Image.asset(Search)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Obx(
                  () => employeeController.isloading == true
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Green,
                        ))
                      : employeeController.Employeedata.length > 0
                          ? ListView.builder(
                              itemCount: employeeController.Employeedata.length,
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                return select_emp(
                                    employeeController.Employeedata[i], i);
                              },
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
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  select_emp(employeedata, index) {
    return GestureDetector(
      onTap: (() {
        setState(() {
          _selectedEmp.selectedemp(true, employeedata);
        });
        backScreen(context);
      }),
      child: Card(
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
                employeeController.Employeedata[index]['emp_img'] == null
                    ? SvgPicture.asset(
                        Personsvg,
                        height: 55,
                        width: 55,
                        color: ButtonColor,
                      )
                    : CachedNetworkImage(
                        imageUrl: imageurl +
                            employeeController.Employeedata[index]['emp_img'],
                        height: 60,
                        width: 60,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Textfield().text(
                        employeeController.Employeedata[index]['name']
                            .toString(),
                        TextStyles.withColor(TextStyles.mb18, Black),
                        TextAlign.left,
                        TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Textfield().text(
                          "Technician",
                          TextStyles.withColor(TextStyles.mn16, ReviewHint),
                          TextAlign.left),
                    ),
                    Container(
                      child: Textfield().text(
                          employeeController.Employeedata[index]['phone']
                              .toString(),
                          TextStyles.withColor(TextStyles.mn16, ReviewHint),
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
      ).paddingOnly(top: 10),
    );
  }
}
