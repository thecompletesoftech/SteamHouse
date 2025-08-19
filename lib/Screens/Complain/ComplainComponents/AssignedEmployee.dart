import 'package:steamhouse/config/Import.dart';

class AssignedEmployee extends StatefulWidget {
  final title;
  const AssignedEmployee({super.key, this.title});

  @override
  State<AssignedEmployee> createState() => _AssignedEmployeeState();
}

class _AssignedEmployeeState extends State<AssignedEmployee> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;
  List Pic = [];
  final box = GetStorage();

  callNumber(number) async {
    var res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Textfield()
            .text(
              widget.title,
              TextStyles.withColor(TextStyles.mb16, Black),
              TextAlign.left,
              TextOverflow.ellipsis,
            )
            .paddingSymmetric(horizontal: 5),
        Card(
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
                  data['employee'][0]['emp_img'] == null
                      ? SvgPicture.asset(
                          Personsvg,
                          height: 55,
                          color: ButtonColor,
                        )
                      : CachedNetworkImage(
                          imageUrl: data['employee'][0]['emp_img'],
                          height: 60,
                          width: 60,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                color: Lightgreen,
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                child: Textfield().text(
                                  data['employee'][0]['name'].toString(),
                                  TextStyles.withColor(TextStyles.mb18, Black),
                                  TextAlign.left,
                                  TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Textfield().text(
                              "Technician",
                              TextStyles.withColor(TextStyles.mn16, ReviewHint),
                              TextAlign.left),
                        ),
                        GestureDetector(
                          onTap: () {
                            callNumber(data['employee'][0]['phone'].toString());
                          },
                          child: Container(
                            child: Textfield().text(
                                "+91 " +
                                    data['employee'][0]['phone'].toString(),
                                TextStyles.withColor(
                                    TextStyles.mn16, ReviewHint),
                                TextAlign.left),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 5),
        ).paddingOnly(top: 10),
      ],
    );
  }
}
