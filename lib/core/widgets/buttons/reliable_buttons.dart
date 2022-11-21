import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import '../../../config/theme/reliable_themes.dart';
import 'base_button.dart';

class ReliableButton extends ReliableBaseButton {
  ReliableButton.primaryOutlined({
    Key? key,
    Widget? child,
    Widget? icon,
    String? label,
    VoidCallback? onPressed,
    bool? enabled,
    ReliableBaseButtonIconPosition? iconPosition,
    bool shrinkWrap = false,
    ButtonSize buttonSize = ButtonSize.medium,
    BehaviorSubject<ButtonState>? state$,
    BehaviorSubject<bool>? enabledSubject,
    BehaviorSubject<bool>? disabledSubject,
    BehaviorSubject<bool>? loadingSubject,

    /// backward compatibility
    @deprecated Stream<bool>? enabledStream,

    /// backward compatibility
    @deprecated Stream<bool>? disabledStream,
  }) : super(
          key: key,
          child: child,
          icon: icon,
          label: label,
          onPressed: onPressed,
          enabled: enabled,
          buttonSize: buttonSize,
          shrinkWrap: shrinkWrap,
          type: ButtonType.primary,
          decoration: ButtonDecoration.outlined,
          iconPosition: iconPosition ?? ReliableBaseButtonIconPosition.LEFT,
          state$: state$,
          enabledSubject: enabledSubject,
          disabledSubject: disabledSubject,
          loadingSubject: loadingSubject,
          enabledStream: enabledStream,
          disabledStream: disabledStream,
        );

  ReliableButton.secondaryOutlined({
    Key? key,
    Widget? child,
    Widget? icon,
    String? label,
    VoidCallback? onPressed,
    bool? enabled,
    ReliableBaseButtonIconPosition? iconPosition,
    bool shrinkWrap = false,
    ButtonSize buttonSize = ButtonSize.large,
    BehaviorSubject<ButtonState>? state$,
    BehaviorSubject<bool>? enabledSubject,
    BehaviorSubject<bool>? disabledSubject,
    BehaviorSubject<bool>? loadingSubject,

    /// backward compatibility
    @deprecated Stream<bool>? enabledStream,

    /// backward compatibility
    @deprecated Stream<bool>? disabledStream,
  }) : super(
          key: key,
          child: child,
          icon: icon,
          label: label,
          onPressed: onPressed,
          enabled: enabled,
          buttonSize: buttonSize,
          shrinkWrap: shrinkWrap,
          type: ButtonType.secondary,
          decoration: ButtonDecoration.outlined,
          iconPosition: iconPosition ?? ReliableBaseButtonIconPosition.LEFT,
          state$: state$,
          enabledSubject: enabledSubject,
          disabledSubject: disabledSubject,
          loadingSubject: loadingSubject,
          enabledStream: enabledStream,
          disabledStream: disabledStream,
        );

  ReliableButton.primaryFilled({
    Key? key,
    Widget? child,
    Widget? icon,
    String? label,
    VoidCallback? onPressed,
    bool? enabled,
    ReliableBaseButtonIconPosition? iconPosition,
    bool shrinkWrap = false,
    ButtonSize buttonSize = ButtonSize.large,
    BehaviorSubject<ButtonState>? state$,
    BehaviorSubject<bool>? enabledSubject,
    BehaviorSubject<bool>? disabledSubject,
    BehaviorSubject<bool>? loadingSubject,

    /// backward compatibility
    @deprecated Stream<bool>? enabledStream,

    /// backward compatibility
    @deprecated Stream<bool>? disabledStream,
  }) : super(
          key: key,
          child: child,
          icon: icon,
          label: label,
          onPressed: onPressed,
          enabled: enabled,
          buttonSize: buttonSize,
          shrinkWrap: shrinkWrap,
          type: ButtonType.primary,
          decoration: ButtonDecoration.filled,
          iconPosition: iconPosition ?? ReliableBaseButtonIconPosition.LEFT,
          state$: state$,
          enabledSubject: enabledSubject,
          disabledSubject: disabledSubject,
          loadingSubject: loadingSubject,
          enabledStream: enabledStream,
          disabledStream: disabledStream,
        );

  ReliableButton.secondaryFilled({
    Key? key,
    Widget? child,
    Widget? icon,
    String? label,
    VoidCallback? onPressed,
    Color? bgColor,
    bool? enabled,
    ReliableBaseButtonIconPosition? iconPosition,
    bool shrinkWrap = false,
    ButtonSize buttonSize = ButtonSize.large,
    BehaviorSubject<ButtonState>? state$,
    BehaviorSubject<bool>? enabledSubject,
    BehaviorSubject<bool>? disabledSubject,
    BehaviorSubject<bool>? loadingSubject,

    /// backward compatibility
    @deprecated Stream<bool>? enabledStream,

    /// backward compatibility
    @deprecated Stream<bool>? disabledStream,
  }) : super(
          key: key,
          child: child,
          icon: icon,
          label: label,
          onPressed: onPressed,
          enabled: enabled,
          bgColor: bgColor,
          buttonSize: buttonSize,
          shrinkWrap: shrinkWrap,
          type: ButtonType.secondary,
          decoration: ButtonDecoration.filled,
          iconPosition: iconPosition ?? ReliableBaseButtonIconPosition.LEFT,
          state$: state$,
          enabledSubject: enabledSubject,
          disabledSubject: disabledSubject,
          loadingSubject: loadingSubject,
          enabledStream: enabledStream,
          disabledStream: disabledStream,
        );

