import 'package:steamhouse/Screens/Profile/Changepassword.dart';
import 'package:steamhouse/config/Import.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileController profileController = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  List<XFile>? ComplainImage;
  final box = GetStorage();
  var showchangepass = false;
  @override
  void initState() {
    profileController.name.text = box.read('username');
    profileController.email.text = box.read('email');
    profileController.phone.text = box.read('phone');
    profileController.address.text = box.read('address');
    profileController.oldpass.text = '';
    profileController.newpass.text = '';
    profileController.confirmpass.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          color: PrimaryColor,
          child: SafeArea(
              child: CustomScrollView(shrinkWrap: true, slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              backgroundColor: PrimaryColor,
              expandedHeight: 4,
              title: SilverAppBar(
                title: 'editprofile'.tr,
                elevation: 0.5,
                show_arrow_icon: 0,
              ),
            ),
            SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: White,
                    border: Border.all(color: White),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(RoundEdgePadding),
                        topRight: Radius.circular(RoundEdgePadding)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Textfield()
                              .text(
                                  box.read('name').toString(),
                                  TextStyles.withColor(
                                      TextStyles.mb20, DarkGreen))
                              .paddingSymmetric(horizontal: 10),
                          SizedBox(
                            height: 20,
                          ),
                          Textfield().text(
                              'username'.tr,
                              TextStyles.withColor(
                                  TextStyles.mw50016, DarkText)),
                          TextBoxwidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: profileController.name,
                            hinttext: 'username'.tr,
                            hintstyle:
                                TextStyles.withColor(TextStyles.mn14, Gray),
                            Bgcolor: White,
                            style:
                                TextStyles.withColor(TextStyles.mn14, DarkText),
                            iconorimage: true,
                            readtype: true,
                            ontap: () {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Textfield().text(
                              'mobileno'.tr,
                              TextStyles.withColor(
                                  TextStyles.mw50016, DarkText)),
                          IntlPhoneField(
                            // controller: registerationController.phoneNo,
                            dropdownIconPosition: IconPosition.trailing,
                            showCountryFlag: false,
                            dropdownIcon: Icon(
                              FontAwesomeIcons.chevronDown,
                              size: 15,
                            ),
                            style: TextStyles.mw50016,
                            dropdownTextStyle:
                                TextStyles.withColor(TextStyles.mw50016, Gray),
                            decoration: InputDecoration(
                                labelText: 'Mobile no',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Gray,
                                  ),
                                )),
                            initialCountryCode: 'IN',
                            controller: profileController.phone,
                            onChanged: (phone) {
                              // registerationController.ContryCode.value =
                              //     phone.countryCode;
                              print(phone.countryCode);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Textfield().text(
                              'email'.tr,
                              TextStyles.withColor(
                                  TextStyles.mw50016, DarkText)),
                          TextBoxwidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: profileController.email,
                            hinttext: 'email'.tr,
                            hintstyle:
                                TextStyles.withColor(TextStyles.mn14, Gray),
                            Bgcolor: White,
                            style:
                                TextStyles.withColor(TextStyles.mn14, DarkText),
                            iconorimage: true,
                            readtype: false,
                            ontap: () {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          showchangepass
                              ? Changepassword()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Textfield().text(
                                        'changepassword'.tr,
                                        TextStyles.withColor(
                                            TextStyles.mw50016, DarkText)),
                                    TextBoxwidget(
                                      validator: (value) {
                                        return null;
                                      },
                                      controller: profileController.oldpass,
                                      hinttext: 'changepassword'.tr,
                                      hintstyle: TextStyles.withColor(
                                          TextStyles.mn14, Gray),
                                      Bgcolor: White,
                                      style: TextStyles.withColor(
                                          TextStyles.mn14, DarkText),
                                      iconorimage: true,
                                      readtype: true,
                                      ontap: () {
                                        setState(() {
                                          showchangepass = true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          if (box.read('usertype') == 0)
                            Textfield().text(
                                'address'.tr,
                                TextStyles.withColor(
                                    TextStyles.mw50016, DarkText)),
                          if (box.read('usertype') == 0)
                            SizedBox(
                              height: 10,
                            ),
                          if (box.read('usertype') == 0)
                            TextBoxwidget(
                              validator: (value) {
                                return null;
                              },
                              hinttext: 'address'.tr,
                              showborder: false,
                              controller: profileController.address,
                              hintstyle: TextStyles.withColor(
                                  TextStyles.mw40016, ReviewHint),
                              Bgcolor: White,
                              leftpadding: 10.0,
                              radius: 20,
                              style: TextStyles.withColor(
                                  TextStyles.mn14, DarkText),
                              iconorimage: true,
                              readtype: false,
                              maxline: 6,
                              showoutlineborder: true,
                              maxlength: 200,
                              ontap: () {},
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => Center(
                                child: ElevatedButtons(
                                    width: 0.82,
                                    name: 'save'.tr,
                                    loading: profileController.isloading.value,
                                    onTap: () async {
                                      if (profileController.isloading.value ==
                                          false) if (_formKey.currentState!.validate()) {
                                        profileController.EditProfile(context);
                                      }
                                    })).paddingSymmetric(vertical: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ]))),
    );
  }
}
