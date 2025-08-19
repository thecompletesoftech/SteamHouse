import 'package:steamhouse/config/Import.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewPopUp extends StatefulWidget {
  final Function? onTap;
  ReviewPopUp({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  State<ReviewPopUp> createState() => _ReviewPopUpState();
}

class _ReviewPopUpState extends State<ReviewPopUp> {
  ComplainController complainController = Get.put(ComplainController());
  TextEditingController Write_Comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              right: 20,
              left: 20,
              bottom: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Textfield().text('Review'.tr,
                        TextStyles.withColor(TextStyles.mb20, DarkText)),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.string(close))
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                RatingBar(
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 35,
                  ratingWidget: RatingWidget(
                    full: SvgPicture.string(activeStarIcon),
                    half: SvgPicture.string(deactiveStarIcon),
                    empty: SvgPicture.string(deactiveStarIcon),
                  ),
                  itemPadding: EdgeInsets.symmetric(horizontal: 7),
                  onRatingUpdate: (ratings) {
                    print(ratings);
                    setState(() {
                      complainController.rating.value = ratings;
                    });
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Bordercolor, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    height: size.height * 0.2,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          controller: complainController.complaindesc,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'sharefeedbackmsg'.tr,
                            hintStyle: TextStyles.withColor(
                                TextStyles.mw50016, ReviewHint),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButtons(
                  name: 'submit'.tr,
                  onTap: () {
                    widget.onTap!();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
