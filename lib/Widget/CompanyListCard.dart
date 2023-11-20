import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steamhouse/Widget/Textfield.dart';
import 'package:steamhouse/config/Color.dart';
import 'package:steamhouse/config/Import.dart';
import 'package:steamhouse/config/Svgstring.dart';
import 'package:steamhouse/config/TextStyle.dart';

class CompanyListCard extends StatefulWidget {
  final image;
  final double? imagewidth;
  final double? imageheight;
  final String? title;
  final String? address;
  final mobile;
  final String? steam;
  final Function? ontap;
  final nullimage;
  final iscompany;
  final ismobile;
  const CompanyListCard({
    super.key,
    this.image = null,
    this.imageheight = 50,
    this.title,
    this.address,
    this.mobile = null,
    this.imagewidth,
    this.steam = "",
    this.ontap,
    this.nullimage,
    this.iscompany = false,
    this.ismobile = false,
  });

  @override
  State<CompanyListCard> createState() => _CompanyListCardState();
}

class _CompanyListCardState extends State<CompanyListCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
        onTap: () {
          widget.ontap!();
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: White,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: widget.image == null
                        ? widget.iscompany
                            ? SvgPicture.string(
                                widget.nullimage,
                                height: 55,
                                width: 55,
                                color: ButtonColor,
                              ).paddingOnly(bottom: 20)
                            : SvgPicture.asset(
                                widget.nullimage,
                                height: 55,
                                width: 55,
                                color: ButtonColor,
                              ).paddingOnly(bottom: 20)
                        : CachedNetworkImage(
                            imageUrl: imageurl + widget.image,
                            width: widget.imagewidth,
                            height: widget.imageheight,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  color: Lightgreen,
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Textfield().text(
                              widget.title,
                              TextStyles.withColor(
                                TextStyles.mb20,
                                PrimaryColor,
                              ),
                            ),
                          ),
                          Textfield().text(
                              widget.address,
                              TextStyles.withColor(
                                TextStyles.mn16,
                                Darkgray,
                              ),
                              TextAlign.start,
                              TextOverflow.ellipsis,
                              1),
                          widget.ismobile
                              ? Textfield().text(
                                  widget.mobile,
                                  TextStyles.withColor(
                                    TextStyles.mn16,
                                    Darkgray,
                                  ),
                                  TextAlign.start,
                                  TextOverflow.ellipsis,
                                  1)
                              : Textfield().text(
                                  widget.steam,
                                  TextStyles.withColor(
                                    TextStyles.mn16,
                                    Lightgreen,
                                  ),
                                  TextAlign.start,
                                  TextOverflow.ellipsis,
                                  1),
                        ],
                      ),
                    ).paddingAll(8.0),
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
