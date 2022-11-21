import 'package:reliable_hands/config/export.dart';

class ForceUpdate extends StatelessWidget {
  static const String route = '/force_update';

  const ForceUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var info = ModalRoute.of(context)!.settings.arguments as dynamic;
    Map data = info['data'];

    print(data);

    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Assets.icons.logo.svg(),
          SizedBox(
            height: 5.h,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(left: 10),
            child: ReliableText.subHeaderText(
              text: data['message'],
              fontSize: 15.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: PagePadding.all(4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                data['code'] == 2
                    ? const Center()
                    : GestureDetector(
                        onTap: () {
//                          NavigatorHelper().navigateToScreen(LoginView.route);
                        },
                        child: SizedBox(
                          width: 45.w,
                          child: ReliableButton.tertiaryFilled(
                            label: 'Skip',
                          ),
                        ),
                      ),
                GestureDetector(
                  onTap: () {
                    _launchUrl();
                  },
                  child: SizedBox(
                    width: 45.w,
                    child: ReliableButton.tertiaryFilled(
                      label: 'Update',
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Future<void> _launchUrl() async {
    var url = "https://play.google.com/store/apps/details?id=com.matchnstick";
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
