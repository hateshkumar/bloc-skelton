import 'package:flutter/material.dart';

import 'app_colors.dart';

class ReliableTheme extends InheritedWidget {
  /// Constructor for creating a [ReliableTheme]
  const ReliableTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static final themeData = ReliableThemeData(
    primary: APPColors.appWhite.value,
    secondary: APPColors.appWhite.value,
    tertiary: APPColors.appWhite.value,
    textPrimary: APPColors.appWhite.value,
    textSecondary: APPColors.appWhite.value,
    fontFamily: 'Urbanist',
  );

  /// Theme data
  final ReliableThemeData data;

  static ThemeData generateThemeDataFromreliableHandsThemeData(
    ReliableThemeData data,
  ) {
    final backgroundColor = data.colorTheme.primary;
    final original = ThemeData.light();
    return ThemeData(
      fontFamily: data.fontFamily,
      brightness: data.brightness,
      canvasColor: data.colorTheme.primary,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: original.primaryColor,
      cardColor: Colors.white,
      appBarTheme: data.appBarTheme,
      textSelectionTheme: original.textSelectionTheme
          .copyWith(cursorColor: data.colorTheme.secondary),
      textTheme: original.textTheme.copyWith(
        // Currently used for Meetup/Event title and discovery cards
        headline2: data.textTheme.headingLarge,
        // I use this for card headers such as on meetup details
        headline4: data.textTheme.bodyMedium,
        // Used in signup headers
        headline5: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          letterSpacing: 0,
        ),
        headline6: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
        // Used for text input for some reason
        subtitle1: data.textTheme.bodySmall,
        subtitle2: data.textTheme.bodySmall
            .copyWith(fontSize: 16.0, fontWeight: FontWeight.w700),
        bodyText1: data.textTheme.bodyMedium,
        bodyText2: data.textTheme.bodySmall,
      ),
      buttonTheme: original.buttonTheme.copyWith(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        // minWidth: 100,
        textTheme: ButtonTextTheme.normal,
      ),
      inputDecorationTheme: original.inputDecorationTheme.copyWith(
        contentPadding: data.padding.inputFieldPadding,
        errorMaxLines: 3,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: data.colorTheme.secondary, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: data.secondaryTextTheme.bodySmall,
        filled: true,
        fillColor: data.colorTheme.tertiary,
        iconColor: data.colorTheme.textPrimary,
        errorStyle: data.errorTextTheme.bodySmall.copyWith(
          overflow: TextOverflow.ellipsis,
        ),
        // Note careful: using fill messes up the Stream chat
        // filled: true,
        // fillColor: Colors.white,
      ),
      sliderTheme: original.sliderTheme.copyWith(
        activeTrackColor: data.colorTheme.secondary,
        inactiveTrackColor: data.colorTheme.secondary,
        trackHeight: 2,
        thumbColor: data.colorTheme.secondary,
      ),
      buttonBarTheme: const ButtonBarThemeData(
        buttonPadding: EdgeInsets.symmetric(horizontal: 15),
        layoutBehavior: ButtonBarLayoutBehavior.constrained,
      ),
      iconTheme: IconThemeData(
        color: data.colorTheme.icon,
        size: 22, //16
      ),
      snackBarTheme: original.snackBarTheme.copyWith(
        actionTextColor: const Color(0xFFe1e1e1),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF42434A),
        thickness: 1,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
      bottomNavigationBarTheme: original.bottomNavigationBarTheme.copyWith(
        backgroundColor: data.bottomNavigationBarTheme.backgroundColor,
        selectedIconTheme: data.bottomNavigationBarTheme.selectedIconTheme,
        unselectedIconTheme: data.bottomNavigationBarTheme.unselectedIconTheme,
      ),
    );
  }

  @override
  bool updateShouldNotify(ReliableTheme old) => data != old.data;

  /// Use this method to get the current [StreamChatThemeData] instance
  static ReliableThemeData of(BuildContext context) {
    final reliableHandsTheme =
        context.dependOnInheritedWidgetOfExactType<ReliableTheme>();

    assert(
      reliableHandsTheme != null,
      'You must have a ReliableTheme password at the top of your password tree',
    );

    return reliableHandsTheme!.data;
  }
}

