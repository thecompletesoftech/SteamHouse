import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Config/Import.dart';

class ReviewCardwidget extends StatefulWidget {
  final String destxt;

  final desstyle;

  final String customer_name;
  final String subtitle;

  final custome_name_style;
  final subtitle_style;

  final String img;
  final bgcolor;

  final bool shadow;

  final date;

  final double rating;

  final gesture_switch;

  ReviewCardwidget(
      {Key? key,
      required this.destxt,
      this.desstyle,
      this.subtitle = 'Text Book',
      this.subtitle_style = ReviewSubtitle,
      required this.customer_name,
      this.custome_name_style,
      required this.img,
      this.bgcolor,
      this.shadow = false,
      this.date,
      this.rating = 0.0,
      this.gesture_switch = false})
      : super(key: key);

  @override
  State<ReviewCardwidget> createState() => _ReviewCardwidgetState();
}

class _ReviewCardwidgetState extends State<ReviewCardwidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: widget.bgcolor,
            boxShadow: [
              BoxShadow(
                offset: Offset.zero,
                blurRadius: widget.shadow ? 5 : 0,
                spreadRadius: widget.shadow ? 0.5 : 0,
                color: Color.fromRGBO(1, 1, 1, 0.1),
              )
            ]),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 100,
                        width: 100,
                        child:
                        CachedNetworkImage(
                          imageUrl:  widget.img,
                          placeholder: (context,
                              url) =>
                              Center(
                                  child:
                                  CircularProgressIndicator()),
                          errorWidget: (context,
                              url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        )

                      ),
                    ), //Text
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: color.appbartext_color)),
                          child: Row(
                            children: [
                              Textfield().text(widget.customer_name,
                                  widget.custome_name_style),
                              Container(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: color.appbartext_color)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Textfield()
                                  .text(widget.subtitle, widget.subtitle_style),
                              Textfield().text(
                                  widget.date.toString(),
                                  TextStyles.withColor(
                                      TextStyles.mw60014, DarkGreen),
                                  TextAlign.start,
                                  TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: color.appbartext_color)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar(
                                initialRating: widget.rating,updateOnDrag:true,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: 15,
                                ratingWidget: RatingWidget(
                                  full: SvgPicture.string(activeStarIcon),
                                  half: SvgPicture.string(deactiveStarIcon),
                                  empty: SvgPicture.string(deactiveStarIcon),
                                ),
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Textfield().text(widget.destxt, widget.desstyle,
                      TextAlign.left, TextOverflow.ellipsis, 100)),
            ],
          ),
        ), //C,
      ),
    );
    ;
  }
}
