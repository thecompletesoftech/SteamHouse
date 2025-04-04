import 'package:steamhouse/config/Color.dart';
import 'package:steamhouse/config/Import.dart';
import 'package:steamhouse/config/string.dart';


class TextBoxwidget extends StatefulWidget {
  final labeltxt;
  // final prefixicon;
  final suffixicon;
  final Bgcolor;
  final Function? ontap;
  final TextEditingController? controller;
  final bool readtype;
  final style;
  final bool iconorimage;
  final String? imagepath;
  final String? hinttext;
  final hintstyle;
  final bool suffixshowicon;
  // final bool? prefixshowicon;
  final keyboradtype;
  final height;
  final width;
  final maxline;
  final double radius;
  final leftpadding;
  final bool? obsecuretext;
  final Function? ontapsufixicon;
  final prefixtxt;
  final suffix_icon_color;
  final double size;
  final maxlength;
  final showborder;
  final descbox;

  final showoutlineborder;
  String? Function(String?)? validator;

  TextBoxwidget({
    
    this.labeltxt,
    // this.prefixicon,
    this.suffixicon,
    this.Bgcolor,
    this.ontap,
    this.controller,
    required this.readtype,
    this.style,
    this.iconorimage = false,
    this.imagepath,
    this.hinttext,
    this.hintstyle,
    this.suffixshowicon = false,
    this.keyboradtype = TextInputType.text,
    this.height,
    this.width,
    this.maxline = 1,
    this.radius = 5,
    this.leftpadding = 0.0,
    this.obsecuretext = false,
    this.ontapsufixicon,
    this.prefixtxt = false,
    this.suffix_icon_color = PrimaryColor,
    this.size = 20.0,
    this.showborder = true,
    this.showoutlineborder = false,
    required this.validator,
    this.maxlength,
    this.descbox = false,
    // this.prefixshowicon
  }) ;

  @override
  State<TextBoxwidget> createState() => _TextBoxwidgetState();
}

class _TextBoxwidgetState extends State<TextBoxwidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: widget.Bgcolor,
            borderRadius: BorderRadius.circular(widget.radius)),
        child: TextFormField(
            validator: widget.validator,
            maxLines: widget.maxline,
            keyboardType: widget.keyboradtype,
            obscureText: widget.obsecuretext!,
            onTap: () {
              widget.ontap!();
            },
            style: widget.style,
            readOnly: widget.readtype,
            controller: widget.controller,
            maxLength: widget.maxlength,
            decoration: InputDecoration(
                enabledBorder: widget.showoutlineborder
                    ? OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: const BorderSide(
                          color: ReviewHint,
                        ),
                        borderRadius: BorderRadius.circular(10))
                    : widget.showborder
                        ? UnderlineInputBorder(
                            borderSide: BorderSide(color: Gray),
                          )
                        : InputBorder.none,
                prefixIcon: widget.prefixtxt ? Image.asset(Search) : null,
                isDense: true,
                contentPadding: EdgeInsets.only(
                    left: widget.leftpadding, top: 15, bottom: 15),
                border: widget.showborder
                    ? UnderlineInputBorder(
                        borderSide: BorderSide(color: Gray),
                      )
                    : widget.showoutlineborder
                        ? OutlineInputBorder(
                            borderSide: const BorderSide(color: ReviewHint),
                            borderRadius: BorderRadius.circular(15))
                        : InputBorder.none,
                hintText: widget.hinttext,
                hintStyle: widget.hintstyle,
                suffixIconConstraints: BoxConstraints(
                  maxWidth: widget.suffixshowicon ? 30 : 0,
                  maxHeight: widget.suffixshowicon ? 20 : 0,
                ),
                suffixIcon: widget.suffixshowicon
                    ? widget.iconorimage
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              widget.imagepath!,
                              width: 20,
                              height: 20,
                              fit: BoxFit.fill,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              widget.ontapsufixicon!();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                widget.suffixicon,
                                color: widget.suffix_icon_color,
                                size: widget.size,
                              ),
                            ),
                          )
                    : Padding(padding: EdgeInsets.all(5)))));
  }
}
