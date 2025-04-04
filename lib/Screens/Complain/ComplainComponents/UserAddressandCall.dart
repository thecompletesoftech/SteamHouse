
import 'package:maps_launcher/maps_launcher.dart';
import 'package:steamhouse/config/Import.dart';

class UserAddressandCall extends StatefulWidget {
  const UserAddressandCall({super.key});

  @override
  State<UserAddressandCall> createState() => _UserAddressandCallState();
}

class _UserAddressandCallState extends State<UserAddressandCall> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;
  final box = GetStorage();
  var latitude;
  var longitude;

   callNumber(number) async {
    var res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: InkWell(  
            onTap: (() {
              MapsLauncher.launchCoordinates(
                  double.parse(data['latitude']), double.parse(data['longitude']));
            }),
            child: Row(
              children: [
                Image.asset(
                  GooglemapImg,
                  height: 30,
                ).paddingOnly(right: 5),
                Expanded(
                  child: Textfield().text(
                    data['user'].length > 0
                        ? data['user'][0]['c_address'].toString()
                        : 'NAN',
                    TextStyles.withColor(
                      TextStyles.mn16,
                      Darkgray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: InkWell(
            onTap: (() {
              callNumber(data['phone'].toString());
            }),
            child: Row(
              children: [
                Image.asset(
                  PhoneImg,
                  height: 34,
                ).paddingOnly(right: 5),
                Textfield().text(
                  data['phone'] == null
                      ? 'NAN'
                      : "+91 ".tr + data['phone'].toString(),
                  TextStyles.withColor(
                    TextStyles.mb16,
                    Darkgray,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
