
import 'package:steamhouse/config/Import.dart';

class ComplainList extends StatefulWidget {
  const ComplainList({super.key});

  @override
  State<ComplainList> createState() => _ComplainListState();
}

class _ComplainListState extends State<ComplainList> {
  int index = 0;
  PageController? _pageController;
  ComplainController complainController = Get.put(ComplainController());
  List pages = [
    ComplainPending(),
    ComplainInprocess(),
    ComplainCompleted(),
  ];
  void initState() {
    _pageController = PageController(initialPage: index);
    complainController.ComplainList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBarHeight),
        child: Appbartext(
          title: 'ServiceRequesttxt'.tr,
          elevation: 0.0,
          show_arrow_icon: 1,
        ),
      ),
      backgroundColor: PrimaryColor,
      body: Header(
        title: '',
        show_arrow_icon: 1,
        showtextbox: true,
        ShowCalender: false,
        padding: false,
        physics: NeverScrollableScrollPhysics(),
        ontextchange: (value) {
          index == 0
              ? complainController.PendingrunFilter(value)
              : index == 1
                  ? complainController.inprogressrunFilter(value)
                  : complainController.CompleterunFilter(value);
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                index = 0;
                                _pageController!.jumpToPage(0);
                              });
                            },
                            child: Obx(
                              () => Togglebtn(
                                txt: "Pending".tr +
                                    " (" +
                                    complainController.pending.length
                                        .toString() +
                                    ")",
                                style: TextStyles.withColor(TextStyles.mb16,
                                    index == 0 ? White : Black),
                                active: index == 0 ? true : false,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                index = 1;
                                _pageController!.jumpToPage(1);
                              });
                            },
                            child: Obx(
                              () => Togglebtn(
                                txt: "Open".tr +
                                    " (" +
                                    complainController.inprogress.length
                                        .toString() +
                                    ")",
                                style: TextStyles.withColor(TextStyles.mb16,
                                    index == 1 ? White : Black),
                                active: index == 1 ? true : false,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                index = 2;
                                _pageController!.jumpToPage(2);
                              });
                            },
                            child: Obx(
                              () => Togglebtn(
                                txt: "Closed".tr +
                                    " (" +
                                    complainController.completed.length
                                        .toString() +
                                    ")",
                                style: TextStyles.withColor(TextStyles.mb16,
                                    index == 2 ? White : Black),
                                active: index == 2 ? true : false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).paddingSymmetric(horizontal: 15),
              Expanded(
                child: Container(
                    // height: size.height * 0.9,
                    child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                  itemCount: pages.length, // Can be null
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
