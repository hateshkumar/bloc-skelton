import 'package:reliable_hands/config/export.dart';
import 'package:reliable_hands/feature/drawer/drawer.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({Key? key}) : super(key: key);
  static const String route = '/main_home';

  @override
  State<MainHomeView> createState() => MainHomeViewState();
}

class MainHomeViewState extends State<MainHomeView> {
  int index = 0;

  List<Widget>? widgetList;
  final GlobalKey<ScaffoldState> _mainMenuKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();

    widgetList = [];
  }

  @override
  Widget build(BuildContext context) {
    return ToucheDetector(
      child: Scaffold(
        key: _mainMenuKey,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.menu_sharp,
              color: Color(0xff58585B),
            ),
            onPressed: () {
              _mainMenuKey.currentState!.openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
          centerTitle: true,
          title: Appbar(
            index: index,
          ),
        ),
        body: widgetList![index],
        drawer: const ReliableDrawer(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.11),
                offset: const Offset(0, -3.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            onTap: (i) {
              setState(() {
                index = i;
              });
            },
            items: [
              item(
                Image.asset(
                  Assets.images.tab1.path,
                  color: index == 0
                      ? APPColors.appPrimaryColor
                      : Color(0xffA3A3A3),
                ),
              ),
              item(
                Image.asset(Assets.images.tab2.path,
                    color: index == 1
                        ? APPColors.appPrimaryColor
                        : Color(0xffA3A3A3)),
              ),
              item(
                Image.asset(Assets.images.tab3.path,
                    color: index == 2
                        ? APPColors.appPrimaryColor
                        : Color(0xffA3A3A3)),
              ),
              item(
                Image.asset(Assets.images.tab4.path,
                    color: index == 3
                        ? APPColors.appPrimaryColor
                        : Color(0xffA3A3A3)),
              ),
              item(
                Image.asset(Assets.images.tab5.path,
                    color: index == 4
                        ? APPColors.appPrimaryColor
                        : Color(0xffA3A3A3)),
              ),
            ],
            elevation: 5,
            backgroundColor: APPColors.appWhite,
            selectedItemColor: APPColors.appBlack,
            unselectedItemColor: const Color(0xffA3A3A3),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem item(Widget icon) {
    return BottomNavigationBarItem(
        icon: SizedBox(
          width: 6.w,
          height: 3.h,
          child: icon,
        ),
        label: '');
  }
}
