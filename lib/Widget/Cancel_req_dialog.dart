import 'package:steamhouse/Config/Import.dart';

class Cancel_req_dialog extends StatefulWidget {
  final child;
  final dialogwidth;
  final String? leftbtnname;
  final String? rightbtnname;
  final String? popupheadtxt;

  final Function? leftbtnnameontap;
  final Function? rightbtnnameontap;

  final popupheadtxtstyle;

  final bool showhead;

  final bool showonbutton;

  final onebtnname;

  final onebtnstyle;
  final Function? onebtnonTap;

  Cancel_req_dialog(
      {Key? key,
      this.child,
      this.leftbtnname,
      this.rightbtnname,
      this.popupheadtxt,
      this.leftbtnnameontap,
      this.rightbtnnameontap,
      this.popupheadtxtstyle = TextStyles.mb18,
      this.showhead = true,
      this.showonbutton = false,
      this.onebtnname,
      this.onebtnstyle,
      this.onebtnonTap,
      this.dialogwidth = 0.8})
      : super(key: key);

  @override
  State<Cancel_req_dialog> createState() => _Cancel_req_dialogState();
}

class _Cancel_req_dialogState extends State<Cancel_req_dialog> {
  TextEditingController Write_reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: size.width * widget.dialogwidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15),
              widget.showhead
                  ? Center(
                      child: Textfield()
                          .text(widget.popupheadtxt, widget.popupheadtxtstyle),
                    )
                  : Container(),
              SizedBox(height: 5),
              widget.showhead
                  ? Divider(
                      thickness: 1.5,
                    )
                  : Container(),
              Container(child: widget.child),
              Divider(
                thickness: 1.5,
              ),
              widget.showonbutton
                  ? InkWell(
                      onTap: () {
                        widget.onebtnonTap!();
                      },
                      child: Container(
                          height: 40,
                          width: size.width,
                          alignment: Alignment.center,
                          child: Textfield()
                              .text(widget.onebtnname, widget.onebtnstyle)),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: size.width * 0.3,

                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.red)),
                                child: Text(widget.leftbtnname!,
                                    style: TextStyles.withColor(
                                        TextStyles.mb14,Black)),
                              ),
                              onTap: () {
                                widget.leftbtnnameontap!();
                              }),
                          Container(
                            height: 30,
                            child: VerticalDivider(
                              thickness: 1.2,
                            ),
                          ),
                          InkWell(
                              child: Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.red)),
                                alignment: Alignment.center,
                                height: 40,
                                width: size.width * 0.3,
                                child: Text(
                                  widget.rightbtnname!,
                                  style: TextStyles.withColor(
                                      TextStyles.mb14, Black),
                                ),
                              ),
                              onTap: () {
                                widget.rightbtnnameontap!();
                              })
                        ]),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
