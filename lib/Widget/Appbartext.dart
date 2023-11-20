import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:steamhouse/config/Color.dart';
import 'package:steamhouse/config/TextStyle.dart';

import '../Config/Import.dart';
import 'dart:io' show Platform;
import 'Textfield.dart';

class Appbartext extends StatefulWidget {
  final String title;

  final show_arrow_icon;
  final show_icon;
  final icon;
  final elevation;
  final double? height;
  final colors;
  final Function? ontap;
  final bool? showbottom;
  final bool? showtext;

  final appbartxtstyle;
  final appbartxt;

  final arrowiconcolor;

  final imgoricon;
  final image;
  final imagecolor;
  final String? svgimg;

  final showtextbox;

  final search_value;
  final transparent;
  final Function? onchange;
  Appbartext({
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
    this.transparent = false,
    this.image,
    this.imagecolor = White,
  }) : super(key: key);
  @override
  State<Appbartext> createState() => _AppbartextState();
}

class _AppbartextState extends State<Appbartext> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(70.0), //
      child: AppBar(
        // toolbarHeight: 200,
        elevation: widget.elevation,
        automaticallyImplyLeading: false,
        backgroundColor: widget.transparent ? Color(0x44000000) : widget.colors,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: widget.colors,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: Container(
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
                      ? Container(
                          height: 30,

                          width: MediaQuery.of(context).size.width * .65,
                          // decoration: BoxDecoration(border:Border.all(color: Colors.black) ),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.bottom,
                            controller: search,
                            onSubmitted: (value) {
                              widget.onchange!(value);
                            },
                            onChanged: (value) {
                              widget.onchange!(value);
                            },
                            style: TextStyles.withColor(TextStyles.mn14, White),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Searchtxt'.tr,
                                hintStyle: TextStyles.withColor(
                                    TextStyles.mn14, White)),
                          ),

                          // Text(
                          //   widget.title,
                          //   style: widget.appbartxtstyle,
                          //   textAlign: TextAlign.center,
                          // ),
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
                                    ? SvgPicture.string(
                                        widget.image,
                                        color: widget.imagecolor,
                                      )
                                    : Icon(
                                        widget.icon,
                                        color: widget.imagecolor,
                                      )
                                : Textfield().text(
                                    widget.appbartxt, widget.appbartxtstyle),
                          ),
                        )
                      : Container(
                          width: 40,
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
