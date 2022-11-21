import 'package:reliable_hands/config/export.dart';

import 'package:markdown/markdown.dart' as md;

enum DialogButtonTypes {
  PRIMARY,
  SECONDARY,
  SECONDARY_FILLED,
  SECONDARY_OUTLINE,
}

/// Priority
/// 1. child
/// 2. label
/// 3 icon
class ReliableDialogButton<T> {
  final String? label;
  final IconData? icon;
  final BehaviorSubject<bool>? disabledSubject;
  final Function? onPressed;
  final bool dismisses;
  final DialogButtonTypes dialogButtonType;
  final BehaviorSubject<T>? data$;

  final T? value;

  /// Dialog button [dismisses] the dialog by default.
  /// set [dismisses] to false to keep the dialog open.
  const ReliableDialogButton({
    this.label,
    this.value,
    this.icon,
    this.onPressed,
    this.data$,
    this.dismisses = true,
    this.disabledSubject,
    this.dialogButtonType = DialogButtonTypes.SECONDARY,
  });
}

abstract class ReliableDialog<T> extends StatelessWidget {
  final String? title;
  final List<ReliableDialogButton>? actions;
  final EdgeInsets margin;
  const ReliableDialog({
    this.margin = const EdgeInsets.symmetric(horizontal: 36.0, vertical: 52.0),
    this.title,
    this.actions,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: APPColors.appPrimaryColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Container(
        margin: margin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(context),
            buildContent(context),
            distanceBetweenContentAndActionButtons,
            ...buildActions(context)
                .map(
                  (ReliableDialogButton action) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: createActionButton(context, action),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  SizedBox get distanceBetweenContentAndActionButtons =>
      const SizedBox(height: 24.0);

  ReliableDialogButton dismissButton({String? message}) {
    return ReliableDialogButton(
      label: message ?? 'GREAT',
      dismisses: true,
    );
  }

  Widget createActionButton(BuildContext context, ReliableDialogButton action) {
    switch (action.dialogButtonType) {
      case DialogButtonTypes.PRIMARY:
        return ReliableButton.primaryFilled(
          label: action.label,
          icon: action.icon != null ? Icon(action.icon) : null,
          disabledSubject: action.disabledSubject,
          iconPosition: ReliableBaseButtonIconPosition.RIGHT,
          onPressed: () {
            if (action.dismisses) Navigator.of(context).pop();
            if (action.onPressed != null) action.onPressed!();
          },
        );

      case DialogButtonTypes.SECONDARY:
        return ReliableButton.secondaryBorderless(
          label: action.label,
          icon: action.icon != null ? Icon(action.icon) : null,
          disabledSubject: action.disabledSubject,
          onPressed: () {
            if (action.dismisses) Navigator.of(context).pop();
            if (action.onPressed != null) action.onPressed!();
          },
        );
      case DialogButtonTypes.SECONDARY_FILLED:
        return ReliableButton.secondaryFilled(
          label: action.label,
          disabledSubject: action.disabledSubject,
          onPressed: () {
            if (action.dismisses) Navigator.of(context).pop();
            if (action.onPressed != null) action.onPressed!();
          },
        );
      case DialogButtonTypes.SECONDARY_OUTLINE:
        return ReliableButton.secondaryOutlined(
          label: action.label,
          disabledSubject: action.disabledSubject,
          onPressed: () {
            if (action.dismisses) Navigator.of(context).pop();
            if (action.onPressed != null) action.onPressed!();
          },
        );
    }
  }

  Widget buildContent(BuildContext context);

  MarkdownStyleSheet getMarkdownStyle(BuildContext context) =>
      MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: ReliableTheme.of(context).textTheme.bodyMedium,
        textAlign: WrapAlignment.center,
        h1: ReliableTheme.of(context)
            .textTheme
            .bodyMedium
            .copyWith(fontWeight: FontWeight.bold),
        a: ReliableTheme.of(context)
            .textTheme
            .bodyMedium
            .copyWith(color: ReliableTheme.of(context).colorTheme.secondary),
      );

  Widget buildMarkdown(
    BuildContext context, {
    required String data,
    MarkdownTapLinkCallback? onTapLink,
  }) =>
      Markdown(
        extensionSet: md.ExtensionSet.gitHubWeb,
        padding: EdgeInsets.zero,
        styleSheet: getMarkdownStyle(context),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        data: data,
        onTapLink: onTapLink,
      );

  Widget buildTitle(BuildContext context) {
    final synergyTheme = ReliableTheme.of(context);
    return title != null && title != ''
        ? Column(
            children: [
              Text(
                title!,
                style: synergyTheme.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24.0,
              ),
            ],
          )
        : const Empty();
  }

  List<ReliableDialogButton> buildActions(BuildContext context) {
    return actions ?? [];
  }

  Future<T?> show({dismissible: true}) {
    return globalBloc.showReliableDialog(this, dismissible: dismissible);
  }
}

/// Right now very much the same as ReliableErrorDialog
class ReliableInfoDialog<T> extends ReliableDialog<T> {
  final String? title;
  // Not sure yet if we will ever have non-string contents,
  // so for now I allow either message or content
  final Widget? content;
  final String? subTitle;
  final List<ReliableDialogButton<T>>? actions;

  const ReliableInfoDialog({
    this.title,
    this.content,
    this.subTitle,
    this.actions = const [],
  })  : assert((subTitle != null) ^ (content != null),
            "One of them should be non null"),
        super(
          title: title,
          actions: actions,
        );
  const ReliableInfoDialog.small({
    this.title,
    this.content,
    this.subTitle,
    this.actions = const [],
  })  : assert((subTitle != null) ^ (content != null),
            "One of them should be non null"),
        super(
          title: title,
          actions: actions,
          margin: const EdgeInsets.all(36.0),
        );

  @override
  List<ReliableDialogButton> buildActions(BuildContext context);

  @override
  Widget buildContent(BuildContext context) {
    final synergyTheme = ReliableTheme.of(context);
    return content ??
        Text(
          subTitle ?? '',
          style: synergyTheme.secondaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        );
  }
}