class ReliableThemeData {
  final Brightness brightness;
  final int primary;
  final int secondary;
  final int tertiary;
  final int textPrimary;
  final int textSecondary;
  final String fontFamily;

  /// Create a theme from scratch
  ReliableThemeData({
    this.brightness = Brightness.dark,
    this.primary = 0xFF1A1B22,
    this.secondary = 0xFF1DA1F2,
    this.tertiary = 0xFF23252F,
    this.textPrimary = 0xFFFFFFFF,
    this.textSecondary = 0xFF8C8D90,
    this.fontFamily = 'Urbanist',
  });

  final original = ThemeData.light();

  final color = Color(0xFF009DFF);
  late final ColorTheme colorTheme = ColorTheme(
      brightness: brightness,
      primary: ReliableColor(primary),
      secondary: ReliableColor(secondary),
      tertiary: ReliableColor(tertiary),
      textPrimary: ReliableColor(textPrimary),
      textSecondary: ReliableColor(textSecondary));

  late final ReliableTextTheme textTheme =
      ReliableTextTheme(textColor: colorTheme.textPrimary);

  late final ReliableTextTheme secondaryTextTheme =
      ReliableTextTheme(textColor: colorTheme.textSecondary);

  late final ReliableTextTheme errorTextTheme =
      ReliableTextTheme(textColor: colorTheme.error);

  late final IconThemeData primaryIconTheme =
      IconThemeData(color: colorTheme.icon);

  late final ReliableBottomNavigationBarTheme bottomNavigationBarTheme =
      ReliableBottomNavigationBarTheme(colorTheme: colorTheme);

  late final ReliableButtonTheme buttonTheme =
      ReliableButtonTheme(color: colorTheme.primary);

  late final ReliableButtonTheme secondaryButtonTheme =
      ReliableButtonTheme(color: colorTheme.buttonSecondary);

  late final ProgressIndicatorThemeData progressIndicatorThemeData =
      ProgressIndicatorThemeData(
    color: colorTheme.secondary,
    linearTrackColor: colorTheme.secondary.shade100,
  );

  //BottomSheet Theming

  // late final B

  //Material Theming
  late final AppBarTheme appBarTheme = AppBarTheme(
    //systemOverlayStyle: defaultSystemOverlayStyle,
    color: colorTheme.primary,
    centerTitle: false,
    elevation: 0,
    titleTextStyle:
        textTheme.headingMedium.copyWith(color: colorTheme.textPrimary),
    iconTheme: IconThemeData(color: colorTheme.icon, size: 22, opacity: 1),
  );

  late final ReliablePaddingData padding = ReliablePaddingData();
}

class ColorTheme {
  final Brightness brightness;
  final ReliableColor primary;
  final ReliableColor secondary;
  final ReliableColor tertiary;
  final ReliableColor textPrimary;
  final ReliableColor textSecondary;
  final ReliableColor icon;

  ColorTheme({
    this.brightness = Brightness.dark,
    this.primary = const ReliableColor(0xff01C7A3),
    this.secondary = const ReliableColor(0xFF1DA1F2),
    this.tertiary = const ReliableColor(0xFF23252F),
    this.textPrimary = const ReliableColor(0xFFFFFFFF),
    this.textSecondary = const ReliableColor(0xFF8C8D90),
    this.icon = const ReliableColor(0xFFFFFFFF),
  });

  late final ReliableColor buttonPrimary = primary;
  late final ReliableColor buttonSecondary = secondary;

  late final ReliableColor error = ReliableColor(0xFFFF6188);
  late final ReliableColor success = ReliableColor(0xFFBAD761);
}

class ReliableColor extends ColorSwatch<int> {
  final int value;

  const ReliableColor(this.value) : super(value, const <int, Color>{});

  Color get shade500 => withOpacity(.8);

  Color get shade400 => withOpacity(.6);

  Color get shade300 => withOpacity(.4);

  Color get shade100 => withOpacity(.2);
}

class ReliablePaddingData {
  //defaults
  final inputFieldPadding = const EdgeInsets.all(12);
  final screenPadding =
      const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
}

class ReliableButtonTheme {
  final ReliableColor color;

