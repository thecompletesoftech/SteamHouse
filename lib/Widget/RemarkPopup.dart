import 'package:flutter_svg/svg.dart';
import 'package:steamhouse/Screens/Complain/ComplainController.dart';
import 'package:steamhouse/Widget/Button.dart';
import 'package:steamhouse/Widget/Textfield.dart';
import 'package:steamhouse/config/Color.dart';
import 'package:steamhouse/config/Svgstring.dart';
import 'package:steamhouse/config/TextStyle.dart';
import '../Config/Import.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RemarkPopup extends StatefulWidget {
  final Function? onTap;
  RemarkPopup({
    Key? key,
    this.onTap,
    //  this.AdventureId
  }) : super(key: key);

  @override
  State<RemarkPopup> createState() => _RemarkPopupState();
}

class _RemarkPopupState extends State<RemarkPopup> {
  ComplainController complainController = Get.put(ComplainController());

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
          width: size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              right: 20,
              left: 20,
              bottom: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Textfield().text('remark'.tr,
                        TextStyles.withColor(TextStyles.mb20, DarkText)),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.string(close))
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: LightGray),
                        borderRadius: BorderRadius.circular(15)),
                    height: size.height * 0.2,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          controller: complainController.complaindesc,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'WriteComment'.tr,
                            hintStyle: TextStyles.withColor(
                                TextStyles.mw50016, ReviewHint),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButtons(
                  name: 'submit'.tr,
                  onTap: () {
                    widget.onTap!();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
