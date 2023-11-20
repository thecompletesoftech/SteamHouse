import 'dart:io';
import '../../../Config/Import.dart';

class EmployeeAddReview extends StatefulWidget {
  const EmployeeAddReview({super.key});

  @override
  State<EmployeeAddReview> createState() => _EmployeeAddReviewState();
}

class _EmployeeAddReviewState extends State<EmployeeAddReview> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;
  // List<XFile>? complainController.SendImage;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Textfield()
            .text('clickpicturetxt'.tr,
                TextStyles.withColor(TextStyles.mb16, Black))
            .paddingSymmetric(horizontal: 10),
        Container(
            height: 100,
            child: Row(
              children: [
                if (complainController.SendImage.length > 0)
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: complainController.SendImage.length,
                        shrinkWrap: true,
                        // physics:
                        //     NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: PrimaryColor)),
                            height: 80,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(complainController.SendImage[index].path),
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
                                  complainController.SendImage.length == 1
                                      ? complainController.SendImage = []
                                      : complainController.SendImage.removeAt(
                                          index);
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
                        border: Border.all(color: PrimaryColor)),
                    child: Center(
                      child: SvgPicture.string(
                        cameraicon,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ).paddingOnly(left: 10, right: 10, bottom: 10),
                ),
              ],
            )),
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
          hintstyle: TextStyles.withColor(TextStyles.mw40016, ReviewHint),
          Bgcolor: White,
          leftpadding: 10.0,
          radius: 20,
          style: TextStyles.withColor(TextStyles.mn14, DarkText),
          iconorimage: true,
          readtype: false,
          maxline: 6,
          showoutlineborder: true,

          // descbox: true,
          maxlength: 100,
          ontap: () {},
        ),
        SizedBox(
          height: 10,
        ),
        Obx(
          () => Center(
              child: ElevatedButtons(
                  width: 0.82,
                  name: 'workcomplete'.tr,
                  loading: complainController.isloading.value,
                  onTap: () async {
                    complainController.Employeefeedback(data['id']);
                  })).paddingSymmetric(vertical: 5),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ).paddingOnly(bottom: 10);
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
}