  ReliableButton.tertiaryFilled({
    Key? key,
    Widget? child,
    Widget? icon,
    String? label,
    VoidCallback? onPressed,
    bool? enabled,
    ReliableBaseButtonIconPosition? iconPosition,
    bool shrinkWrap = false,
    ButtonSize buttonSize = ButtonSize.large,
    BehaviorSubject<ButtonState>? state$,
    BehaviorSubject<bool>? enabledSubject,
    BehaviorSubject<bool>? disabledSubject,
    BehaviorSubject<bool>? loadingSubject,

    /// backward compatibility
    @deprecated Stream<bool>? enabledStream,

    /// backward compatibility
    @deprecated Stream<bool>? disabledStream,
  }) : super(
          key: key,
          child: child,
          icon: icon,
          label: label,
          onPressed: onPressed,
          enabled: enabled,
          buttonSize: buttonSize,
          shrinkWrap: shrinkWrap,
          type: ButtonType.tertiery,
          decoration: ButtonDecoration.filled,
          iconPosition: iconPosition ?? ReliableBaseButtonIconPosition.LEFT,
          state$: state$,
          enabledSubject: enabledSubject,
          disabledSubject: disabledSubject,
          loadingSubject: loadingSubject,
          enabledStream: enabledStream,
          disabledStream: disabledStream,
        );

  ReliableButton.tertiaryFilledColorLess({
    Key? key,
    Widget? child,
    Widget? icon,
    String? label,
    VoidCallback? onPressed,
    bool? enabled,
    ReliableBaseButtonIconPosition? iconPosition,
    bool shrinkWrap = false,
    ButtonSize buttonSize = ButtonSize.large,
    BehaviorSubject<ButtonState>? state$,
    BehaviorSubject<bool>? enabledSubject,
    BehaviorSubject<bool>? disabledSubject,
    BehaviorSubject<bool>? loadingSubject,

    /// backward compatibility
    @deprecated Stream<bool>? enabledStream,

    /// backward compatibility
    @deprecated Stream<bool>? disabledStream,
  }) : super(
          key: key,
          child: child,
          icon: icon,
          label: label,
          onPressed: onPressed,
          enabled: enabled,
          buttonSize: buttonSize,
          shrinkWrap: shrinkWrap,
          type: ButtonType.tertiery,
          decoration: ButtonDecoration.less,
          iconPosition: iconPosition ?? ReliableBaseButtonIconPosition.LEFT,
          state$: state$,
          enabledSubject: enabledSubject,
          disabledSubject: disabledSubject,
          loadingSubject: loadingSubject,
          enabledStream: enabledStream,
          disabledStream: disabledStream,
        );

  ReliableButton.primaryBorderless({
    Key? key,
    Widget? child,
    Widget? icon,
    String? label,
    VoidCallback? onPressed,
    bool? enabled,
    ReliableBaseButtonIconPosition? iconPosition,
    bool shrinkWrap = false,
    ButtonSize buttonSize = ButtonSize.large,
    BehaviorSubject<ButtonState>? state$,
    BehaviorSubject<bool>? enabledSubject,
    BehaviorSubject<bool>? disabledSubject,
    BehaviorSubject<bool>? loadingSubject,
  }) : super(
          key: key,
          child: child,
          icon: icon,
          label: label,
          onPressed: onPressed,
          enabled: enabled,
          buttonSize: buttonSize,
          shrinkWrap: shrinkWrap,
          type: ButtonType.primary,
          decoration: ButtonDecoration.none,
          iconPosition: iconPosition ?? ReliableBaseButtonIconPosition.LEFT,
          state$: state$,
          enabledSubject: enabledSubject,
          disabledSubject: disabledSubject,
          loadingSubject: loadingSubject,
        );

  ReliableButton.secondaryBorderless({
    Key? key,
    Widget? child,
    Widget? icon,
    String? label,
    VoidCallback? onPressed,
    bool? enabled,
    ReliableBaseButtonIconPosition? iconPosition,
    bool shrinkWrap = false,
    ButtonSize buttonSize = ButtonSize.large,
    BehaviorSubject<ButtonState>? state$,
    BehaviorSubject<bool>? enabledSubject,
    BehaviorSubject<bool>? disabledSubject,
    BehaviorSubject<bool>? loadingSubject,

    /// backward compatibility
    @deprecated Stream<bool>? enabledStream,

    /// backward compatibility
    @deprecated Stream<bool>? disabledStream,
  }) : super(
          key: key,
          child: child,
          icon: icon,
          label: label,
          onPressed: onPressed,
          enabled: enabled,
          buttonSize: buttonSize,
          shrinkWrap: shrinkWrap,
          type: ButtonType.secondary,
          decoration: ButtonDecoration.none,
          iconPosition: iconPosition ?? ReliableBaseButtonIconPosition.LEFT,
          state$: state$,
          enabledSubject: enabledSubject,
          disabledSubject: disabledSubject,
          loadingSubject: loadingSubject,
          enabledStream: enabledStream,
          disabledStream: disabledStream,
        );