  ReliableButtonTheme({required this.color});

  late final ButtonStyle outlinedButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff58585B)),
    foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.any(_disabledStates.contains)) {
        return Colors.white;
      }
      return color;
    }),
    overlayColor: MaterialStateProperty.all<Color>(Colors.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
    ),
    side: MaterialStateProperty.resolveWith<BorderSide>((states) {
      if (states.any(_disabledStates.contains)) {
        return BorderSide(
            color: color.shade400, width: 1, style: BorderStyle.solid);
      }
      return BorderSide(color: color, width: 1, style: BorderStyle.solid);
    }),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  late final ButtonStyle filledButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.any(_disabledStates.contains)) {
        return APPColors.appPrimaryColor;
      }
      return color;
    }),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shadowColor: MaterialStateProperty.all<Color>(APPColors.appPrimaryDropShadow),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  late final ButtonStyle textButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.any(_disabledStates.contains)) {
        return color.shade400;
      }
      return color;
    }),
    shadowColor: MaterialStateProperty.all<Color>(APPColors.appPrimaryDropShadow),
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32))),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  late final ButtonStyle filledIconButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.any(_disabledStates.contains)) {
        return color.shade400;
      }
      return color;
    }),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shape: MaterialStateProperty.all<CircleBorder>(
      const CircleBorder(),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  late final ButtonStyle outlinedIconButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.any(_disabledStates.contains)) {
        return color.shade400;
      }
      return color;
    }),
    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shape: MaterialStateProperty.all<CircleBorder>(
      const CircleBorder(),
    ),
    side: MaterialStateProperty.resolveWith<BorderSide>((states) {
      if (states.any(_disabledStates.contains)) {
        return BorderSide(
            color: color.shade400, width: 1, style: BorderStyle.solid);
      }
      return BorderSide(color: color, width: 1, style: BorderStyle.solid);
    }),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  late final ButtonStyle flatIconButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    foregroundColor: MaterialStateProperty.all<Color>(color),
    // overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shape: MaterialStateProperty.all<CircleBorder>(
      const CircleBorder(),
    ),
    elevation: MaterialStateProperty.all<double>(4),
    shadowColor: MaterialStateProperty.all<Color>(Colors.black),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  static const Set<MaterialState> _interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  static const Set<MaterialState> _disabledStates = <MaterialState>{
    MaterialState.disabled,
    MaterialState.error,
  };
}

class ReliableBottomNavigationBarTheme {
  final ColorTheme colorTheme;
  final Brightness brightness;

  ReliableBottomNavigationBarTheme({
    this.brightness = Brightness.dark,
    required this.colorTheme,
  });

  late final IconThemeData selectedIconTheme =
      IconThemeData(color: colorTheme.secondary, size: 32);

  late final IconThemeData unselectedIconTheme =
      IconThemeData(color: colorTheme.tertiary, size: 28);

  late final ReliableColor backgroundColor = ReliableColor(0xB11A1B22);

  late final BorderRadius borderRadius = BorderRadius.circular(32);
}

class ReliableTextTheme {
  final String fontFamily;
  final ReliableColor textColor;

  ReliableTextTheme({
    this.fontFamily = 'Urbanist',
    required this.textColor,
  });

  late final TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    letterSpacing: -1.5,
    color: textColor,
  );
  late final TextStyle displayMedium = TextStyle(
    fontSize: 32,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: textColor,
    letterSpacing: -1.5,
  );

  late final TextStyle headingLarge = TextStyle(
    fontSize: 24,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    color: textColor,
  );
  late final TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: textColor,
    letterSpacing: -1,
  );
  late final TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: textColor,
    letterSpacing: -0.25,
  );
  late final TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: textColor,
    letterSpacing: -0.25,
  );
  late final TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: textColor,
  );
  late final TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: textColor,
  );
  late final TextStyle labelSmall = TextStyle(
      fontSize: 8,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      color: textColor);
  late final TextStyle labelGrayLarge = TextStyle(
    fontSize: 32,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: APPColors.grey,
  );
  late final TextStyle labelGrayMedium = TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: APPColors.grey,
  );
  late final TextStyle labelGraySmall = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: APPColors.grey,
  );
}
