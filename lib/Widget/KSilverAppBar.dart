import 'dart:io';

import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:steamhouse/Widget/Texboxwidget.dart';
import 'package:steamhouse/Widget/Textfield.dart';
import 'package:steamhouse/config/Color.dart';
import 'package:steamhouse/config/Import.dart';
import 'package:steamhouse/config/Svgstring.dart';
import 'package:steamhouse/config/TextStyle.dart';
import 'package:steamhouse/config/string.dart';


class KSilverAppBar extends StatefulWidget {
  final profile;
  KSilverAppBar({Key? key, this.profile = true}) : super(key: key);

  @override
  State<KSilverAppBar> createState() => _SilverAppBarState();
}

class _SilverAppBarState extends State<KSilverAppBar> {
  // AccountController accountController = Get.put(AccountController());
  @override
  void initState() {
    // accountController.getUserProfile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FlexibleSpaceBar(
      background: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(children: [
          if (Platform.isIOS) SizedBox(height: 20),
          if (widget.profile)
            SizedBox(
              height: AppBarSpace,
            ),
          if (!widget.profile)
            SizedBox(
              height: 10,
            ),
          if (widget.profile)
            Row(
              children: [
                Obx(()=>
                  CircleAvatar(
                    radius: 25.0,
                    // backgroundImage: NetworkImage(accountController.profileImage.toString()),
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Textfield().text('Welcome1'.tr,
                        TextStyles.withColor(TextStyles.mw40021, White)),
                    Textfield().text(GetStorage().read("name"),
                        TextStyles.withColor(TextStyles.mw40018, ButtonColor)),
                  ],
                ),
              ],
            ),
          if (!widget.profile)
            Container(
              child: Center(
                child: Textfield().text(
                    'Home'.tr, TextStyles.withColor(TextStyles.mw50016, White)),
              ),
            ),
          if (!widget.profile)
            SizedBox(
              height: 10,
            ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: TextBoxwidget(validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    prefixtxt: true,
                    radius: 30,
                    hinttext: 'SearchHint'.tr,
                    hintstyle: TextStyles.withColor(TextStyles.mn14, Gray),
                    Bgcolor: White,
                    style: TextStyles.withColor(TextStyles.mn14, DarkText),
                    iconorimage: true,
                    showoutlineborder: false,
                    showborder: false,
                    readtype: false,
                    ontap: () {},
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  // widget.profile
                  //     ? Get.toNamed(homeMapRoute)
                  //     : Get.toNamed(bottomRoute);
                },
                child: widget.profile
                    ? SvgPicture.string(
                        locationImg,
                      )
                    : SvgPicture.string(homeIcon),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
