import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:steamhouse/Screens/Login/Signup.dart';
import 'package:steamhouse/config/Import.dart';


class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Textfield()
                  .text("Are you sure want to exit", TextStyles.mn18),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    exit(1);
                  },
                  child: Textfield().text("Yes", TextStyles.mb14),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Textfield().text("No", TextStyles.mb14),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBarHeight),
          child: Appbartext(
            title: '',
            elevation: 0.0,
            show_arrow_icon: 1,
          ),
        ),
        backgroundColor: PrimaryColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                      Textfield().text('Loginlabel'.tr,
                          TextStyles.withColor(TextStyles.mw50016, DarkText)),
                      TextBoxwidget(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: loginController.phone,
                        hinttext: 'enterloginlabel'.tr,
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
                        controller: loginController.password,
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
                      Spacer(),
                      Obx(
                        () => Center(
                          child: ElevatedButtons(
                            width: 0.82,
                            name: 'login'.tr,
                            loading: loginController.isloadinglogin.value,
                            onTap: () async {
                              // box.write("usertype", 0);
                              // nextScreen(context, TrackComplain());
                              if (loginController.isloadinglogin.value ==
                                  false) if (_formKey.currentState!.validate()) {
                                loginController.login(context);
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
                                text: "dont_have_acc_txt".tr,
                                style: TextStyles.withColor(
                                  TextStyles.mn16,
                                  LightText,
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                     nextScreen(context, Signup());
                                  },
                                text: 'signup'.tr,
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
      ),
    );
  }
}
