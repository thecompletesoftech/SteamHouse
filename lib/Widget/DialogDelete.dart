import 'package:flutter_svg/svg.dart';
import 'package:steamhouse/Widget/Textfield.dart';
import 'package:steamhouse/config/Color.dart';
import 'package:steamhouse/config/Svgstring.dart';
import 'package:steamhouse/config/TextStyle.dart';

import '../Config/Import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DialogDelete extends StatefulWidget {
  DialogDelete({Key? key}) : super(key: key);

  @override
  State<DialogDelete> createState() => _DialogDeleteState();
}

class _DialogDeleteState extends State<DialogDelete> {
  TextEditingController Write_Comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: size.width * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 35,
              ),
              SvgPicture.string(delete),
              SizedBox(
                height: 20,
              ),
              Textfield().text("Delete".tr,
                  TextStyles.withColor(TextStyles.mw60021, LightGray)),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: size.width * 0.5,
                  child: Textfield().text(
                      "AreyousurewantDelete".tr,
                      TextStyles.withColor(TextStyles.mw40016, Black),
                      TextAlign.center)),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (() {
                      Get.back();
                    }),
                    child: Container(
                        width: size.width * 0.4,
                        height: 50,
                        alignment: Alignment.center,
                        child: Textfield().text(
                            "Cancel".tr, TextStyles.mw60018, TextAlign.center)),
                  ),
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      color: Black,
                    ),
                  ),
                  InkWell(
                    // onTap: (() {
                    //   Get.toNamed(
                    //     loginRoute,
                    //   );
                    // }),
                    child: Container(
                        width: size.width * 0.4,
                        height: 50,
                        alignment: Alignment.center,
                        child: Textfield().text(
                            "Confirmed".tr,
                            TextStyles.withColor(TextStyles.mw60018, DarkGreen),
                            TextAlign.center)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
