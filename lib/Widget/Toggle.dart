import 'package:flutter/material.dart';
import 'package:steamhouse/Widget/Textfield.dart';
import 'package:steamhouse/config/Color.dart';

class Togglebtn extends StatefulWidget {
  final style;

  final String txt;
  final bool active;
  final color;

  final double? width;
  Togglebtn(
      {Key? key,
      this.style,
      required this.txt,
      this.color,
      required this.active,
      this.width})
      : super(key: key);

  @override
  State<Togglebtn> createState() => _TogglebtnState();
}

class _TogglebtnState extends State<Togglebtn> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        height: 45,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: widget.active ? PrimaryColor : Colors.transparent),
        child: Textfield().text(widget.txt, widget.style));
  }
}
