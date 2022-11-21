import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/reliable_themes.dart';

enum LoaderSize { SMALL, MEDIUM, LARGE }

class ReliableFullScreenProgressIndicator extends StatelessWidget {
  final bool enabled;
  final Widget child;
  const ReliableFullScreenProgressIndicator({super.key,
    required this.enabled,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (enabled) {
      return Center(
        child: CircularProgressIndicator(
          color: ReliableTheme.of(context).colorTheme.buttonPrimary,
          backgroundColor: APPColors.appPrimaryColor,
        ),
      );
    }
    return child;
  }
}
