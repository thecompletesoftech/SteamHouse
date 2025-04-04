import 'dart:convert';
import 'dart:developer';

import 'package:maps_launcher/maps_launcher.dart';
import 'package:steamhouse/Screens/Complain/ComplainController.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Config/Import.dart';
import '../../../Widget/ImagePopUp.dart';
import '../../../config/Color.dart';
import '../../../config/Urls.dart';
import '../../../config/string.dart';

class RequestImage extends StatefulWidget {
  const RequestImage({super.key});

  @override
  State<RequestImage> createState() => _RequestImageState();
}

class _RequestImageState extends State<RequestImage> {
  ComplainController complainController = Get.put(ComplainController());
  var data = Get.arguments;
  List Pic = [];

  void initState() {
    log("message" + data['pictures'].toString());
    setState(() {
      if (data['pictures'] != null) {
        Pic = (json.decode(data['pictures']));
      } else {
        Pic = [];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: 90,
        child: Row(
          children: [
            Pic.length < 1
                ? Image.asset(
                    NotImage,
                    height: 120,
                  )
                : Expanded(
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Pic.length,
                        shrinkWrap: true,
                        // physics:
                        //     NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            Stack(children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ImagePopup(
                                      image: imageurl + Pic[index],
                                    );
                                  });
                            },
                            child: Container(
                              width: 100,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightGray,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: imageurl + Pic[index],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        color: Lightgreen,
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ).paddingAll(8.0),
                          ),
                        ]),
                      ),
                    ),
                  ),
          ],
        ));
  }
}
