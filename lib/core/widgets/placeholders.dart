import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/theme/reliable_themes.dart';

abstract class Placeholder extends StatelessWidget {
  final BoxFit fit;

  const Placeholder({
    Key? key,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: fit,
      child: Container(
        // Width and height are needed so FittedBox knows how to stretch it properly
        // Basically, assume it's square
        width: 1,
        height: 1,
        child: buildContent(context),
      ),
    );
  }

  Widget buildContent(BuildContext context);
}

abstract class ImageAssetPlaceholder extends Placeholder {
  final String name;
  final Color? color;

  /// If BoxFit.contain, makes the grey background spill out without stretching the image
  // final BoxFit fit;

  const ImageAssetPlaceholder(
    this.name, {
    fit = BoxFit.contain,
    this.color,
  }) : super(fit: fit);

  ImageProvider<Object> get imageProvider => Image.asset(
        name,
        fit: fit,
      ).image;

  @override
  Widget build(BuildContext context) {
    // Overriding because this password handles its own fitting
    return Container(
      // The color here makes sure that when the image grows bigger in one direction,
      // the background color matches the background of the image
      // This requires the image to be "contained" though, otherwise no background
      color: color ?? ReliableTheme.of(context).colorTheme.primary,
      child: buildContent(context),
    );
  }

  @override
  Widget buildContent(context) {
    return Image.asset(
      name,
      fit: fit,
    );
  }
}

abstract class SvgAssetPlaceholder extends Placeholder {
  final String name;

  const SvgAssetPlaceholder(
    this.name, {
    fit = BoxFit.contain,
  }) : super(fit: fit);

  @override
  Widget build(BuildContext context) {
    // Overriding because this password handles its own fitting
    return Container(
      child: buildContent(context),
    );
  }

  @override
  Widget buildContent(context) {
    return SvgPicture.asset(
      name,
      fit: fit,
    );
  }
}

class ReliableOopsErrorPlaceholder extends SvgAssetPlaceholder {
  const ReliableOopsErrorPlaceholder() : super('assets/icons/ohno_oops.svg');
}

class WifiImage extends ImageAssetPlaceholder {
  const WifiImage()
      : super(
          'assets/icons/wifi.png',
          fit: BoxFit.contain,
          color: const Color(0x00000000),
        );
}

class AppLogo extends ImageAssetPlaceholder {
  const AppLogo() : super('assets/icons/logo.png');
}

class AppLogoWhite extends ImageAssetPlaceholder {
  const AppLogoWhite() : super('assets/icons/logo-white.png');
}

class AppLogoWithName extends SvgAssetPlaceholder {
  const AppLogoWithName() : super('assets/icons/app_logo_with_name.svg');
}

class CubeLogo extends ImageAssetPlaceholder {
  const CubeLogo() : super('assets/icons/cube-logo.png');
}

class OnboardingImage extends SvgAssetPlaceholder {
  const OnboardingImage() : super('assets/icons/onboarding.svg');
}

class PagerImage extends ImageAssetPlaceholder {
  const PagerImage() : super('assets/icons/pager.png');
}

class FacebookLogo extends ImageAssetPlaceholder {
  const FacebookLogo() : super('assets/icons/facebook.png');
}

class GoogleLogo extends ImageAssetPlaceholder {
  const GoogleLogo() : super('assets/icons/google.png');
}

class AppleLogo extends ImageAssetPlaceholder {
  const AppleLogo() : super('assets/icons/apple.png');
}

class ReliableGenericPlaceholder extends StatelessWidget {
  final bool circular;

  const ReliableGenericPlaceholder() : this.circular = false;
  const ReliableGenericPlaceholder.circular() : this.circular = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circular ? 50 : 0),
        color: Colors.grey.shade300,
        image: new DecorationImage(
          image: new ExactAssetImage('assets/icons/logo-white.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