  ReliableButton.tertiaryBorderless({
    Key? key,
    Widget? child,
    Widget? icon,
    String? label,
    VoidCallback? onPressed,
    bool? enabled,
    ReliableBaseButtonIconPosition? iconPosition,
    bool shrinkWrap = false,
    ButtonSize buttonSize = ButtonSize.large,
    BehaviorSubject<ButtonState>? state$,
    BehaviorSubject<bool>? enabledSubject,
    BehaviorSubject<bool>? disabledSubject,
    BehaviorSubject<bool>? loadingSubject,
  }) : super(
          key: key,
          child: child,
          icon: icon,
          label: label,
          onPressed: onPressed,
          enabled: enabled,
          buttonSize: buttonSize,
          shrinkWrap: shrinkWrap,
          type: ButtonType.primary,
          decoration: ButtonDecoration.none,
          iconPosition: iconPosition ?? ReliableBaseButtonIconPosition.LEFT,
          state$: state$,
          enabledSubject: enabledSubject,
          disabledSubject: disabledSubject,
          loadingSubject: loadingSubject,
        );

  //This is used to create any custom button with different style
  ReliableButton.custom({
    Key? key,
    Widget? child,
    Widget? icon,
    String? label,
    TextStyle? labelTextStyle,
    VoidCallback? onPressed,
    bool? enabled,
    ReliableBaseButtonIconPosition? iconPosition,
    bool shrinkWrap = false,
    required ButtonSize buttonSize,
    required ButtonType type,
    required ButtonDecoration decoration,
    BehaviorSubject<ButtonState>? state$,
    BehaviorSubject<bool>? enabledSubject,
    BehaviorSubject<bool>? disabledSubject,
    BehaviorSubject<bool>? loadingSubject,

    /// backward compatibility
    @deprecated Stream<bool>? enabledStream,

    /// backward compatibility
    @deprecated Stream<bool>? disabledStream,
  }) : super(
          key: key,
          child: child,
          icon: icon,
          label: label,
          labelTextStyle: labelTextStyle,
          onPressed: onPressed,
          enabled: enabled,
          buttonSize: buttonSize,
          shrinkWrap: shrinkWrap,
          type: type,
          decoration: decoration,
          iconPosition: iconPosition ?? ReliableBaseButtonIconPosition.LEFT,
          state$: state$,
          enabledSubject: enabledSubject,
          disabledSubject: disabledSubject,
          loadingSubject: loadingSubject,
          enabledStream: enabledStream,
          disabledStream: disabledStream,
        );

  @override
  ButtonStyle getButtonStyle(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        switch (decoration) {
          case ButtonDecoration.outlined:
            return ReliableTheme.of(context)
                .buttonTheme
                .outlinedButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          case ButtonDecoration.filled:
            return ReliableTheme.of(context)
                .buttonTheme
                .filledButtonStyle
                .copyWith(
                  elevation: MaterialStateProperty.all<double>(12),
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );

          case ButtonDecoration.less:
            return ReliableTheme.of(context)
                .secondaryButtonTheme
                .filledButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          case ButtonDecoration.none:
            return ReliableTheme.of(context)
                .buttonTheme
                .textButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          default:
            throw UnimplementedError(
                'Type [ButtonDecoration] is not implemented here yet');
        }
      case ButtonType.secondary:
        switch (decoration) {
          case ButtonDecoration.outlined:
            return ReliableTheme.of(context)
                .secondaryButtonTheme
                .outlinedButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          case ButtonDecoration.less:
            return ReliableTheme.of(context)
                .secondaryButtonTheme
                .filledButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          case ButtonDecoration.filled:
            return ReliableTheme.of(context)
                .secondaryButtonTheme
                .filledButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          case ButtonDecoration.none:
            return ReliableTheme.of(context)
                .secondaryButtonTheme
                .textButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          default:
            throw UnimplementedError(
                'Type [ButtonDecoration] is not implemented here yet');
        }
      case ButtonType.tertiery:
        switch (decoration) {
          case ButtonDecoration.outlined:
            return ReliableTheme.of(context)
                .buttonTheme
                .outlinedButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          case ButtonDecoration.less:
            return ReliableTheme.of(context)
                .secondaryButtonTheme
                .filledButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          case ButtonDecoration.filled:
            return ReliableTheme.of(context)
                .buttonTheme
                .filledButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          case ButtonDecoration.none:
            return ReliableTheme.of(context)
                .buttonTheme
                .textButtonStyle
                .copyWith(
                  textStyle: MaterialStateProperty.all(getTextTheme(context)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      getButtonPadding(context)),
                );
          default:
            throw UnimplementedError(
                'Type [ButtonDecoration] is not implemented here yet');
        }
      default:
        throw UnimplementedError(
            'Type [ButtonType] is not implemented here yet');
    }
  }
}
