import 'package:steamhouse/config/Import.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  EmployeeController employeeController = Get.put(EmployeeController());
  @override
  void initState() {
    employeeController.Employeelist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log("empdata" +
    //     employeeController.Employeedata[0]['emp_img']
    //         .toString());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBarHeight),
        child: Appbartext(
          title: 'employeelist'.tr,
          elevation: 0.0,
          show_arrow_icon: 0,
        ),
      ),
      backgroundColor: PrimaryColor,
      body: RefreshIndicator(
        onRefresh: () => employeeController.Employeelist(),
        child: Header(
          title: '',
          showtextbox: true,
          show_arrow_icon: 1,
          ontextchange: (value) {
            employeeController.runFilter(value);
          },
          child: Obx(
            () => employeeController.isloading == true
                ? Center(
                    child: CircularProgressIndicator(
                    color: Green,
                  ))
                : employeeController.Employeedata.length > 0
                    ? Container(
                        height: 160,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: employeeController.Employeedata.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              CompanyListCard(
                            image: employeeController.Employeedata[index]
                                        ['emp_img'] ==
                                    null
                                ? null
                                : imageurl +
                                    employeeController.Employeedata[index]
                                        ['emp_img'],
                            nullimage: Personsvg,
                            title: employeeController.Employeedata[index]
                                    ['name']
                                .toString(),
                            address: "Engineer",
                            ismobile: true,
                            mobile: "Contact:- " +
                                employeeController.Employeedata[index]['phone']
                                    .toString(),
                            imageheight: 70,
                          ),
                        ),
                      ).paddingOnly(top: 20)
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
