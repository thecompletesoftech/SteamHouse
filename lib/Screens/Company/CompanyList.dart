import 'package:steamhouse/config/Import.dart';

class CompanyList extends StatefulWidget {
  const CompanyList({super.key});

  @override
  State<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  CompanyController companyController = Get.put(CompanyController());
  final box = GetStorage();

  @override
  void initState() {
    companyController.Companylist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBarHeight),
        child: Appbartext(
          title: 'CompanyList'.tr,
          elevation: 0.0,
          show_arrow_icon: 0,
        ),
      ),
      backgroundColor: PrimaryColor,
      body: RefreshIndicator(
        onRefresh: () => companyController.Companylist(),
        child: Header(
          title: '',
          showtextbox: true,
          show_arrow_icon: 1,
          ontextchange: (value) {
            companyController.runFilter(value);
          },
          child: Obx(
            () => companyController.isloading == true
                ? Center(
                    child: CircularProgressIndicator(
                    color: Green,
                  ))
                : companyController.companydata.length > 0
                    ? Container(
                        height: 160,
                        child: ListView.builder(
                          itemCount: companyController.companydata.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              CompanyListCard(
                                  iscompany: true,
                                  image: companyController.companydata[index]
                                              ['image'] ==
                                          null
                                      ? null
                                      : companyController.companydata[index]
                                          ['image'],
                                  nullimage: buildingicon,
                                  title: companyController.companydata[index]
                                          ['name']
                                      .toString(),
                                  address: companyController.companydata[index]
                                          ['c_address']
                                      .toString(),
                                  mobile: null,
                                  steam: "LiveSteamTxt".tr,
                                  ontap: () {
                                    box.write(
                                        "meterid",
                                        companyController.companydata[index]
                                            ['meter_id']);
                                    Get.toNamed(homeRoute,
                                        parameters: {'show': 'true'});
                                  },
                                  imageheight: 70),
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
