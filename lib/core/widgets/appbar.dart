import 'package:flutter/material.dart';
import 'package:reliable_hands/core/widgets/texts/reliable_texts.dart';
import 'package:sizer/sizer.dart';

import '../../../config/theme/app_colors.dart';
import '../asset_gen/assets.gen.dart';

class Appbar extends StatelessWidget {
  final String? title;
  final int? index;

//  Diseases in Orange
  const Appbar({
    Key? key,
    this.title,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(index == 1 || index == 3 || title != null);
    return Center(
      child: Container(
        margin: index != 0 || title != null
            ? EdgeInsets.only(left: getMargin(index))
            : EdgeInsets.only(left: 12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            index == 0 && title == null
                ? Center(child: Assets.icons.logo.svg(width: 10.w, height: 5.h))
                : ReliableText.subHeaderText(
                  text: getTitle(index),
                  fontSize: 20.sp,
                  color: const Color(0xFF009444),
                  fontWeight: FontWeight.w700,
                  height: 1.63,
                ),
            const Spacer(),
            index == 4
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: const Color(0xff707070).withOpacity(0.7),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Stack(children: const <Widget>[
                        Icon(
                          Icons.notifications_rounded,
                          color: Color(0xff707070),
                        ),
                        Positioned(
                          // draw a red marble
                          top: 2.0,
                          right: 1.0,
                          child: Icon(Icons.brightness_1,
                              size: 10.0, color: APPColors.appPrimaryColor),
                        )
                      ]),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  String getTitle(int? index) {
    if (index == 1) {
      return "Shop";
    }

    if (index == 3) {
      return "Diseases in Orange";
    }

    if (index == 4) {
      return "Checkout";
    }
    return title ?? "";
  }

  getMargin(int? index) {
    if (index == 1 || index == 4) {
      return 20.w;
    }
    if (title != null) {
      return 30.w;
    }

    if (index == 3) {
      return 2.w;
    }

    return 0.0;
  }
}
