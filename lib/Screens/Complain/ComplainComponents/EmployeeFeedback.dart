import 'package:steamhouse/config/Import.dart';

class EmployeeFeedback extends StatefulWidget {
  const EmployeeFeedback({super.key});

  @override
  State<EmployeeFeedback> createState() => _EmployeeFeedbackState();
}

class _EmployeeFeedbackState extends State<EmployeeFeedback> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;
  List EmpPic = [];
  final box = GetStorage();

  void initState() {
    setState(() {
      if (data['employeefeedback'].length > 0) {
        data['employeefeedback'][0]['pictures'] != null
            ? EmpPic = (json.decode(data['employeefeedback'][0]['pictures']))
            : EmpPic = [];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: White,
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: Textfield().text(
                    "WorkCompletedbyTechnician".tr,
                    TextStyles.withColor(
                      TextStyles.mb14,
                      Black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Textfield().text(
                    complainController.Datetime(
                        data['employeefeedback'][0]['created_at'].toString()),
                    TextStyles.withColor(
                      TextStyles.mn14,
                      Green,
                    ),
                    TextAlign.end,
                  ),
                ),
              )
            ],
          ).paddingSymmetric(vertical: 5),
          Container(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EmpPic.length < 1
                    ? Image.asset(
                        NotImage,
                        height: 80,
                      )
                    : Expanded(
                        child: Container(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: EmpPic.length,
                            shrinkWrap: true,
                            // physics:
                            //     NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                Stack(children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ImagePopup(
                                          image: imageurl + EmpPic[index],
                                        );
                                      });
                                },
                                child: Container(
                                  width: 100,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: LightGray,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: imageurl + EmpPic[index],
                                      height: 90,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                  color: Lightgreen,
                                                  value: downloadProgress
                                                      .progress)),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ).paddingAll(5.0),
                              ),
                            ]),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Textfield().text(
              "Remark :- " + data['employeefeedback'][0]['remark'].toString(),
              TextStyles.withColor(
                TextStyles.mn16,
                Darkgray,
              ),
            ),
          ).paddingSymmetric(horizontal: 5, vertical: 5),
        ],
      ).paddingSymmetric(horizontal: 5),
    ).paddingSymmetric(vertical: 5);
  }
}
