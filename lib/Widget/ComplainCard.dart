import 'package:steamhouse/config/Import.dart';

class ComplainCard extends StatefulWidget {
  final img;
  final String? reason;
  final String? title;
  final date;
  final time;
  final String? address;
  final String? mobile;
  final String? statusmsg;
  final String? status;
  final Function? ontap;
  final Color? color;
  final ticket;
  final companyname;
  const ComplainCard({
    super.key,
    this.img,
    this.reason,
    this.title,
    this.address,
    this.mobile,
    this.statusmsg,
    this.status,
    this.ontap,
    required this.date,
    this.time,
    this.color,
    this.ticket,
    this.companyname = "",
  });

  @override
  State<ComplainCard> createState() => _ComplainCardState();
}

class _ComplainCardState extends State<ComplainCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          widget.ontap!();
        },
        child: Container(
          // height: 235,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: White,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image.asset(
                      //   widget.img,
                      //   height: 80,
                      //   width: 80,
                      // ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Textfield().text(
                                          widget.companyname,
                                          TextStyles.withColor(
                                            TextStyles.mb16,
                                            Darkgray,
                                          ),
                                          TextAlign.justify,
                                          TextOverflow.visible,
                                          2,
                                          true),
                                    ),
                                  ),
                                  Textfield().text(
                                      widget.ticket!,
                                      TextStyles.withColor(
                                        TextStyles.mb16,
                                        Darkgray,
                                      )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Textfield().text(
                                  widget.title,
                                  TextStyles.withColor(
                                    TextStyles.mb16,
                                    Darkgray,
                                  ),
                                ),
                              ),
                              Container(
                                child: Textfield().text(
                                    widget.reason,
                                    TextStyles.withColor(
                                      TextStyles.mn16,
                                      Darkgray,
                                    ),
                                    TextAlign.start,
                                    TextOverflow.ellipsis,
                                    2),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Textfield().text(
                                  widget.mobile,
                                  TextStyles.withColor(
                                    TextStyles.mb16,
                                    Darkgray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.string(doticon, color: widget.color!)
                                .paddingOnly(right: 5),
                            Textfield().text(
                                widget.statusmsg,
                                TextStyles.withColor(
                                  TextStyles.mn14,
                                  widget.color!,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              child: Textfield().text(
                                widget.date!,
                                TextStyles.withColor(
                                  TextStyles.mn14,
                                  Green,
                                ),
                                TextAlign.end,
                              ),
                            ).paddingOnly(right: 5),
                            // Container(
                            //   child: Textfield().text(
                            //     widget.time!,
                            //     TextStyles.withColor(
                            //       TextStyles.mn14,
                            //       Green,
                            //     ),
                            //     TextAlign.end,
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
