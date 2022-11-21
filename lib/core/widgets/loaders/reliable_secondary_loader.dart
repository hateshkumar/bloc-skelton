import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/reliable_themes.dart';

enum LoaderSize { SMALL, MEDIUM, LARGE }

class ReliableSecondaryScreenProgressIndicator extends StatelessWidget {
  final bool enabled;

  const ReliableSecondaryScreenProgressIndicator({
    super.key,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    if (enabled) {
      return SizedBox(
        width: 35,
        height: 35,
        child: CircularProgressIndicator(
          color: ReliableTheme.of(context).colorTheme.buttonPrimary,
          backgroundColor: APPColors.appPrimaryColor,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
