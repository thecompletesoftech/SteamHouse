import 'dart:developer';
import 'package:steamhouse/Screens/Track/TextboxController.dart';
import 'package:steamhouse/config/Import.dart';

class MultiTextBox extends StatefulWidget {
  const MultiTextBox({super.key});

  @override
  State<MultiTextBox> createState() => _MultiTextBoxState();
}

class _MultiTextBoxState extends State<MultiTextBox> {
  TextboxController textboxController = Get.put(TextboxController());
  final _formKey = GlobalKey<FormState>();
  var label = [
    {"labels": "first", 'icon': Icons.home},
    {"labels": "second", 'icon': Icons.person},
    {"labels": "third", 'icon': Icons.home},
    {"labels": "fourth", 'icon': Icons.person},
    {"labels": "fifth", 'icon': Icons.home},
  ];

  @override
  void initState() {
    textboxController.Multi(label);
    super.initState();
  }

  show() {
    for (var i = 0; i < textboxController.textlist.length; i++) {
      log("textvalue=" + textboxController.textlist[i].text);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ListView.builder(
                  itemCount: label.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      TextBoxwidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Some Text";
                      }
                      return null;
                    },
                    controller: textboxController.textlist[index],
                    hinttext: label[index]['labels'].toString(),
                    hintstyle: TextStyles.withColor(TextStyles.mn14, Gray),
                    Bgcolor: LightPink,
                    style: TextStyles.withColor(TextStyles.mn14, DarkText),
                    iconorimage: false,
                    // obsecuretext: showtext == true ? false : true,
                    suffixshowicon: true,
                    suffixicon: label[index]['icon'],
                    ontapsufixicon: () {},
                    readtype: false,
                    ontap: () {},
                  ),
                ),
                
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        show();
                      }
                    },
                    child: Text('hiii')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
