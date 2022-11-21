import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../../config/theme/reliable_themes.dart';
import '../behavior_subject_builder.dart';


class ReliableTextButton extends StatelessWidget {
  final String? label;
  final TextStyle? style;
  final Widget? child;
  final VoidCallback? onPressed;
  final BehaviorSubject<bool> disabled$;

  ReliableTextButton({
    Key? key,
    this.label,
    this.style,
    this.child,
    this.onPressed,
    BehaviorSubject<bool>? disabled$,
  })  : assert((label == null) ^ (child == null)),
        this.disabled$ =
            disabled$ != null ? disabled$ : BehaviorSubject.seeded(false),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BehaviorSubjectBuilder<bool>(
      subject: disabled$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        final disabled = snapshot.data ?? false;
        return TextButton(
          onPressed: disabled ? null : onPressed,
          child: child ?? Text(label!),
          style: ReliableTheme.of(context).buttonTheme.textButtonStyle.copyWith(
                textStyle: MaterialStateProperty.resolveWith(
                  (states) => ReliableTheme.of(context).textTheme.bodySmall,
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const RoundedRectangleBorder(side: BorderSide.none),
                ),
                elevation: MaterialStateProperty.all<double>(0),
                minimumSize: MaterialStateProperty.all<Size>(Size.zero),
                side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
        );
      },
    );
  }
}
