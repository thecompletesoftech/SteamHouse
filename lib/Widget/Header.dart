
import 'package:steamhouse/config/Import.dart';

class Header extends StatefulWidget {
  final String title;
  final child;
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
  final padding;
  final search_value;
  final Function? onchange;
  final Function? ontextchange;
  final physics;
  const Header({
    super.key,
    this.child,
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
    this.padding = true,
    this.physics = null,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PrimaryColor,
      child: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          physics: widget.physics,
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              backgroundColor: PrimaryColor,
              expandedHeight: 4,
              title: SilverAppBar(
                title: widget.title,
                elevation: 0.5,
                show_arrow_icon: widget.show_arrow_icon,
                showtextbox: widget.showtextbox,
                ontextchange: (value) {
                  widget.ontextchange!(value);
                },
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Container(
                  padding: widget.padding == true
                      ? EdgeInsets.symmetric(horizontal: 10)
                      : null,
                  decoration: BoxDecoration(
                    color: LightGray,
                    border: Border.all(color: LightGray),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(RoundEdgePadding),
                        topRight: Radius.circular(RoundEdgePadding)),
                  ),
                  child: widget.child),
            ),
          ],
        ),
      ),
    );
  }
}
