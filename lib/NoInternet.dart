import 'package:steamhouse/SplashScreen.dart';
import 'package:steamhouse/config/Import.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({
    super.key,
  });

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: White,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.string(
                sadfaceicon,
                color: Lightgreen,
              ),
            ),
            Center(
              child: Textfield().text(
                "nointernetmsg".tr,
                TextStyles.withColor(
                  TextStyles.mb18,
                  PrimaryColor,
                ),
                TextAlign.center,
              ),
            ),
            Container(
              width: size.width * 0.4,
              child: ElevatedButtons(
                onTap: () {
                  nextScreen(context, SplashScreen());
                },
                name: 'Try Again',
              ).paddingSymmetric(vertical: 20),
            )
          ],
        ),
      ),
    );
  }
}
