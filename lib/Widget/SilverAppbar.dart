import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:steamhouse/config/Color.dart';
import 'package:steamhouse/config/Import.dart';
import 'package:steamhouse/config/Svgstring.dart';
import 'package:steamhouse/config/TextStyle.dart';
import 'package:steamhouse/config/string.dart';


import 'Textfield.dart';

class SilverAppBar extends StatefulWidget {
  final String title;

  final show_arrow_icon;
  final show_icon;
  final icon;
  final elevation;
  final double? height;
  final colors;
  final Function? ontap;
  final Function? onicontap;
  final bool? showbottom;
  final bool? showtext;

  final appbartxtstyle;
  final appbartxt;
  final showimage;
  final arrowiconcolor;
  final image;
  final imgoricon;

  final String? svgimg;

  final showtextbox;
  final ShowCalender;

  final search_value;
  final Function? onchange;
  final Function? ontextchange;
  SilverAppBar({
    Key? key,
    required this.title,
    this.icon = 0,
    this.show_icon = 0,
    this.elevation = 1.0,
    this.height = 40.0,
    this.colors = PrimaryColor,
    this.ontap,
    this.show_arrow_icon = 0,
    this.showbottom = false,
    this.showtext = false,
    this.appbartxtstyle = TextStyles.mw50016,
    this.appbartxt,
    this.arrowiconcolor = White,
    this.imgoricon = false,
    this.svgimg,
    this.showtextbox = false,
    this.search_value,
    this.onchange,
    this.onicontap,
    this.ShowCalender = false,
    this.showimage = false,
    this.image,
    this.ontextchange,
  }) : super(key: key);
  @override
  State<SilverAppBar> createState() => _SilverAppBarState();
}

class _SilverAppBarState extends State<SilverAppBar> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.show_arrow_icon == 0
                  ? GestureDetector(
                      onTap: () {
                        Get.back();
                        // backScreen(context);
                      },
                      child: Container(
                        // decoration: BoxDecoration(border: Border.all(color: colo)),
                        width: 40,
                        alignment: Alignment.centerLeft,
                        // decoration: BoxDecoration(border:Border.all(color: Colors.black) ),
                        child: Icon(
                          FontAwesomeIcons.chevronLeft,
                          color: widget.arrowiconcolor,
                          size: 20,
                        ),
                      ),
                    )
                  : Container(
                      width: 40,
                    ),
              widget.showtextbox
                  ? Row(
                      children: [
                        Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.60,
                            // color: White,
                            decoration: BoxDecoration(
                                // border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15),
                                color: White),
                            child: TextField(
                              textAlignVertical: TextAlignVertical.bottom,
                              controller: search,
                              onSubmitted: (value) {
                                widget.onchange!(value);
                              },
                              onChanged: (value) {
                                widget.ontextchange!(value);
                              },  
                              style:
                                  TextStyles.withColor(TextStyles.mn14, Black),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Searchtxt'.tr,
                                  hintStyle: TextStyles.withColor(
                                      TextStyles.mn14, Gray),
                                  prefixIcon: Image.asset(Search)),
                            )
                            // Text(
                            //   widget.title,
                            //   style: widget.appbartxtstyle,
                            //   textAlign: TextAlign.center,
                            // ),
                            ),
                        Container(width: 10),
                        widget.ShowCalender
                            ? GestureDetector(
                                onTap: () {
                                  widget.onicontap!();
                                },
                                child: SvgPicture.string(
                                  selectedCalenderIcon,
                                  color: DarkGreen,
                                ),
                              )
                            : Container()
                      ],
                    )
                  : widget.showimage
                      ? Image.asset(
                          widget.image!,
                          height: 60,
                        )
                      : Container(
                          //  height: 30,
                          // alignment: Alignment.bottomCenter,
                          // decoration:
                          //     BoxDecoration(border: Border.all(color: Colors.black)),
                          width: MediaQuery.of(context).size.width * .65,
                          // decoration: BoxDecoration(border:Border.all(color: Colors.black) ),
                          child: Text(
                            widget.title,
                            style: widget.appbartxtstyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
              widget.show_icon == 1
                  ? GestureDetector(
                      onTap: () {
                        widget.ontap!();
                      },
                      child: Container(
                        height: 30,
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.black)),
                        alignment: Alignment.centerRight,
                        width: 40,
                        child: widget.showtext! == false
                            ? widget.imgoricon
                                ? Icon(
                                    widget.icon,
                                    color: White,
                                  )
                                : Icon(
                                    widget.icon,
                                    color: White,
                                  )
                            : Textfield()
                                .text(widget.appbartxt, widget.appbartxtstyle),
                      ),
                    )
                  : Container(
                      width: 40,
                    )
            ],
          ),
        ],
      ),
    );
  }
}
