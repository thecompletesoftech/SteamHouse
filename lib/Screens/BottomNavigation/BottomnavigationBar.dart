import 'dart:io';

import 'package:steamhouse/config/Import.dart';

class BottomnavigationBar extends StatefulWidget {
  final int pageIndex;
  final int? usertype;
  BottomnavigationBar({
    Key? key,
    this.pageIndex = 0,
    this.usertype,
  }) : super(key: key);

  @override
  State<BottomnavigationBar> createState() => _BottomnavigationBarState();
}

class _BottomnavigationBarState extends State<BottomnavigationBar> {
  int pageIndex = 0;
  final box = GetStorage();
  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState() {
    if (Get.parameters['index'] != null) {
      setState(() {
        pageIndex = Get.parameters['index'] as int;
      });
    } else {
      setState(() {
        pageIndex = widget.pageIndex;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pages = [
      if (box.read('usertype') == 0)
        Home(
          usertype: box.read('usertype'),
        ),
      ComplainList(),
      Profile(
        usertype: box.read('usertype'),
      )
    ];
    return WillPopScope(
      onWillPop: () async {
        return exit(1);
      },
      child: Scaffold(
        backgroundColor: White,
        body: pages[pageIndex],
        bottomNavigationBar: box.read('usertype') == 0
            ? BottomNavigationBar(
                elevation: 20,
                type: BottomNavigationBarType.fixed,
                backgroundColor: White,
                selectedItemColor: ButtonColor,
                unselectedItemColor: PrimaryColor,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                currentIndex: pageIndex,
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: White,
                      icon: pageIndex == 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: SvgPicture.string(
                                unselectedHomeIcon,
                                color: Lightgreen,
                              ))
                          : Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: SvgPicture.string(selectHomeIcon)),
                      label: ""),
                  BottomNavigationBarItem(
                      backgroundColor: White,
                      icon: pageIndex == 1
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SvgPicture.string(
                                toolicon,
                                height: 30,
                                color: Lightgreen,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SvgPicture.string(
                                toolicon,
                                height: 30,
                                color: PrimaryColor,
                              ),
                            ),
                      label: ""),
                  BottomNavigationBarItem(
                      backgroundColor: White,
                      icon: pageIndex == 2
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SvgPicture.string(
                                PersonIcon,
                                height: 30,
                                color: Lightgreen,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SvgPicture.string(
                                PersonIcon,
                                height: 30,
                                color: PrimaryColor,
                              ),
                            ),
                      label: ""),
                ],
              )
            : BottomNavigationBar(
                elevation: 20,
                type: BottomNavigationBarType.fixed,
                backgroundColor: White,
                selectedItemColor: ButtonColor,
                unselectedItemColor: PrimaryColor,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                currentIndex: pageIndex,
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: White,
                      icon: pageIndex == 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SvgPicture.string(
                                toolicon,
                                height: 30,
                                color: Lightgreen,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SvgPicture.string(
                                toolicon,
                                height: 30,
                                color: PrimaryColor,
                              ),
                            ),
                      label: ""),
                  BottomNavigationBarItem(
                      backgroundColor: White,
                      icon: pageIndex == 1
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SvgPicture.string(
                                PersonIcon,
                                height: 30,
                                color: Lightgreen,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SvgPicture.string(
                                PersonIcon,
                                height: 30,
                                color: PrimaryColor,
                              ),
                            ),
                      label: ""),
                ],
              ),
      ),
    );
  }

  setvalue() {
    setState(() {
      pageIndex = 0;
    });
  }
}
