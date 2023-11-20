import '../Config/Import.dart';

// import '../config/string.dart';

class Textfield {
  Widget text(text, style, [align, overflow, maxline = 6, softwrap = true]) {
    return Container(
        child: Text(
      text,
      style: style,
      textAlign: align,
      softWrap: softwrap,
      maxLines: maxline,
      overflow: overflow,
    ));
  }

  Widget Button(text) {
    return Container(
        child: Text(
      text,
    ));
  }

  Widget image(
    type,
    image_path, [
    double? height,
    double? width,
  ]) {
    return type == 'asset'
        ? Container(
            child: Image(
            image: AssetImage(
              image_path,
            ),
            height: height,
            width: width,
          ))
        : Container(
            child: Image(
              image: NetworkImage(image_path),
            ),
          );
  }
}
