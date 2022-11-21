import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reliable_hands/config/export.dart';

import '../../dio_extention.dart';
import '../empty_widget.dart';
import '../placeholders.dart';
import 'reliable_dialog.dart';

class ReliableErrorDialog extends ReliableDialog {
  final Widget? image;
  final String message;
  final Color? bgColor;

  const ReliableErrorDialog({
    String? title,
    List<ReliableDialogButton>? actions,
    this.image,
    this.bgColor,
    required this.message,
  }) : super(title: title, actions: actions);

  @override
  Widget buildContent(context) {
    return Container(
      color: bgColor?? Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            image ?? const Empty(),
            buildMarkdown(
              context,
              data: message,
            ),
          ],
        ),
      ),
    );
  }

  @override
  SizedBox get distanceBetweenContentAndActionButtons =>
      const SizedBox(height: 12);

  @override
  List<ReliableDialogButton> buildActions(context) {
    return actions ?? [];
  }

  @override
  Widget buildTitle(context) {
    final synergyTheme = ReliableTheme.of(context);
    if (title != null) {
      return Text(title!,
          style: synergyTheme.textTheme.displayMedium,
          textAlign: TextAlign.center);
    }
    return const SizedBox();
  }
}

class ValidationErrorDialog extends ReliableErrorDialog {
  final List<ValidationError>? errors;
  final String? defaultMessage;

  ValidationErrorDialog.fromErrors({
    this.errors,
    this.defaultMessage,
    title,
    actions = const [ReliableDialogButton(label: 'OK', dismisses: true)],
  }) :
        // assert((errors == null) ^ (defaultMessage == null), 'One of them should be non null'),
        super(
            title: title,
            actions: actions,
            message: (errors == null || errors.length == 0)
                ? (defaultMessage!)
                // For now shows just the first error
                : ('${errors[0].message}'));

  factory ValidationErrorDialog.fromDioError(DioError e,
      {defaultMessage,
      title,
      actions = const [ReliableDialogButton(label: 'OK', dismisses: true)]}) {
//    assert(e.response.statusCode == 422,
//        'Are you sure you wanted a validation dialog? Status code is not 422.');
    final errors = ValidationError.fromDioError(e);
    return ValidationErrorDialog.fromErrors(
        errors: errors,
        defaultMessage: defaultMessage,
        title: title,
        actions: actions);
  }
}

class ConflictErrorDialog extends ReliableErrorDialog {
  final ConflictError? error;
  final String defaultMessage;

  ConflictErrorDialog.fromErrors({
    this.error,
    required this.defaultMessage,
    title,
    actions = const [ReliableDialogButton(label: 'OK', dismisses: true)],
  }) : super(
          title: title,
          actions: actions,
          message:
              (error?.hasMessage() == true) ? error!.message : defaultMessage,
        );

  factory ConflictErrorDialog.fromDioError(
    DioError e, {
    defaultMessage,
    title,
    actions = const [ReliableDialogButton(label: 'OK', dismisses: true)],
  }) {
//    assert(e.response.statusCode == 409,
//        'Are you sure you wanted a conflict dialog? Status code is not 422.');
    final error = ConflictError.fromDioError(e);
    return ConflictErrorDialog.fromErrors(
      error: error,
      defaultMessage: defaultMessage,
      title: title,
      actions: actions,
    );
  }
}

class BadRequestErrorDialog extends ReliableErrorDialog {
  final BadRequestError? error;
  final String defaultMessage;

  BadRequestErrorDialog.fromErrors({
    this.error,
    required this.defaultMessage,
    title,
    actions = const [ReliableDialogButton(label: 'OK', dismisses: true)],
  }) : super(
            title: title,
            actions: actions,
            message: (error?.hasMessage() == true)
                ? error!.message
                : defaultMessage);

  factory BadRequestErrorDialog.fromDioError(
    DioError e, {
    defaultMessage,
    title,
    actions = const [ReliableDialogButton(label: 'OK', dismisses: true)],
  }) {
    final error = BadRequestError.fromDioError(e);
    return BadRequestErrorDialog.fromErrors(
      error: error,
      defaultMessage: defaultMessage,
      title: title,
      actions: actions,
    );
  }
}

const ReliableErrorDialog noConnectionDialog = ReliableErrorDialog(
  title: 'Failed to connect',
  message:
      "We're struggling to reach the Reliable servers. Please check your connection and try again.",
  actions: [ReliableDialogButton(label: 'OK', dismisses: true)],
);

class DefaultErrorDialog extends ReliableErrorDialog {
  const DefaultErrorDialog({
    required String title,
    required String message,
    List<ReliableDialogButton>? actions = const [
      ReliableDialogButton(label: 'OK', dismisses: true)
    ],
  }) : super(
          title: title,
          actions: actions,
          message: message,
        );
}

class SomethingWentWrong extends ReliableErrorDialog {
  const SomethingWentWrong({
    String? title,
    String? message,
    Widget? errorImage,
    List<ReliableDialogButton>? actions,
  }) : super(
          message: message ??
              "Something really bad happened. "
                  "We already know about it 🙂."
                  "\n\nCare to try again? Maybe restart?",
          actions: actions ??
              const [
                ReliableDialogButton(
                  label: 'GO BACK',
                  dismisses: true,
                  dialogButtonType: DialogButtonTypes.PRIMARY,
                  icon: Icons.arrow_forward,
                ),
              ],
        );

  @override
  Widget buildContent(context) {
    final synergyTheme = ReliableTheme.of(context);
    return Column(
      children: [
        const ReliableOopsErrorPlaceholder(),
        const SizedBox(height: 24),
        Text(
          message,
          style: synergyTheme.textTheme.headingLarge
              .copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 24.0,
        ),
      ],
    );
  }
}

class NoConnectionErrorDialog extends ReliableErrorDialog {
  final String title;
  final String message;
  final Widget errorImage;
  final List<ReliableDialogButton> actions;

  const NoConnectionErrorDialog({
    this.title = 'No connection',
    this.message = "Please check your internet connection and try again.",
    this.errorImage = const WifiImage(),
    this.actions = const [
      ReliableDialogButton(
        label: 'OK',
        dismisses: true,
        dialogButtonType: DialogButtonTypes.SECONDARY,
      ),
    ],
  }) : super(
          title: title,
          message: message,
          actions: actions,
        );

  @override
  Widget buildContent(context) {
    final synergyTheme = ReliableTheme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            height: 120,
            child: const WifiImage(),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: synergyTheme.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24.0),
        Text(
          message,
          style: synergyTheme.secondaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget buildTitle(context) {
    return const SizedBox();
  }
}

class GenericTimeoutDialog extends ReliableErrorDialog {
  GenericTimeoutDialog({
    String? title,
    String? message,
    Widget? image,
    List<ReliableDialogButton>? actions,
  }) : super(
          title: title ?? 'Failed to connect',
          image: image,
          message: message ??
              'Reliable needs an active internet connection to start.' +
                  "Please make sure you're connected and try again.",
          actions: actions ??
              const [ReliableDialogButton(label: 'OK', dismisses: true)],
        ) {}
}
