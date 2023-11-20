import 'package:steamhouse/config/Import.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Textfield().text(
            'oldpass'.tr, TextStyles.withColor(TextStyles.mw50016, DarkText)),
        TextBoxwidget(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: profileController.oldpass,
          hinttext: 'oldpasshint'.tr,
          hintstyle: TextStyles.withColor(TextStyles.mn14, Gray),
          Bgcolor: White,
          style: TextStyles.withColor(TextStyles.mn14, DarkText),
          iconorimage: true,
          readtype: false,
          ontap: () {},
        ),
        SizedBox(
          height: 20,
        ),
        Textfield().text(
            'newpass'.tr, TextStyles.withColor(TextStyles.mw50016, DarkText)),
        TextBoxwidget(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: profileController.newpass,
          hinttext: 'newpasshint'.tr,
          hintstyle: TextStyles.withColor(TextStyles.mn14, Gray),
          Bgcolor: White,
          style: TextStyles.withColor(TextStyles.mn14, DarkText),
          iconorimage: true,
          readtype: false,
          ontap: () {},
        ),
        SizedBox(
          height: 20,
        ),
        Textfield().text('confirmpass'.tr,
            TextStyles.withColor(TextStyles.mw50016, DarkText)),
        TextBoxwidget(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: profileController.confirmpass,
          hinttext: 'confirmpass'.tr,
          hintstyle: TextStyles.withColor(TextStyles.mn14, Gray),
          Bgcolor: White,
          style: TextStyles.withColor(TextStyles.mn14, DarkText),
          iconorimage: true,
          readtype: false,
          ontap: () {},
        ),
      ],
    );
  }
}
