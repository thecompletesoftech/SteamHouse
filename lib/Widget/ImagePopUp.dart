import 'package:steamhouse/config/Import.dart';

class ImagePopup extends StatefulWidget {
  final image;
  ImagePopup({Key? key, this.image}) : super(key: key);

  @override
  State<ImagePopup> createState() => _ImagePopupState();
}

class _ImagePopupState extends State<ImagePopup> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Dialog(
        backgroundColor: Black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        insetPadding: EdgeInsets.zero,
        child: InteractiveViewer(
          child: CachedNetworkImage(imageUrl: widget.image),
          maxScale: 2.5,
          // onZoomStart: () {
          //   print('Start zooming');
          // },
          // onZoomEnd: () {
          //   print('Stop zooming');
          // },
        ),
      ),
    );
  }
}
