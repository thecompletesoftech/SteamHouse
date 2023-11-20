import 'package:flutter/material.dart';
import 'package:steamhouse/config/Color.dart';


class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 55,
            height: 35,
            decoration: BoxDecoration(
              color: widget.value ?  Bordercolor : Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(color: Bordercolor, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 1.0, bottom: 1.0, right: 1.0, left: 1.0),
              child: Container(
                alignment:
                    widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 30,
                  height: 30.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: DarkGreen),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
