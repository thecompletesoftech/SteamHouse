import 'package:flutter/gestures.dart';
import 'package:steamhouse/Screens/Login/Login.dart';
import 'package:steamhouse/config/Import.dart';


class Signup extends StatefulWidget {
  Signup({
    Key? key,
  }) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final box = GetStorage();
  LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  var showtext = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBarHeight),
        child: Appbartext(
          title: '',
          elevation: 0.0,
          show_arrow_icon: 1,
        ),
      ),
      backgroundColor: PrimaryColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      largelogo,
                      height: 75,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 30,
                ),
                width: size.width,
                height: size.height * 0.75,
                decoration: BoxDecoration(
                  color: White,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Textfield().text('Welcome'.tr,
                        TextStyles.withColor(TextStyles.mb26, PrimaryColor)),
                    SizedBox(
                      height: 20,
                    ),
                    Textfield().text('name'.tr,
                        TextStyles.withColor(TextStyles.mw50016, DarkText)),
                    TextBoxwidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: loginController.name,
                      hinttext: 'namelabel'.tr,
                      hintstyle: TextStyles.withColor(TextStyles.mn14, Gray),
                      Bgcolor: White,
                      style: TextStyles.withColor(TextStyles.mn14, DarkText),
                      readtype: false,
                      ontap: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Textfield().text('usernamee'.tr,
                        TextStyles.withColor(TextStyles.mw50016, DarkText)),
                    TextBoxwidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: loginController.username,
                      hinttext: 'usernamelabel'.tr,
                      hintstyle: TextStyles.withColor(TextStyles.mn14, Gray),
                      Bgcolor: White,
                      style: TextStyles.withColor(TextStyles.mn14, DarkText),
                      readtype: false,
                      ontap: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Textfield().text('Password'.tr,
                        TextStyles.withColor(TextStyles.mw50016, DarkText)),
                    TextBoxwidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Validationtxt'
                              .trParams({'validation': 'Password'.tr});
                        }
                        return null;
                      },
                      controller: loginController.signuppassword,
                      hinttext: 'enterpassword'.tr,
                      hintstyle: TextStyles.withColor(TextStyles.mn14, Gray),
                      Bgcolor: White,
                      style: TextStyles.withColor(TextStyles.mn14, DarkText),
                      iconorimage: false,
                      obsecuretext: showtext == true ? false : true,
                      suffixshowicon: true,
                      suffixicon: showtext == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      ontapsufixicon: () {
                        setState(() {
                          showtext = !showtext;
                        });
                      },
                      readtype: false,
                      ontap: () {},
                    ),
                    Obx(
                      () => Center(
                        child: ElevatedButtons(
                          width: 0.82,
                          name: 'signup'.tr,
                          loading: loginController.isloadingsignup.value,
                          onTap: () async {
                            loginController.isloadingsignup.value = false;
                            // box.write("usertype", 0);
                            // nextScreen(context, TrackComplain());
                            if (loginController.isloadingsignup.value ==
                                false) if (_formKey.currentState!.validate()) {
                              loginController.Signup(context);
                            }
                          },
                        ),
                      ).paddingOnly(top: 30),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "already_have_acc_txt".tr,
                              style: TextStyles.withColor(
                                TextStyles.mn16,
                                LightText,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, Login());
                                },
                              text: 'login'.tr,
                              style: TextStyles.withColor(
                                  TextStyles.mb16, PrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ).paddingOnly(top: 10),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
